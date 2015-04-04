From: Joe Perches <joe@perches.com>
Subject: [PATCH] sound: Use const struct ac97_quirk
Date: Sat, 04 Apr 2015 13:38:25 -0700
Message-ID: <1428179905.2775.55.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Thibaut Varene <T-Bone@parisc-linux.org>, Jaya Kumar <jayakumar.alsa@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use const to reduce data by ~3Kb.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/sound/ac97_codec.h          | 4 +++-
 sound/pci/ac97/ac97_codec.c         | 3 ++-
 sound/pci/ad1889.c                  | 2 +-
 sound/pci/atiixp.c                  | 2 +-
 sound/pci/cs5535audio/cs5535audio.c | 2 +-
 sound/pci/intel8x0.c                | 2 +-
 sound/pci/via82xx.c                 | 2 +-
 7 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index d315a08..0e9d75b 100644
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -608,7 +608,9 @@ struct ac97_quirk {
 	int type;		/* quirk type above */
 };
 
-int snd_ac97_tune_hardware(struct snd_ac97 *ac97, struct ac97_quirk *quirk, const char *override);
+int snd_ac97_tune_hardware(struct snd_ac97 *ac97,
+			   const struct ac97_quirk *quirk,
+			   const char *override);
 int snd_ac97_set_rate(struct snd_ac97 *ac97, int reg, unsigned int rate);
 
 /*
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 5bca1a3..82259ca 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2902,7 +2902,8 @@ static int apply_quirk_str(struct snd_ac97 *ac97, const char *typestr)
  * Return: Zero if successful, or a negative error code on failure.
  */
 
-int snd_ac97_tune_hardware(struct snd_ac97 *ac97, struct ac97_quirk *quirk, const char *override)
+int snd_ac97_tune_hardware(struct snd_ac97 *ac97,
+			   const struct ac97_quirk *quirk, const char *override)
 {
 	int result;
 
diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 850a8c9..66ddd98 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -747,7 +747,7 @@ snd_ad1889_proc_init(struct snd_ad1889 *chip)
 		snd_info_set_text_ops(entry, chip, snd_ad1889_proc_read);
 }
 
-static struct ac97_quirk ac97_quirks[] = {
+static const struct ac97_quirk ac97_quirks[] = {
 	{
 		.subvendor = 0x11d4,	/* AD */
 		.subdevice = 0x1889,	/* AD1889 */
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index d5f15c9..42a20c8 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1390,7 +1390,7 @@ static irqreturn_t snd_atiixp_interrupt(int irq, void *dev_id)
  * ac97 mixer section
  */
 
-static struct ac97_quirk ac97_quirks[] = {
+static const struct ac97_quirk ac97_quirks[] = {
 	{
 		.subvendor = 0x103c,
 		.subdevice = 0x006b,
diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index 802c33f..963b912 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -43,7 +43,7 @@ static char *ac97_quirk;
 module_param(ac97_quirk, charp, 0444);
 MODULE_PARM_DESC(ac97_quirk, "AC'97 board specific workarounds.");
 
-static struct ac97_quirk ac97_quirks[] = {
+static const struct ac97_quirk ac97_quirks[] = {
 #if 0 /* Not yet confirmed if all 5536 boards are HP only */
 	{
 		.subvendor = PCI_VENDOR_ID_AMD, 
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 2c5484e..749069a 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -1795,7 +1795,7 @@ static struct ac97_pcm ac97_pcm_defs[] = {
 	},
 };
 
-static struct ac97_quirk ac97_quirks[] = {
+static const struct ac97_quirk ac97_quirks[] = {
         {
 		.subvendor = 0x0e11,
 		.subdevice = 0x000e,
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 8622283..3dd038b 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1812,7 +1812,7 @@ static void snd_via82xx_mixer_free_ac97(struct snd_ac97 *ac97)
 	chip->ac97 = NULL;
 }
 
-static struct ac97_quirk ac97_quirks[] = {
+static const struct ac97_quirk ac97_quirks[] = {
 	{
 		.subvendor = 0x1106,
 		.subdevice = 0x4161,
