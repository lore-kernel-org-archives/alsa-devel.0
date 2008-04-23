From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: MIDI on ice1724 - long delays
Date: Wed, 23 Apr 2008 22:19:04 +0200
Message-ID: <480F99B8.3010408@insite.cz>
References: <480E495B.20607@insite.cz> <s5h63u8evih.wl%tiwai@suse.de>
	<480F189A.7030500@insite.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060702040703080702070200"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 0742F24718
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 22:19:11 +0200 (CEST)
In-Reply-To: <480F189A.7030500@insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060702040703080702070200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Hofman wrote:
> Takashi Iwai wrote:
>> At Tue, 22 Apr 2008 22:23:55 +0200,
>> Pavel Hofman wrote:
>>> Hi,
>>>
> ...........
>>> After the playback stops, the interrupts are gone too. It seems as if 
>>> the playback interrupt initiates the MPU TX interrupt.
>>>
>>> If we could avoid generating the MPU TX interrupt during regular 
>>> playback, I believe the major problem would be resolved.
>>>
>>> Even if I mask the interrupts (CCS01) and do not explicitly unmask them 
>>> (according to proc ice1724 the CCS01 register stays at 0xa0), the 
>>> interrupt gets generated.
>> OK, then the simplest way would be to just ignore the TX bit at the
>> second or later check.
>>
>> How about the patch below?
> 
> Takashi, thanks for the hack idea. The overhead is just one more loop 
> which is nothing. I will test it and post details of further problems 
> (there is a bunch of them :) )
> 

Hi,

The hack works fine, I am finally getting no CPU burning during playback 
and  MIDI input/output.

Now the next problem are delays. amidi through ice1724 prints the 
rawmidi data a fraction of a second later compared to USB midi input. I 
guess there is not much we could do about it. The format is a bit 
different which probably does not matter:

pavel@nahore:~$ amidi -l
Dir Device    Name
IO  hw:0,0    Audiotrak Prodigy 192 MIDI
IO  hw:1,0,0  Keystation Pro 88 MIDI 1
I   hw:1,0,1  Keystation Pro 88 MIDI 2

ice1724 midi:
pavel@nahore:~$ amidi -p hw:0 -d

90 2D 5E
    2D 00
90 30 79
    30 00

USB midi:
pavel@nahore:~$ amidi -p hw:1 -d

90 2D 4C
90 2D 00
90 30 5E
90 30 00

However, what makes a huge delay difference is the next step - aseqdump. 
Here USB still outputs data immediately:

pavel@nahore:~$ aseqdump -p 20:0
Waiting for data. Press Ctrl+C to end.
Source_ Event_________________ Ch _Data__
  20:0   Note on                 0  41  94
  20:0   Note on                 0  41   0
  20:0   Note on                 0  45  80
  20:0   Note on                 0  45   0



Whereas through ice1724 midi it takes several seconds for the same notes 
to appear in aseqdump:

pavel@nahore:~$ aseqdump -p 16:0
Waiting for data. Press Ctrl+C to end.
Source_ Event_________________ Ch _Data__
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Note on                 0  43  86
  16:0   Note on                 0  43   0
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Note on                 0  47 100
  16:0   Note on                 0  47   0
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing
  16:0   Active Sensing

Google told me the "Active Sensing" messages are OK. Still, the whole 
pack of lines appears at once, but with a huge delay.

When hooking Qsynth to the inputs, notes through USB sound immediately, 
Notes through ice1724 get delayed by several seconds, but mostly they 
produce no sound at all. Surprisingly, the few notes which actually make 
it through sound long (just like the piano sustain pedal). USB notes do 
not have this effect.

Please make respective fixes to the enclosed patch as it involves some 
changes that make the MPU401 actually work.

Thanks a lot for advice and suggestions.

Pavel.




--------------060702040703080702070200
Content-Type: text/x-patch;
 name="mpu401-v2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpu401-v2.diff"

diff -r f8fbce7ba459 drivers/mpu401/mpu401_uart.c
--- a/drivers/mpu401/mpu401_uart.c	Tue Apr 22 18:39:49 2008 +0200
+++ b/drivers/mpu401/mpu401_uart.c	Wed Apr 23 22:09:53 2008 +0200
@@ -49,12 +49,10 @@ static void snd_mpu401_uart_output_write
 
  */
 
-#define snd_mpu401_input_avail(mpu)	(!(mpu->read(mpu, MPU401C(mpu)) & 0x80))
-#define snd_mpu401_output_ready(mpu)	(!(mpu->read(mpu, MPU401C(mpu)) & 0x40))
-
-#define MPU401_RESET		0xff
-#define MPU401_ENTER_UART	0x3f
-#define MPU401_ACK		0xfe
+#define snd_mpu401_input_avail(mpu) \
+	(!(mpu->read(mpu, MPU401C(mpu)) & MPU401_RX_EMPTY))
+#define snd_mpu401_output_ready(mpu) \
+	(!(mpu->read(mpu, MPU401C(mpu)) & MPU401_TX_FULL))
 
 /* Build in lowlevel io */
 static void mpu401_write_port(struct snd_mpu401 *mpu, unsigned char data,
@@ -245,7 +243,7 @@ static int snd_mpu401_uart_cmd(struct sn
 #endif
 	}
 	mpu->write(mpu, cmd, MPU401C(mpu));
-	if (ack) {
+	if (ack && !(mpu->info_flags & MPU401_INFO_NO_ACK)) {
 		ok = 0;
 		timeout = 10000;
 		while (!ok && timeout-- > 0) {
@@ -427,15 +425,15 @@ static void snd_mpu401_uart_output_write
 	unsigned char byte;
 	int max = 256;
 
-	do {
+	do {	
 		if (snd_rawmidi_transmit_peek(mpu->substream_output,
-					      &byte, 1) == 1) {
+					&byte, 1) == 1) {
 			/*
 			 * Try twice because there is hardware that insists on
 			 * setting the output busy bit after each write.
 			 */
 			if (!snd_mpu401_output_ready(mpu) &&
-			    !snd_mpu401_output_ready(mpu))
+					!snd_mpu401_output_ready(mpu))
 				break;	/* Tx FIFO full - try again later */
 			mpu->write(mpu, byte, MPU401D(mpu));
 			snd_rawmidi_transmit_ack(mpu->substream_output, 1);
diff -r f8fbce7ba459 include/mpu401.h
--- a/include/mpu401.h	Tue Apr 22 18:39:49 2008 +0200
+++ b/include/mpu401.h	Wed Apr 23 22:09:53 2008 +0200
@@ -50,6 +50,7 @@
 #define MPU401_INFO_INTEGRATED	(1 << 2)	/* integrated h/w port */
 #define MPU401_INFO_MMIO	(1 << 3)	/* MMIO access */
 #define MPU401_INFO_TX_IRQ	(1 << 4)	/* independent TX irq */
+#define MPU401_INFO_NO_ACK	(1 << 6)	/* No ACK cmd needed */
 
 #define MPU401_MODE_BIT_INPUT		0
 #define MPU401_MODE_BIT_OUTPUT		1
@@ -103,6 +104,21 @@ struct snd_mpu401 {
 #define MPU401D(mpu) (mpu)->port
 
 /*
+ * control register bits
+ */
+/* read MPU401C() */
+#define MPU401_RX_EMPTY		0x80
+#define MPU401_TX_FULL		0x40
+
+/* write MPU401C() */
+#define MPU401_RESET		0xff
+#define MPU401_ENTER_UART	0x3f
+
+/* read MPU401D() */
+#define MPU401_ACK		0xfe
+
+
+/*
 
  */
 
diff -r f8fbce7ba459 pci/ice1712/ice1724.c
--- a/pci/ice1712/ice1724.c	Tue Apr 22 18:39:49 2008 +0200
+++ b/pci/ice1712/ice1724.c	Wed Apr 23 22:09:53 2008 +0200
@@ -223,31 +223,89 @@ static unsigned int snd_vt1724_get_gpio_
 }
 
 /*
+ * MPU401 accessor
+ */
+static unsigned char snd_vt1724_mpu401_read(struct snd_mpu401 *mpu,
+					    unsigned long addr)
+{
+	/* fix status bits to the standard position */
+	/* only RX_EMPTY and TX_FULL are checked */
+	if (addr == MPU401C(mpu))
+		return (inb(addr) & 0x0c) << 4;
+	else
+		return inb(addr);
+}
+ 
+static void snd_vt1724_mpu401_write(struct snd_mpu401 *mpu,
+				    unsigned char data, unsigned long addr)
+{
+	//printk(KERN_DEBUG "snd_vt1724_mpu401_write: data 0x%02x, addr 0x%02lx, MPU401C 0x%02lx\n", data, addr, MPU401C(mpu));
+	if (addr == MPU401C(mpu)) {
+		if (data == MPU401_ENTER_UART)
+			outb(0x01, addr);
+		/* what else? */
+	} else
+		outb(data, addr);
+}
+ 
+
+/*
  *  Interrupt handler
  */
 
 static irqreturn_t snd_vt1724_interrupt(int irq, void *dev_id)
 {
 	struct snd_ice1712 *ice = dev_id;
+	unsigned char status_mask =
+		VT1724_IRQ_MPU_RX | VT1724_IRQ_MPU_TX | VT1724_IRQ_MTPCM;
 	unsigned char status;
 	int handled = 0;
+#ifdef CONFIG_SND_DEBUG
+	int timeout = 0;
+#endif
 
 	while (1) {
 		status = inb(ICEREG1724(ice, IRQSTAT));
+		status &= status_mask;
 		if (status == 0)
 			break;
-
+		/* printk(KERN_DEBUG "VT1724 interrupt: status 0x%02x\n", status); */
+#ifdef CONFIG_SND_DEBUG
+		if (++timeout > 10) {
+			printk(KERN_ERR
+			       "ice1724: Too long irq loop, status = 0x%x\n",
+			       status);
+			break;
+		}
+#endif
 		handled = 1;		
-		/* these should probably be separated at some point, 
-		 * but as we don't currently have MPU support on the board
-		 * I will leave it
-		 */
-		if ((status & VT1724_IRQ_MPU_RX)||(status & VT1724_IRQ_MPU_TX)) {
+		if (status & VT1724_IRQ_MPU_TX) {
+			if (ice->rmidi[0]) {
+				snd_mpu401_uart_interrupt_tx(irq,
+					ice->rmidi[0]->private_data);
+			}
+			else /* disable TX to be sure */
+				outb(inb(ICEREG1724(ice, IRQMASK)) |
+				     VT1724_IRQ_MPU_TX,
+				     ICEREG1724(ice, IRQMASK));
+			/* Due to mysterical reasons, MPU_TX is always
+			 * generated (and can't be cleared) when a PCM
+			 * playback is going.  So let's ignore at the
+			 * next loop.
+			 */
+			status_mask &= ~VT1724_IRQ_MPU_TX;
+		}
+		if (status & VT1724_IRQ_MPU_RX) {
 			if (ice->rmidi[0])
-				snd_mpu401_uart_interrupt(irq, ice->rmidi[0]->private_data);
-			outb(status & (VT1724_IRQ_MPU_RX|VT1724_IRQ_MPU_TX), ICEREG1724(ice, IRQSTAT));
-			status &= ~(VT1724_IRQ_MPU_RX|VT1724_IRQ_MPU_TX);
+				snd_mpu401_uart_interrupt(irq,
+					ice->rmidi[0]->private_data);
+			else /* disable RX to be sure */
+				outb(inb(ICEREG1724(ice, IRQMASK)) |
+				     VT1724_IRQ_MPU_RX,
+				     ICEREG1724(ice, IRQMASK));
 		}
+		/* ack MPU irq */
+		outb(status, ICEREG1724(ice, IRQSTAT));
 		if (status & VT1724_IRQ_MTPCM) {
 			/*
 			 * Multi-track PCM
@@ -2235,11 +2293,8 @@ static int __devinit snd_vt1724_create(s
 		return -EIO;
 	}
 
-	/* unmask used interrupts */
-	if (! (ice->eeprom.data[ICE_EEP2_SYSCONF] & VT1724_CFG_MPU401))
-		mask = VT1724_IRQ_MPU_RX | VT1724_IRQ_MPU_TX;
-	else
-		mask = 0;
+	/* mask (turn off) MPU interrupts */
+	mask = VT1724_IRQ_MPU_RX | VT1724_IRQ_MPU_TX;
 	outb(mask, ICEREG1724(ice, IRQMASK));
 	/* don't handle FIFO overrun/underruns (just yet),
 	 * since they cause machine lockups
@@ -2373,14 +2428,32 @@ static int __devinit snd_vt1724_probe(st
 
 	if (! c->no_mpu401) {
 		if (ice->eeprom.data[ICE_EEP2_SYSCONF] & VT1724_CFG_MPU401) {
+			struct snd_mpu401 *mpu;
 			if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ICE1712,
 						       ICEREG1724(ice, MPU_CTRL),
-						       MPU401_INFO_INTEGRATED,
+						       (MPU401_INFO_INTEGRATED |
+							MPU401_INFO_NO_ACK |
+							MPU401_INFO_TX_IRQ |
+							MPU401_INFO_INPUT |
+							MPU401_INFO_OUTPUT),
 						       ice->irq, 0,
 						       &ice->rmidi[0])) < 0) {
 				snd_card_free(card);
 				return err;
 			}
+			mpu = ice->rmidi[0]->private_data;
+			mpu->read = snd_vt1724_mpu401_read;
+			mpu->write = snd_vt1724_mpu401_write;
+			/* unmask MPU RX/TX irqs */
+			outb(inb(ICEREG1724(ice, IRQMASK)) &
+			     ~(VT1724_IRQ_MPU_RX | VT1724_IRQ_MPU_TX),
+			     ICEREG1724(ice, IRQMASK));
+#if 0 /* for testing */
+			/* set watermarks */
+			outb(VT1724_MPU_RX_FIFO | 0x01,
+			     ICEREG1724(ice, MPU_FIFO_WM));
+			outb(0x01, ICEREG1724(ice, MPU_FIFO_WM));
+#endif
 		}
 	}
 
diff -r f8fbce7ba459 pci/ice1712/prodigy192.c
--- a/pci/ice1712/prodigy192.c	Tue Apr 22 18:39:49 2008 +0200
+++ b/pci/ice1712/prodigy192.c	Wed Apr 23 22:09:54 2008 +0200
@@ -815,7 +815,7 @@ struct snd_ice1712_card_info snd_vt1724_
 		/* the current MPU401 code loops infinitely
 		 * when opening midi device
 		 */
-		.no_mpu401 = 1,
+		.no_mpu401 = 0,
 	},
 	{ } /* terminator */
 };

--------------060702040703080702070200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060702040703080702070200--
