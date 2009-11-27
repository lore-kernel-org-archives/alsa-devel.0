From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: snd-fm801: autodetect SF64-PCR (tuner-only) card
Date: Fri, 27 Nov 2009 18:18:33 +0100
Message-ID: <200911271818.34710.linux@rainbow-software.org>
References: <200911262159.44083.linux@rainbow-software.org>
	<alpine.LNX.2.00.0911270756140.4095@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail1-out1.atlantis.sk [80.94.52.55])
	by alsa0.perex.cz (Postfix) with ESMTP id E4CBB24695
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 18:18:43 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.0911270756140.4095@eeebox2.perex-int.cz>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 27 November 2009 07:59:26 Jaroslav Kysela wrote:
> On Thu, 26 Nov 2009, Ondrej Zary wrote:
> > When primary AC97 is not found, don't fail with tons of AC97 errors.
> > Assume that the card is SF64-PCR (tuner-only).
> > This makes the SF64-PCR radio card work "out of the box".
>
> I would leave the possibility to force FM tuner only detection without
> touching AC97 bus. The auto detection is a good idea. Could you recode
> your patch?

Here it is.
BTW. Looks like the tuner could be detected automatically provided that
someone has the different cards to test.



When primary AC97 is not found, don't fail with tons of AC97 errors.
Assume that the card is SF64-PCR (tuner-only).
This makes the SF64-PCR radio card work "out of the box".

Also fixes a bug that can cause an oops here:
=A0=A0=A0=A0=A0=A0=A0=A0if (tea575x_tuner > 0 && (tea575x_tuner & 0x000f) <=
 4) {
when tea575x_tuner =3D=3D 16, it passes this check and causes problems
a couple lines below:
=A0=A0=A0=A0=A0=A0=A0=A0chip->tea.ops =3D &snd_fm801_tea_ops[(tea575x_tuner=
 & 0x000f) - 1];


Tested with SF64-PCR, but I don't have any of those sound or sound+radio ca=
rds
to test if I didn't break anything.


Signed-off-by: Ondrej Zary <linux@rainbow-software.org>


--- linux-source-2.6.31-orig/sound/pci/fm801.c	2009-09-10 00:13:59.00000000=
0 +0200
+++ linux-source-2.6.31/sound/pci/fm801.c	2009-11-27 18:05:32.000000000 +01=
00
@@ -55,7 +55,7 @@ static int enable[SNDRV_CARDS] =3D SNDRV_D
  *    1 =3D MediaForte 256-PCS
  *    2 =3D MediaForte 256-PCPR
  *    3 =3D MediaForte 64-PCR
- *   16 =3D setup tuner only (this is additional bit), i.e. SF-64-PCR FM c=
ard
+ *   16 =3D setup tuner only (this is additional bit), i.e. SF64-PCR FM ca=
rd
  *  High 16-bits are video (radio) device number + 1
  */
 static int tea575x_tuner[SNDRV_CARDS];
@@ -67,7 +67,10 @@ MODULE_PARM_DESC(id, "ID string for the =

 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable FM801 soundcard.");
 module_param_array(tea575x_tuner, int, NULL, 0444);
-MODULE_PARM_DESC(tea575x_tuner, "Enable TEA575x tuner.");
+MODULE_PARM_DESC(tea575x_tuner, "TEA575x tuner access method (1 =3D SF256-=
PCS, 2=3DSF256-PCPR, 3=3DSF64-PCR, +16=3Dtuner-only).");
+
+#define TUNER_ONLY		(1<<4)
+#define TUNER_TYPE_MASK		(~TUNER_ONLY & 0xFFFF)
 =

 /*
  *  Direct registers
@@ -160,7 +163,7 @@ struct fm801 {
 	unsigned int multichannel: 1,	/* multichannel support */
 		     secondary: 1;	/* secondary codec */
 	unsigned char secondary_addr;	/* address of the secondary codec */
-	unsigned int tea575x_tuner;	/* tuner flags */
+	unsigned int tea575x_tuner;	/* tuner access method & flags */
 =

 	unsigned short ply_ctrl; /* playback control */
 	unsigned short cap_ctrl; /* capture control */
@@ -1287,7 +1290,7 @@ static int snd_fm801_chip_init(struct fm
 {
 	unsigned short cmdw;
 =

-	if (chip->tea575x_tuner & 0x0010)
+	if (chip->tea575x_tuner & TUNER_ONLY)
 		goto __ac97_ok;
 =

 	/* codec cold reset + AC'97 warm reset */
@@ -1296,11 +1299,13 @@ static int snd_fm801_chip_init(struct fm
 	udelay(100);
 	outw(0, FM801_REG(chip, CODEC_CTRL));
 =

-	if (wait_for_codec(chip, 0, AC97_RESET, msecs_to_jiffies(750)) < 0) {
-		snd_printk(KERN_ERR "Primary AC'97 codec not found\n");
-		if (! resume)
-			return -EIO;
-	}
+	if (wait_for_codec(chip, 0, AC97_RESET, msecs_to_jiffies(750)) < 0)
+		if (!resume) {
+			snd_printk(KERN_INFO "Primary AC'97 codec not found, "
+					    "assume SF64-PCR (tuner-only)\n");
+			chip->tea575x_tuner =3D 3 | TUNER_ONLY;
+			goto __ac97_ok;
+		}
 =

 	if (chip->multichannel) {
 		if (chip->secondary_addr) {
@@ -1414,7 +1419,7 @@ static int __devinit snd_fm801_create(st
 		return err;
 	}
 	chip->port =3D pci_resource_start(pci, 0);
-	if ((tea575x_tuner & 0x0010) =3D=3D 0) {
+	if ((tea575x_tuner & TUNER_ONLY) =3D=3D 0) {
 		if (request_irq(pci->irq, snd_fm801_interrupt, IRQF_SHARED,
 				"FM801", chip)) {
 			snd_printk(KERN_ERR "unable to grab IRQ %d\n", chip->irq);
@@ -1429,6 +1434,14 @@ static int __devinit snd_fm801_create(st
 		chip->multichannel =3D 1;
 =

 	snd_fm801_chip_init(chip, 0);
+	/* init might set tuner access method */
+	tea575x_tuner =3D chip->tea575x_tuner;
+
+	if (chip->irq >=3D 0 && (tea575x_tuner & TUNER_ONLY)) {
+		pci_clear_master(pci);
+		free_irq(chip->irq, chip);
+		chip->irq =3D -1;
+	}
 =

 	if ((err =3D snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
 		snd_fm801_free(chip);
@@ -1438,12 +1451,13 @@ static int __devinit snd_fm801_create(st
 	snd_card_set_dev(card, &pci->dev);
 =

 #ifdef TEA575X_RADIO
-	if (tea575x_tuner > 0 && (tea575x_tuner & 0x000f) < 4) {
+	if ((tea575x_tuner & TUNER_TYPE_MASK) > 0 &&
+	    (tea575x_tuner & TUNER_TYPE_MASK) < 4) {
 		chip->tea.dev_nr =3D tea575x_tuner >> 16;
 		chip->tea.card =3D card;
 		chip->tea.freq_fixup =3D 10700;
 		chip->tea.private_data =3D chip;
-		chip->tea.ops =3D &snd_fm801_tea_ops[(tea575x_tuner & 0x000f) - 1];
+		chip->tea.ops =3D &snd_fm801_tea_ops[(tea575x_tuner & TUNER_TYPE_MASK) -=
 1];
 		snd_tea575x_init(&chip->tea);
 	}
 #endif
@@ -1483,7 +1497,7 @@ static int __devinit snd_card_fm801_prob
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
 		card->shortname, chip->port, chip->irq);
 =

-	if (tea575x_tuner[dev] & 0x0010)
+	if (chip->tea575x_tuner & TUNER_ONLY)
 		goto __fm801_tuner_only;
 =

 	if ((err =3D snd_fm801_pcm(chip, 0, NULL)) < 0) {


-- =

Ondrej Zary
