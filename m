From: Steve deRosier <derosier@pianodisc.com>
Subject: [PATCH] serial-u16550 driver.  Fixes buffer blocking bug (2nd try)
Date: Tue, 02 Dec 2003 17:41:13 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCD3F39.5050902@pianodisc.com>
References: <3FA03585.1000901@pianodisc.com>	<s5hn0biyj9z.wl@alsa2.suse.de>	<3FA183B1.3090706@pianodisc.com> <s5hn0bhuwjg.wl@alsa2.suse.de>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0bhuwjg.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi,

I've completed my changes on the serial-u16550 driver.  I have 
implemented most of your suggestions to my previous patch.  Now:

* There is a user selectable flag "droponfull".  Set to 1 and
  any new bytes delivered to the driver after the buffer fills
  up will be discarded until the buffer is able to flush some
  bytes.
* If droponfull==0 (or is not set, the default is 0), the driver
  proceeds to block further input by not calling 
  snd_rawmidi_transmit_ack() and aborting the attempt.  It will
  try again later.
* I've redone a bit of the interface for the buffer routines.  
  This was done to support the proper blocking/non-blocking methods
  as spelled out above, and to try to protect the buffer data a bit.  

So, if droponfull==0, we operate as originally desired (but the 
original implementation was broken a bit and this fixes it).  If
droponfull==1 we now discard new bytes if our buffer is full; this
behavior fixes the driver "hang" problem we were having.

The changes should have no material effect on the "SNDRV_SERIAL_MS124W_MB"
device, and all others should still work well, though we can only
test with the SNDRV_SERIAL_GENERIC. 

Please commit this at your earliest opportunity.

Thanks,
- Steve

----------------
Change log entry:  Fixes problem where buffers fill up with SNDRV_SERIAL_GENERIC adaptor
                   when device doesn't signal CTS by dropping new bytes if the module
                   parameter "droponfull" == 1.


Index: serial-u16550.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/serial-u16550.c,v
retrieving revision 1.22
diff -u -p -r1.22 serial-u16550.c
--- serial-u16550.c     14 Oct 2003 13:08:13 -0000      1.22
+++ serial-u16550.c     3 Dec 2003 01:14:42 -0000
@@ -63,6 +63,9 @@ static char *adaptor_names[] = {
        "Generic"
 };

+#define SNDRV_SERIAL_NORMALBUFF 0 /* Normal blocking buffer operation */
+#define SNDRV_SERIAL_DROPBUFF   1 /* Non-blocking discard operation */
+
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;     /* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;      /* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE; /* Enable this card */
@@ -73,6 +76,7 @@ static int base[SNDRV_CARDS] = {[0 ... (
 static int outs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};         /* 1 to 16 */
 static int ins[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1}; /* 1 to 16 */
 static int adaptor[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = SNDRV_SERIAL_SOUNDCANVAS};
+static int droponfull[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS -1)] = SNDRV_SERIAL_NORMALBUFF };

 MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(index, "Index value for Serial MIDI.");
@@ -99,6 +103,9 @@ MODULE_PARM(outs, "1-" __MODULE_STRING(S
 MODULE_PARM_DESC(outs, "Number of MIDI outputs.");
 MODULE_PARM(ins, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(ins, "Number of MIDI inputs.");
+MODULE_PARM(droponfull, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(droponfull, "Flag to enable drop-on-full buffer mode");
+MODULE_PARM_SYNTAX(droponfull, SNDRV_ENABLED "," SNDRV_BOOLEAN_FALSE_DESC);

 MODULE_PARM_SYNTAX(outs, SNDRV_ENABLED ",allows:{{1,16}},dialog:list");
 MODULE_PARM_SYNTAX(ins, SNDRV_ENABLED ",allows:{{1,16}},dialog:list");
@@ -163,6 +170,7 @@ typedef struct _snd_uart16550 {
        int buff_in_count;
         int buff_in;
         int buff_out;
+        int drop_on_full;

        // wait timer
        unsigned int timer_running:1;
@@ -194,12 +202,15 @@ inline static void snd_uart16550_del_tim
 inline static void snd_uart16550_buffer_output(snd_uart16550_t *uart)
 {
        unsigned short buff_out = uart->buff_out;
-       outb(uart->tx_buff[buff_out], uart->base + UART_TX);
-       uart->fifo_count++;
-       buff_out++;
-       buff_out &= TX_BUFF_MASK;
-       uart->buff_out = buff_out;
-       uart->buff_in_count--;
+       if( uart->buff_in_count > 0 )
+       {
+               outb(uart->tx_buff[buff_out], uart->base + UART_TX);
+               uart->fifo_count++;
+               buff_out++;
+               buff_out &= TX_BUFF_MASK;
+               uart->buff_out = buff_out;
+               uart->buff_in_count--;
+       }
 }

 /* This loop should be called with interrupts disabled
@@ -257,9 +268,12 @@ static void snd_uart16550_io_loop(snd_ua
           || uart->adaptor == SNDRV_SERIAL_GENERIC) {
                /* Can't use FIFO, must send only when CTS is true */
                status = inb(uart->base + UART_MSR);
-               if (uart->fifo_count == 0 && (status & UART_MSR_CTS)
-                   && uart->buff_in_count > 0)
-                       snd_uart16550_buffer_output(uart);
+               while( (uart->fifo_count == 0) && (status & UART_MSR_CTS) &&
+                      (uart->buff_in_count > 0) )
+               {
+                       snd_uart16550_buffer_output(uart);
+                       status = inb( uart->base + UART_MSR );
+               }
        } else {
                /* Write loop */
                while (uart->fifo_count < uart->fifo_limit      /* Can we write ? */
@@ -576,19 +590,33 @@ static int snd_uart16550_output_close(sn
        return 0;
 };

-inline static void snd_uart16550_write_buffer(snd_uart16550_t *uart, unsigned char byte)
+inline static int snd_uart16550_buffer_can_write( snd_uart16550_t *uart, int Num )
 {
-       unsigned short buff_in = uart->buff_in;
-       uart->tx_buff[buff_in] = byte;
-       buff_in++;
-       buff_in &= TX_BUFF_MASK;
-       uart->buff_in = buff_in;
-       uart->buff_in_count++;
-       if (uart->irq < 0) /* polling mode */
-               snd_uart16550_add_timer(uart);
+       if( uart->buff_in_count + Num < TX_BUFF_SIZE )
+               return 1;
+       else
+               return 0;
 }

-static void snd_uart16550_output_byte(snd_uart16550_t *uart, snd_rawmidi_substream_t * substream, unsigned char midi_byte)
+inline static int snd_uart16550_write_buffer(snd_uart16550_t *uart, unsigned char byte)
+{
+       unsigned short buff_in = uart->buff_in;
+       if( uart->buff_in_count < TX_BUFF_SIZE )
+       {
+               uart->tx_buff[buff_in] = byte;
+               buff_in++;
+               buff_in &= TX_BUFF_MASK;
+               uart->buff_in = buff_in;
+               uart->buff_in_count++;
+               if (uart->irq < 0) /* polling mode */
+                       snd_uart16550_add_timer(uart);
+               return 1;
+       }
+       else
+               return 0;
+}
+
+static int snd_uart16550_output_byte(snd_uart16550_t *uart, snd_rawmidi_substream_t * substream, unsigned char midi_byte)
 {
        if (uart->buff_in_count == 0                            /* Buffer empty? */
            && ((uart->adaptor != SNDRV_SERIAL_MS124W_SA &&
@@ -611,13 +639,14 @@ static void snd_uart16550_output_byte(sn
                        }
                }
        } else {
-               if (uart->buff_in_count >= TX_BUFF_SIZE) {
+               if( !snd_uart16550_write_buffer(uart, midi_byte) ) {
                        snd_printk("%s: Buffer overrun on device at 0x%lx\n",
                                   uart->rmidi->name, uart->base);
-                       return;
+                       return 0;
                }
-               snd_uart16550_write_buffer(uart, midi_byte);
        }
+
+       return 1;
 }

 static void snd_uart16550_output_write(snd_rawmidi_substream_t * substream)
@@ -661,40 +690,41 @@ static void snd_uart16550_output_write(s
                }
        } else {
                first = 0;
-               while (1) {
-                       if (snd_rawmidi_transmit(substream, &midi_byte, 1) != 1)
-                               break;
+               while( 1 == snd_rawmidi_transmit_peek(substream, &midi_byte, 1) )
+               {
                        /* Also send F5 after 3 seconds with no data to handle device disconnect */
                        if (first == 0 && (uart->adaptor == SNDRV_SERIAL_SOUNDCANVAS ||
                                uart->adaptor == SNDRV_SERIAL_GENERIC) &&
                           (uart->prev_out != substream->number || jiffies-lasttime > 3*HZ)) {

-                               /* We will need three bytes of data here (worst case). */
-                               if (uart->buff_in_count >= TX_BUFF_SIZE - 3)
-                                       break;
-
-                               /* Roland Soundcanvas part selection */
-                               /* If this substream of the data is different previous
-                                  substream in this uart, send the change part event */
-                               uart->prev_out = substream->number;
-                               /* change part */
-                               snd_uart16550_output_byte(uart, substream, 0xf5);
-                               /* data */
-                               snd_uart16550_output_byte(uart, substream, uart->prev_out + 1);
-                               /* If midi_byte is a data byte, send the previous status byte */
-                               if ((midi_byte < 0x80) && (uart->adaptor == SNDRV_SERIAL_SOUNDCANVAS))
-                                       snd_uart16550_output_byte(uart, substream, uart->prev_status[uart->prev_out]);
-                       }
+                              if( snd_uart16550_buffer_can_write( uart, 3 ) )
+                              {
+                                      /* Roland Soundcanvas part selection */
+                                      /* If this substream of the data is different previous
+                                         substream in this uart, send the change part event */
+                                      uart->prev_out = substream->number;
+                                      /* change part */
+                                      snd_uart16550_output_byte(uart, substream, 0xf5);
+                                      /* data */
+                                      snd_uart16550_output_byte(uart, substream, uart->prev_out + 1);
+                                      /* If midi_byte is a data byte, send the previous status byte */
+                                      if ((midi_byte < 0x80) && (uart->adaptor == SNDRV_SERIAL_SOUNDCANVAS))
+                                            snd_uart16550_output_byte(uart, substream, uart->prev_status[uart->prev_out]);
+                              }
+                              else if( !uart->drop_on_full )
+                                      break;

-                       /* buffer full? */
-                       if (uart->buff_in_count >= TX_BUFF_SIZE)
-                               break;
+                       }

                        /* send midi byte */
-                       snd_uart16550_output_byte(uart, substream, midi_byte);
+                       if( !snd_uart16550_output_byte(uart, substream, midi_byte) && !uart->drop_on_full )
+                               break;
+
                        if (midi_byte >= 0x80 && midi_byte < 0xf0)
                                uart->prev_status[uart->prev_out] = midi_byte;
                        first = 1;
+
+                       snd_rawmidi_transmit_ack( substream, 1 );
                }
                lasttime = jiffies;
        }
@@ -755,6 +785,7 @@ static int __init snd_uart16550_create(s
                                       unsigned int speed,
                                       unsigned int base,
                                       int adaptor,
+                                      int droponfull,
                                       snd_uart16550_t **ruart)
 {
        static snd_device_ops_t ops = {
@@ -771,6 +802,7 @@ static int __init snd_uart16550_create(s
        spin_lock_init(&uart->open_lock);
        uart->irq = -1;
        uart->base = iobase;
+       uart->drop_on_full = droponfull;

        if ((err = snd_uart16550_detect(uart)) <= 0) {
                printk(KERN_ERR "no UART detected at 0x%lx\n", iobase);
@@ -900,6 +932,7 @@ static int __init snd_serial_probe(int d
                                        speed[dev],
                                        base[dev],
                                        adaptor[dev],
+                                       droponfull[dev],
                                        &uart)) < 0) {
                snd_card_free(card);
                return err;
@@ -910,7 +943,7 @@ static int __init snd_serial_probe(int d
                return err;
        }

-       sprintf(card->longname, "%s at 0x%lx, irq %d speed %d div %d outs %d ins %d adaptor %s",
+       sprintf(card->longname, "%s at 0x%lx, irq %d speed %d div %d outs %d ins %d adaptor %s droponfull %d",
                card->shortname,
                uart->base,
                uart->irq,
@@ -918,7 +951,8 @@ static int __init snd_serial_probe(int d
                (int)uart->divisor,
                outs[dev],
                ins[dev],
-               adaptor_names[uart->adaptor]);
+               adaptor_names[uart->adaptor],
+               uart->drop_on_full);

        if ((err = snd_card_register(card)) < 0) {
                snd_card_free(card);
@@ -964,7 +998,7 @@ module_exit(alsa_card_serial_exit)

 /* format is: snd-serial=enable,index,id,
                         port,irq,speed,base,outs,
-                        ins,adaptor */
+                        ins,adaptor,droponfull */

 static int __init alsa_card_serial_setup(char *str)
 {
@@ -981,7 +1015,8 @@ static int __init alsa_card_serial_setup
               get_option(&str,&base[nr_dev]) == 2 &&
               get_option(&str,&outs[nr_dev]) == 2 &&
               get_option(&str,&ins[nr_dev]) == 2 &&
-              get_option(&str,&adaptor[nr_dev]) == 2);
+              get_option(&str,&adaptor[nr_dev]) == 2 &&
+              get_option(&str,&droponfull[nr_dev]) == 2 );
        nr_dev++;
        return 1;
 }



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
