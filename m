From: pavel.hofman@ivitera.com
Subject: [PATCH - ice1724 1/3] ALSA: ice1724 - Create capture
	pcm only for ADC-enabled configurations
Date: Tue, 10 Jan 2012 20:28:46 +0100
Message-ID: <1326223728-3085-1-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>

Add the capture pcm only if there is at least one ADC configured in
the SYSCONF register.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 9e18d3a..e797823 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -1117,14 +1117,21 @@ static struct snd_pcm_ops snd_vt1724_capture_pro_ops = {
 static int __devinit snd_vt1724_pcm_profi(struct snd_ice1712 *ice, int device)
 {
 	struct snd_pcm *pcm;
-	int err;
+	int capt, err;
 
-	err = snd_pcm_new(ice->card, "ICE1724", device, 1, 1, &pcm);
+	if ((ice->eeprom.data[ICE_EEP2_SYSCONF] & VT1724_CFG_ADC_MASK) ==
+	    VT1724_CFG_ADC_NONE)
+		capt = 0;
+	else
+		capt = 1;
+	err = snd_pcm_new(ice->card, "ICE1724", device, 1, capt, &pcm);
 	if (err < 0)
 		return err;
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_vt1724_playback_pro_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_vt1724_capture_pro_ops);
+	if (capt)
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+			&snd_vt1724_capture_pro_ops);
 
 	pcm->private_data = ice;
 	pcm->info_flags = 0;
-- 
1.7.0.4
