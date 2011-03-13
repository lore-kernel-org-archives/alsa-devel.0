From: pbruskispam@op.pl
Subject: [PATCH - ctxfi driver 3/4] Fix: spdif status retrieval
	always returned the default settings instead of the actual ones
Date: Sun, 13 Mar 2011 16:18:57 +0100
Message-ID: <1300029538-3147-3-git-send-email-pbruskispam@op.pl>
References: <1300029538-3147-1-git-send-email-pbruskispam@op.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1300029538-3147-1-git-send-email-pbruskispam@op.pl>
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
Cc: alsa-devel@alsa-project.org, Przemyslaw Bruski <pbruskispam@op.pl>
List-Id: alsa-devel@alsa-project.org

From: Przemyslaw Bruski <pbruskispam@op.pl>


Signed-off-by: Przemyslaw Bruski <pbruskispam@op.pl>

diff --git a/pci/ctxfi/ctmixer.c b/pci/ctxfi/ctmixer.c
index 15c1e72..c3519ff 100644
--- a/pci/ctxfi/ctmixer.c
+++ b/pci/ctxfi/ctmixer.c
@@ -566,19 +566,6 @@ static int ct_spdif_get_mask(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static int ct_spdif_default_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	unsigned int status = SNDRV_PCM_DEFAULT_CON_SPDIF;
-
-	ucontrol->value.iec958.status[0] = (status >> 0) & 0xff;
-	ucontrol->value.iec958.status[1] = (status >> 8) & 0xff;
-	ucontrol->value.iec958.status[2] = (status >> 16) & 0xff;
-	ucontrol->value.iec958.status[3] = (status >> 24) & 0xff;
-
-	return 0;
-}
-
 static int ct_spdif_get(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
@@ -586,6 +573,10 @@ static int ct_spdif_get(struct snd_kcontrol *kcontrol,
 	unsigned int status;
 
 	atc->spdif_out_get_status(atc, &status);
+
+	if (status == 0)
+		status = SNDRV_PCM_DEFAULT_CON_SPDIF;
+
 	ucontrol->value.iec958.status[0] = (status >> 0) & 0xff;
 	ucontrol->value.iec958.status[1] = (status >> 8) & 0xff;
 	ucontrol->value.iec958.status[2] = (status >> 16) & 0xff;
@@ -629,7 +620,7 @@ static struct snd_kcontrol_new iec958_default_ctl = {
 	.name		= SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
 	.count		= 1,
 	.info		= ct_spdif_info,
-	.get		= ct_spdif_default_get,
+	.get		= ct_spdif_get,
 	.put		= ct_spdif_put,
 	.private_value	= MIXER_IEC958_DEFAULT
 };
-- 
1.7.1
