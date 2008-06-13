From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] maestro3: Fix hw volume on HP OmniBook
Date: Fri, 13 Jun 2008 10:54:44 +0300
Message-ID: <20080613075444.GF9041@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 24D722441C
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 09:54:47 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Make the hw volume buttons work correctly on some HP OmniBook laptops.
The original quirk was apparently applied a bit too early and it was
also lacking some critial register writes. This improved sequence was
discovered by trial and error (like the original sequence). Tested and
found working on OB500 and OB6000 laptops.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 sound/pci/maestro3.c |   42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

Index: linux-2.6.25.4/sound/pci/maestro3.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.25.4.orig/sound/pci/maestro3.c
+++ linux-2.6.25.4/sound/pci/maestro3.c
@@ -2427,6 +2427,29 @@ snd_m3_amp_enable(struct snd_m3 *chip, i
 	outw(0xffff, io + GPIO_MASK);
 }
 =

+static void
+snd_m3_hv_init(struct snd_m3 *chip)
+{
+	unsigned long io =3D chip->iobase;
+	u16 val =3D GPI_VOL_DOWN | GPI_VOL_UP;
+
+	if (!chip->is_omnibook)
+		return;
+
+	/*
+	 * Volume buttons on some HP OmniBook laptops
+	 * require some GPIO magic to work correctly.
+	 */
+	outw(0xffff, io + GPIO_MASK);
+	outw(0x0000, io + GPIO_DATA);
+
+	outw(~val, io + GPIO_MASK);
+	outw(inw(io + GPIO_DIRECTION) & ~val, io + GPIO_DIRECTION);
+	outw(val, io + GPIO_MASK);
+
+	outw(0xffff, io + GPIO_MASK);
+}
+
 static int
 snd_m3_chip_init(struct snd_m3 *chip)
 {
@@ -2442,21 +2465,6 @@ snd_m3_chip_init(struct snd_m3 *chip)
 	       DISABLE_LEGACY);
 	pci_write_config_word(pcidev, PCI_LEGACY_AUDIO_CTRL, w);
 =

-	if (chip->is_omnibook) {
-		/*
-		 * Volume buttons on some HP OmniBook laptops don't work
-		 * correctly. This makes them work for the most part.
-		 *
-		 * Volume up and down buttons on the laptop side work.
-		 * Fn+cursor_up (volme up) works.
-		 * Fn+cursor_down (volume down) doesn't work.
-		 * Fn+F7 (mute) works acts as volume up.
-		 */
-		outw(~(GPI_VOL_DOWN|GPI_VOL_UP), io + GPIO_MASK);
-		outw(inw(io + GPIO_DIRECTION) & ~(GPI_VOL_DOWN|GPI_VOL_UP), io + GPIO_DI=
RECTION);
-		outw((GPI_VOL_DOWN|GPI_VOL_UP), io + GPIO_DATA);
-		outw(0xffff, io + GPIO_MASK);
-	}
 	pci_read_config_dword(pcidev, PCI_ALLEGRO_CONFIG, &n);
 	n &=3D ~(HV_CTRL_ENABLE | REDUCED_DEBOUNCE | HV_BUTTON_FROM_GD);
 	n |=3D chip->hv_config;
@@ -2644,6 +2652,8 @@ static int m3_resume(struct pci_dev *pci
 	snd_m3_enable_ints(chip);
 	snd_m3_amp_enable(chip, 1);
 =

+	snd_m3_hv_init(chip);
+
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
 }
@@ -2783,6 +2793,8 @@ snd_m3_create(struct snd_card *card, str
 =

 	snd_m3_amp_enable(chip, 1);
 =

+	snd_m3_hv_init(chip);
+
 	tasklet_init(&chip->hwvol_tq, snd_m3_update_hw_volume, (unsigned long)chi=
p);
 =

 	if (request_irq(pci->irq, snd_m3_interrupt, IRQF_SHARED,
-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
