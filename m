From: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Subject: [PATCH 6/6] ALSA: hda/ca0132: Fix DMic data rate for
	Alienware M17x R4
Date: Fri, 15 Jun 2018 21:56:20 -0400
Message-ID: <20180616015620.26663-7-alastair.bridgewater@gmail.com>
References: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>
List-Id: alsa-devel@alsa-project.org

The commentary says to use various parameters, and lays out what
the mapping is...  The code used a 32KHz rate when the comment
says that it needs to use a 48KHz rate.  And this has been the
case since day one.

On the Alienware M17x R4, the DMic used to have exceptionally quiet
pickup and a lot of noise.  Changing the data rate fixes both of
these issues.

Searching the kernel bug tracker for ca0132-related issues shows no
mention of this being an issue for other hardware, and I have no
other hardware to test with, so a quirk is used to limit the effect
to just the M17x R4.

Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index cef22c60d7ee..614f69407c9f 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -991,6 +991,7 @@ struct ca0132_spec {
 enum {
 	QUIRK_NONE,
 	QUIRK_ALIENWARE,
+	QUIRK_ALIENWARE_M17XR4,
 	QUIRK_SBZ,
 	QUIRK_R3DI,
 };
@@ -1040,6 +1041,7 @@ static const struct hda_pintbl r3di_pincfgs[] = {
 };
 
 static const struct snd_pci_quirk ca0132_quirks[] = {
+	SND_PCI_QUIRK(0x1028, 0x057b, "Alienware M17x R4", QUIRK_ALIENWARE_M17XR4),
 	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15 2015", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1028, 0x0688, "Alienware 17 2015", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1028, 0x0708, "Alienware 15 R2 2016", QUIRK_ALIENWARE),
@@ -6130,7 +6132,10 @@ static void ca0132_init_dmic(struct hda_codec *codec)
 	 * Bit   6: set to select Data2, clear for Data1
 	 * Bit   7: set to enable DMic, clear for AMic
 	 */
-	val = 0x23;
+	if (spec->quirk == QUIRK_ALIENWARE_M17XR4)
+		val = 0x33;
+	else
+		val = 0x23;
 	/* keep a copy of dmic ctl val for enable/disable dmic purpuse */
 	spec->dmic_ctl = val;
 	snd_hda_codec_write(codec, spec->input_pins[0], 0,
-- 
2.16.1
