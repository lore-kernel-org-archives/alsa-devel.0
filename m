From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] revo51: add headphone output
Date: Thu, 21 Aug 2008 08:28:42 +0400
Message-ID: <20080821042842.GA7789@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-1314.google.com (qb-out-1314.google.com [72.14.204.169])
	by alsa0.perex.cz (Postfix) with ESMTP id B1529243B1
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Aug 2008 06:28:48 +0200 (CEST)
Received: by qb-out-1314.google.com with SMTP id e10so1314922qbe.44
	for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2008 21:28:47 -0700 (PDT)
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
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: voss@seehuhn.de
List-Id: alsa-devel@alsa-project.org


 It is ALSA bug #1754.
 D6 bit in 02 register is PW4.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/i2c/other/ak4xxx-adda.c |    4 ++--
 sound/pci/ice1712/revo.c      |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
index 288926d..4c94458 100644
--- a/sound/i2c/other/ak4xxx-adda.c
+++ b/sound/i2c/other/ak4xxx-adda.c
@@ -233,8 +233,8 @@ void snd_akm4xxx_init(struct snd_akm4xxx *ak)
 		0x01, 0x02, /* 1: reset and soft-mute */
 		0x00, 0x06, /* 0: mode3(i2s), disable auto-clock detect,
 			     * disable DZF, sharp roll-off, RSTN#=0 */
-		0x02, 0x0e, /* 2: DA's power up, normal speed, RSTN#=0 */
-		// 0x02, 0x2e, /* quad speed */
+		0x02, 0x4e, /* 2: DA's power up, normal speed, RSTN#=0 */
+		// 0x02, 0x6e, /* quad speed */
 		0x03, 0x01, /* 3: de-emphasis off */
 		0x04, 0x00, /* 4: LOUT1 volume muted */
 		0x05, 0x00, /* 5: ROUT1 volume muted */
diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index 4d26314..30b5e83 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -216,6 +216,7 @@ static const struct snd_akm4xxx_dac_channel revo51_dac[] = {
 	AK_DAC("PCM Center Playback Volume", 1),
 	AK_DAC("PCM LFE Playback Volume", 1),
 	AK_DAC("PCM Rear Playback Volume", 2),
+	AK_DAC("PCM Headphone Volume", 2),
 };
 
 static const char *revo51_adc_input_names[] = {
@@ -279,7 +280,7 @@ static struct snd_ak4xxx_private akm_revo_surround_priv __devinitdata = {
 
 static struct snd_akm4xxx akm_revo51 __devinitdata = {
 	.type = SND_AK4358,
-	.num_dacs = 6,
+	.num_dacs = 8,
 	.ops = {
 		.set_rate_val = revo_set_rate_val
 	},
@@ -508,7 +509,7 @@ static int __devinit revo_init(struct snd_ice1712 *ice)
 		ice->gpio.i2s_mclk_changed = revo_i2s_mclk_changed;
 		break;
 	case VT1724_SUBDEVICE_REVOLUTION51:
-		ice->num_total_dacs = 6;
+		ice->num_total_dacs = 8;
 		ice->num_total_adcs = 2;
 		break;
 	case VT1724_SUBDEVICE_AUDIOPHILE192:
