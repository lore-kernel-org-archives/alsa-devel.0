From: Steve deRosier <derosier@pianodisc.com>
Subject: [PATCH] serial-u16550 driver.  Fixes buffer blocking bug
Date: Wed, 29 Oct 2003 13:47:49 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FA03585.1000901@pianodisc.com>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am submitting a patch to the serial-u16550 driver fix a bug 
that we have encountered.  Basically, when using the 
SNDRV_SERIAL_GENERIC adaptor in the serial-u16550 MIDI driver,
if the device becomes unplugged or some other condition where
the device stops signaling CTS, the send buffer backs up.
This is fine and expected opperation, except on a prolonged
problem (with our music, about 30-40 minutes typically) the
buffer itself gets full.  It is supposed to then just throw 
away data, but it seems that it doesn't operate quite right
and it ends up backing up data in rawmidi.  When this 
happens, the driver basically locks up (though "send direct"
data still gets out), and only on a close and reopen of the
device will recover.  

This patch fixes the problem, by modifiying how it checks
for and handles its internal buffer:

1. Move all checks of buffer overflow and such to the 
actual buffer write and read routines.  This makes
the buffer routines more robust and encaspulates buffer
opperations better.
2. Always try to send data to the buffers.  Don't interupt
normal opperation of the algoritim because buffers are full.
This was what was actually causing the data to be left in 
rawmidi and thus causing it to lock up.  This is helped
by moving the buffer size checks into the routines.
3. When able to write, drain output as necessary instead of
only writing one byte at a time.  This was causing us to 
backup eventually anyway since we usually write more than 
one byte of data.

This fixes a bug that we were encountering in the driver,
and I'm pretty sure it shouldn't cause any problems 
with the other devices that use this driver.  If anyone has 
the other devices to test on, please test away.

Thanks,

- Steve


------

Change log entry:  Fixes problem where buffers fill up with SNDRV_SERIAL_GENERIC adaptor
                   when device doesn't signal CTS.

Index: serial-u16550.c
===================================================================
RCS file: /home/cvsroot/alsa/alsa-kernel/drivers/serial-u16550.c,v
retrieving revision 1.22
diff -c -3 -p -r1.22 serial-u16550.c
*** serial-u16550.c     2003/10/14 13:08:13     1.22
--- serial-u16550.c     2003/10/29 21:19:08
*************** inline static void snd_uart16550_del_tim
*** 194,205 ****
  inline static void snd_uart16550_buffer_output(snd_uart16550_t *uart)
  {
        unsigned short buff_out = uart->buff_out;
!       outb(uart->tx_buff[buff_out], uart->base + UART_TX);
!       uart->fifo_count++;
!       buff_out++;
!       buff_out &= TX_BUFF_MASK;
!       uart->buff_out = buff_out;
!       uart->buff_in_count--;
  }

  /* This loop should be called with interrupts disabled
--- 194,208 ----
  inline static void snd_uart16550_buffer_output(snd_uart16550_t *uart)
  {
        unsigned short buff_out = uart->buff_out;
!       if( uart->buff_in_count > 0 )
!       {
!               outb(uart->tx_buff[buff_out], uart->base + UART_TX);
!               uart->fifo_count++;
!               buff_out++;
!               buff_out &= TX_BUFF_MASK;
!               uart->buff_out = buff_out;
!               uart->buff_in_count--;
!       }
  }

  /* This loop should be called with interrupts disabled
*************** static void snd_uart16550_io_loop(snd_ua
*** 257,265 ****
           || uart->adaptor == SNDRV_SERIAL_GENERIC) {
                /* Can't use FIFO, must send only when CTS is true */
                status = inb(uart->base + UART_MSR);
!               if (uart->fifo_count == 0 && (status & UART_MSR_CTS)
!                   && uart->buff_in_count > 0)
!                       snd_uart16550_buffer_output(uart);
        } else {
                /* Write loop */
                while (uart->fifo_count < uart->fifo_limit      /* Can we write ? */
--- 260,271 ----
           || uart->adaptor == SNDRV_SERIAL_GENERIC) {
                /* Can't use FIFO, must send only when CTS is true */
                status = inb(uart->base + UART_MSR);
!               while( (uart->fifo_count == 0) && (status & UART_MSR_CTS) &&
!                        (uart->buff_in_count > 0) )
!               {
!                       snd_uart16550_buffer_output(uart);
!                       status = inb( uart->base + UART_MSR );
!               }
        } else {
                /* Write loop */
                while (uart->fifo_count < uart->fifo_limit      /* Can we write ? */
*************** static int snd_uart16550_output_close(sn
*** 579,591 ****
  inline static void snd_uart16550_write_buffer(snd_uart16550_t *uart, unsigned char byte)
  {
        unsigned short buff_in = uart->buff_in;
!       uart->tx_buff[buff_in] = byte;
!       buff_in++;
!       buff_in &= TX_BUFF_MASK;
!       uart->buff_in = buff_in;
!       uart->buff_in_count++;
!       if (uart->irq < 0) /* polling mode */
!               snd_uart16550_add_timer(uart);
  }

  static void snd_uart16550_output_byte(snd_uart16550_t *uart, snd_rawmidi_substream_t * substream, unsigned char midi_byte)
--- 585,600 ----
  inline static void snd_uart16550_write_buffer(snd_uart16550_t *uart, unsigned char byte)
  {
        unsigned short buff_in = uart->buff_in;
!       if( uart->buff_in_count < TX_BUFF_SIZE )
!       {
!               uart->tx_buff[buff_in] = byte;
!               buff_in++;
!               buff_in &= TX_BUFF_MASK;
!               uart->buff_in = buff_in;
!               uart->buff_in_count++;
!               if (uart->irq < 0) /* polling mode */
!                       snd_uart16550_add_timer(uart);
!       }
  }

  static void snd_uart16550_output_byte(snd_uart16550_t *uart, snd_rawmidi_substream_t * substream, unsigned char midi_byte)
*************** static void snd_uart16550_output_byte(sn
*** 614,620 ****
                if (uart->buff_in_count >= TX_BUFF_SIZE) {
                        snd_printk("%s: Buffer overrun on device at 0x%lx\n",
                                   uart->rmidi->name, uart->base);
-                       return;
                }
                snd_uart16550_write_buffer(uart, midi_byte);
        }
--- 623,628 ----
*************** static void snd_uart16550_output_write(s
*** 669,678 ****
                                uart->adaptor == SNDRV_SERIAL_GENERIC) &&
                           (uart->prev_out != substream->number || jiffies-lasttime > 3*HZ)) {

-                               /* We will need three bytes of data here (worst case). */
-                               if (uart->buff_in_count >= TX_BUFF_SIZE - 3)
-                                       break;
-
                                /* Roland Soundcanvas part selection */
                                /* If this substream of the data is different previous
                                   substream in this uart, send the change part event */
--- 677,682 ----
*************** static void snd_uart16550_output_write(s
*** 685,694 ****
                                if ((midi_byte < 0x80) && (uart->adaptor == SNDRV_SERIAL_SOUNDCANVAS))
                                        snd_uart16550_output_byte(uart, substream, uart->prev_status[uart->prev_out]);
                        }
-
-                       /* buffer full? */
-                       if (uart->buff_in_count >= TX_BUFF_SIZE)
-                               break;

                        /* send midi byte */
                        snd_uart16550_output_byte(uart, substream, midi_byte);
--- 689,694 ----



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
