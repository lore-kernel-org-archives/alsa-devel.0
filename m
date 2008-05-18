From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: PATCH - MIDI on ice1724 - real-time kernel problem
 SOLVED
Date: Sun, 18 May 2008 22:02:20 +0200
Message-ID: <48308B4C.2030906@insite.cz>
References: <480E495B.20607@insite.cz>	<s5h63u8evih.wl%tiwai@suse.de>	<480F189A.7030500@insite.cz>	<480F99B8.3010408@insite.cz>	<s5hod7zb4j7.wl%tiwai@suse.de>	<4810F1FA.4020300@insite.cz>	<s5hhcdq4fnz.wl%tiwai@suse.de>	<481182EB.1010800@insite.cz>	<s5h63u64dgt.wl%tiwai@suse.de>	<4818D18E.5040409@insite.cz>	<s5htzhgub9a.wl%tiwai@suse.de>	<481CB902.9080905@insite.cz>	<s5hd4nyh0lz.wl%tiwai@suse.de>
	<48235617.2070906@insite.cz> <482BE45E.1060401@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090706050300030002050905"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 68F19243CF
	for <alsa-devel@alsa-project.org>;
	Sun, 18 May 2008 22:02:27 +0200 (CEST)
In-Reply-To: <482BE45E.1060401@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090706050300030002050905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Clemens Ladisch wrote:
> Pavel Hofman wrote:
>> Actually, when does the MPU_TX interrupt get thrown? Upon exhausting
>> some output buffer?
> 
> According to the datasheet, when the number of bytes in the TX FIFO goes
> below the watermark value (for some unspecified value of "below").
> 
> Is there a reason why the watermarks are set to 1 and not to 0?
> 
> 
> Anyway, this hardware is not compatible with the MPU-401, so we should
> not try to twist the MPU-401 code into working with it.  Please try the
> patch below (not tested, I don't have the hardware).
> 

Clemens,

Thanks a lot. After a few pointer fixes to make it compile your code 
works flawlessly for both the generic as well as realtime ubuntu kernel.

I am enclosing the functioning patch.

Now I cannot feel any delay difference between usb and ice1724 midi 
inputs. Well done, gentlemen, thank you all.

Regards,


Pavel Hofman.

--------------090706050300030002050905
Content-Type: text/x-patch;
 name="ice1724-midi-tested.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ice1724-midi-tested.diff"

diff -r 1ffcb2896944 pci/Kconfig
--- a/pci/Kconfig	Fri May 16 12:34:47 2008 +0200
+++ b/pci/Kconfig	Sun May 18 14:30:25 2008 +0200
@@ -695,7 +695,7 @@ config SND_ICE1724
 config SND_ICE1724
 	tristate "ICE/VT1724/1720 (Envy24HT/PT)"
 	depends on SND
-	select SND_MPU401_UART
+	select SND_RAWMIDI
 	select SND_AC97_CODEC
 	select SND_VMASTER
 	help
diff -r 1ffcb2896944 pci/ice1712/envy24ht.h
--- a/pci/ice1712/envy24ht.h	Fri May 16 12:34:47 2008 +0200
+++ b/pci/ice1712/envy24ht.h	Sun May 18 14:30:25 2008 +0200
@@ -93,9 +93,13 @@ enum {
 #define VT1724_REG_MPU_TXFIFO		0x0a	/*byte ro. number of bytes in TX fifo*/
 #define VT1724_REG_MPU_RXFIFO		0x0b	/*byte ro. number of bytes in RX fifo*/
 
-//are these 2 the wrong way around? they don't seem to be used yet anyway
-#define VT1724_REG_MPU_CTRL		0x0c	/* byte */
-#define VT1724_REG_MPU_DATA		0x0d	/* byte */
+#define VT1724_REG_MPU_DATA		0x0c	/* byte */
+#define VT1724_REG_MPU_CTRL		0x0d	/* byte */
+#define   VT1724_MPU_UART	0x01
+#define   VT1724_MPU_TX_EMPTY	0x02
+#define   VT1724_MPU_TX_FULL	0x04
+#define   VT1724_MPU_RX_EMPTY	0x08
+#define   VT1724_MPU_RX_FULL	0x10
 
 #define VT1724_REG_MPU_FIFO_WM	0x0e	/*byte set the high/low watermarks for RX/TX fifos*/
 #define   VT1724_MPU_RX_FIFO	0x20	//1=rx fifo watermark 0=tx fifo watermark
diff -r 1ffcb2896944 pci/ice1712/ice1712.h
--- a/pci/ice1712/ice1712.h	Fri May 16 12:34:47 2008 +0200
+++ b/pci/ice1712/ice1712.h	Sun May 18 14:30:25 2008 +0200
@@ -333,6 +333,8 @@ struct snd_ice1712 {
 	unsigned int has_spdif: 1;	/* VT1720/4 - has SPDIF I/O */
 	unsigned int force_pdma4: 1;	/* VT1720/4 - PDMA4 as non-spdif */
 	unsigned int force_rdma1: 1;	/* VT1720/4 - RDMA1 as non-spdif */
+	unsigned int midi_output: 1;	/* VT1720/4: MIDI output triggered */
+	unsigned int midi_input: 1;	/* VT1720/4: MIDI input triggered */
 	unsigned int num_total_dacs;	/* total DACs */
 	unsigned int num_total_adcs;	/* total ADCs */
 	unsigned int cur_rate;		/* current rate */
diff -r 1ffcb2896944 pci/ice1712/ice1724.c
--- a/pci/ice1712/ice1724.c	Fri May 16 12:34:47 2008 +0200
+++ b/pci/ice1712/ice1724.c	Sun May 18 14:30:25 2008 +0200
@@ -32,7 +32,7 @@
 #include <linux/mutex.h>
 #include <sound/core.h>
 #include <sound/info.h>
-#include <sound/mpu401.h>
+#include <sound/rawmidi.h>
 #include <sound/initval.h>
 
 #include <sound/asoundef.h>
@@ -223,29 +223,151 @@ static unsigned int snd_vt1724_get_gpio_
 }
 
 /*
- * MPU401 accessor
+ * MIDI
  */
-static unsigned char snd_vt1724_mpu401_read(struct snd_mpu401 *mpu,
-					    unsigned long addr)
-{
-	/* fix status bits to the standard position */
-	/* only RX_EMPTY and TX_FULL are checked */
-	if (addr == MPU401C(mpu))
-		return (inb(addr) & 0x0c) << 4;
+
+static void vt1724_midi_clear_rx(struct snd_ice1712 *ice)
+{
+	unsigned int count;
+
+	for (count = inb(ICEREG1724(ice, MPU_RXFIFO)); count > 0; --count)
+		inb(ICEREG1724(ice, MPU_DATA));
+}
+
+static inline struct snd_rawmidi_substream *
+get_rawmidi_substream(struct snd_ice1712 *ice, unsigned int stream)
+{
+	return list_first_entry(&(ice->rmidi[0]->streams[stream].substreams),
+				struct snd_rawmidi_substream, list);
+}
+
+static void vt1724_midi_write(struct snd_ice1712 *ice)
+{
+	struct snd_rawmidi_substream *s;
+	int count, i;
+	u8 buffer[32];
+
+	s = get_rawmidi_substream(ice, SNDRV_RAWMIDI_STREAM_OUTPUT);
+	count = 31 - inb(ICEREG1724(ice, MPU_TXFIFO));
+	if (count > 0) {
+		count = snd_rawmidi_transmit(s, buffer, count);
+		for (i = 0; i < count; ++i)
+			outb(buffer[i], ICEREG1724(ice, MPU_DATA));
+	}
+}
+
+static void vt1724_midi_read(struct snd_ice1712 *ice)
+{
+	struct snd_rawmidi_substream *s;
+	int count, i;
+	u8 buffer[32];
+
+	s = get_rawmidi_substream(ice, SNDRV_RAWMIDI_STREAM_INPUT);
+	count = inb(ICEREG1724(ice, MPU_RXFIFO));
+	if (count > 0) {
+		for (i = 0; i < count; ++i)
+			buffer[i] = inb(ICEREG1724(ice, MPU_DATA));
+		snd_rawmidi_receive(s, buffer, count);
+	}
+}
+
+static void vt1724_enable_midi_irq(struct snd_rawmidi_substream *substream,
+				   u8 flag, int enable)
+{
+	struct snd_ice1712 *ice = substream->rmidi->private_data;
+	u8 mask;
+
+	spin_lock_irq(&ice->reg_lock);
+	mask = inb(ICEREG1724(ice, IRQMASK));
+	if (enable)
+		mask &= ~flag;
 	else
-		return inb(addr);
-}
-
-static void snd_vt1724_mpu401_write(struct snd_mpu401 *mpu,
-				    unsigned char data, unsigned long addr)
-{
-	if (addr == MPU401C(mpu)) {
-		if (data == MPU401_ENTER_UART)
-			outb(0x01, addr);
-		/* what else? */
-	} else
-		outb(data, addr);
-}
+		mask |= flag;
+	outb(mask, ICEREG1724(ice, IRQMASK));
+	spin_unlock_irq(&ice->reg_lock);
+}
+
+static int vt1724_midi_output_open(struct snd_rawmidi_substream *s)
+{
+	vt1724_enable_midi_irq(s, VT1724_IRQ_MPU_TX, 1);
+	return 0;
+}
+
+static int vt1724_midi_output_close(struct snd_rawmidi_substream *s)
+{
+	vt1724_enable_midi_irq(s, VT1724_IRQ_MPU_TX, 0);
+	return 0;
+}
+
+static void vt1724_midi_output_trigger(struct snd_rawmidi_substream *s, int up)
+{
+	struct snd_ice1712 *ice = s->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ice->reg_lock, flags);
+	if (up) {
+		ice->midi_output = 1;
+		vt1724_midi_write(ice);
+	} else {
+		ice->midi_output = 0;
+	}
+	spin_unlock_irqrestore(&ice->reg_lock, flags);
+}
+
+static void vt1724_midi_output_drain(struct snd_rawmidi_substream *s)
+{
+	struct snd_ice1712 *ice = s->rmidi->private_data;
+	unsigned long timeout;
+
+	/* 32 bytes should be transmitted in less than about 12 ms */
+	timeout = jiffies + msecs_to_jiffies(15);
+	do {
+		if (inb(ICEREG1724(ice, MPU_CTRL)) & VT1724_MPU_TX_EMPTY)
+			break;
+		schedule_timeout_uninterruptible(1);
+	} while (time_after(timeout, jiffies));
+}
+
+static struct snd_rawmidi_ops vt1724_midi_output_ops = {
+	.open = vt1724_midi_output_open,
+	.close = vt1724_midi_output_close,
+	.trigger = vt1724_midi_output_trigger,
+	.drain = vt1724_midi_output_drain,
+};
+
+static int vt1724_midi_input_open(struct snd_rawmidi_substream *s)
+{
+	vt1724_midi_clear_rx(s->rmidi->private_data);
+	vt1724_enable_midi_irq(s, VT1724_IRQ_MPU_RX, 1);
+	return 0;
+}
+
+static int vt1724_midi_input_close(struct snd_rawmidi_substream *s)
+{
+	vt1724_enable_midi_irq(s, VT1724_IRQ_MPU_RX, 0);
+	return 0;
+}
+
+static void vt1724_midi_input_trigger(struct snd_rawmidi_substream *s, int up)
+{
+	struct snd_ice1712 *ice = s->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ice->reg_lock, flags);
+	if (up) {
+		ice->midi_input = 1;
+		vt1724_midi_read(ice);
+	} else {
+		ice->midi_input = 0;
+	}
+	spin_unlock_irqrestore(&ice->reg_lock, flags);
+}
+
+static struct snd_rawmidi_ops vt1724_midi_input_ops = {
+	.open = vt1724_midi_input_open,
+	.close = vt1724_midi_input_close,
+	.trigger = vt1724_midi_input_trigger,
+};
 
 
 /*
@@ -278,13 +400,10 @@ static irqreturn_t snd_vt1724_interrupt(
 #endif
 		handled = 1;		
 		if (status & VT1724_IRQ_MPU_TX) {
-			if (ice->rmidi[0])
-				snd_mpu401_uart_interrupt_tx(irq,
-					ice->rmidi[0]->private_data);
-			else /* disable TX to be sure */
-				outb(inb(ICEREG1724(ice, IRQMASK)) |
-				     VT1724_IRQ_MPU_TX,
-				     ICEREG1724(ice, IRQMASK));
+			spin_lock(&ice->reg_lock);
+			if (ice->midi_output)
+				vt1724_midi_write(ice);
+			spin_unlock(&ice->reg_lock);
 			/* Due to mysterical reasons, MPU_TX is always
 			 * generated (and can't be cleared) when a PCM
 			 * playback is going.  So let's ignore at the
@@ -293,13 +412,12 @@ static irqreturn_t snd_vt1724_interrupt(
 			status_mask &= ~VT1724_IRQ_MPU_TX;
 		}
 		if (status & VT1724_IRQ_MPU_RX) {
-			if (ice->rmidi[0])
-				snd_mpu401_uart_interrupt(irq,
-					ice->rmidi[0]->private_data);
-			else /* disable RX to be sure */
-				outb(inb(ICEREG1724(ice, IRQMASK)) |
-				     VT1724_IRQ_MPU_RX,
-				     ICEREG1724(ice, IRQMASK));
+			spin_lock(&ice->reg_lock);
+			if (ice->midi_input)
+				vt1724_midi_read(ice);
+			else
+				vt1724_midi_clear_rx(ice);
+			spin_unlock(&ice->reg_lock);
 		}
 		/* ack MPU irq */
 		outb(status, ICEREG1724(ice, IRQSTAT));
@@ -2425,28 +2543,30 @@ static int __devinit snd_vt1724_probe(st
 
 	if (! c->no_mpu401) {
 		if (ice->eeprom.data[ICE_EEP2_SYSCONF] & VT1724_CFG_MPU401) {
-			struct snd_mpu401 *mpu;
-			if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ICE1712,
-						       ICEREG1724(ice, MPU_CTRL),
-						       (MPU401_INFO_INTEGRATED |
-							MPU401_INFO_NO_ACK |
-							MPU401_INFO_TX_IRQ),
-						       ice->irq, 0,
-						       &ice->rmidi[0])) < 0) {
+			struct snd_rawmidi *rmidi;
+
+			err = snd_rawmidi_new(card, "MIDI", 0, 1, 1, &rmidi);
+			if (err < 0) {
 				snd_card_free(card);
 				return err;
 			}
-			mpu = ice->rmidi[0]->private_data;
-			mpu->read = snd_vt1724_mpu401_read;
-			mpu->write = snd_vt1724_mpu401_write;
-			/* unmask MPU RX/TX irqs */
-			outb(inb(ICEREG1724(ice, IRQMASK)) &
-			     ~(VT1724_IRQ_MPU_RX | VT1724_IRQ_MPU_TX),
-			     ICEREG1724(ice, IRQMASK));
+			ice->rmidi[0] = rmidi;
+			rmidi->private_data = ice;
+			strcpy(rmidi->name, "ICE1724 MIDI");
+			rmidi->info_flags = SNDRV_RAWMIDI_INFO_OUTPUT |
+					    SNDRV_RAWMIDI_INFO_INPUT |
+					    SNDRV_RAWMIDI_INFO_DUPLEX;
+			snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+					    &vt1724_midi_output_ops);
+			snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+					    &vt1724_midi_input_ops);
+
 			/* set watermarks */
 			outb(VT1724_MPU_RX_FIFO | 0x1,
 			     ICEREG1724(ice, MPU_FIFO_WM));
 			outb(0x1, ICEREG1724(ice, MPU_FIFO_WM));
+			/* set UART mode */
+			outb(0x01, ICEREG1724(ice, MPU_CTRL));
 		}
 	}
 

--------------090706050300030002050905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090706050300030002050905--
