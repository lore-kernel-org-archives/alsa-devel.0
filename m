From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ALSA: emux: stop if copy_from_user() fails
Date: Fri, 31 Mar 2017 16:53:40 +0300
Message-ID: <20170331135340.GA22338@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 000F726691F
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 15:53:50 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

If we can't fill the "patch" struct because "count" is too small (it can
be as low as 4 bytes) or because copy_from_user() failed, then just
return instead of using unintialized data.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/synth/emux/emux_oss.c b/sound/synth/emux/emux_oss.c
index ac75816ada7c..850fab4a8f3b 100644
--- a/sound/synth/emux/emux_oss.c
+++ b/sound/synth/emux/emux_oss.c
@@ -225,9 +225,9 @@ snd_emux_load_patch_seq_oss(struct snd_seq_oss_arg *arg, int format,
 	else if (format == SNDRV_OSS_SOUNDFONT_PATCH) {
 		struct soundfont_patch_info patch;
 		if (count < (int)sizeof(patch))
-			rc = -EINVAL;
+			return -EINVAL;
 		if (copy_from_user(&patch, buf, sizeof(patch)))
-			rc = -EFAULT;
+			return -EFAULT;
 		if (patch.type >= SNDRV_SFNT_LOAD_INFO &&
 		    patch.type <= SNDRV_SFNT_PROBE_DATA)
 			rc = snd_soundfont_load(emu->sflist, buf, count, SF_CLIENT_NO(p->chset.port));
