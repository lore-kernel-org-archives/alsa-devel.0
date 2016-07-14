From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 22/34] pcm: remove alloca() from
	_snd_pcm_softvol_open()
Date: Thu, 14 Jul 2016 23:07:39 +0900
Message-ID: <1468505271-5769-23-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id DA1AB26659F
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:09 +0200 (CEST)
In-Reply-To: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Both of alloca() and automatic variables keeps storages on stack, while
the former generates more instructions than the latter. It's better to use
the latter if the size of storage is computable at pre-compile or compile
time; i.e. just for structures.

This commit obsolete usages of alloca() with automatic variables.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_softvol.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_softvol.c b/src/pcm/pcm_softvol.c
index e2345b3..6135778 100644
--- a/src/pcm/pcm_softvol.c
+++ b/src/pcm/pcm_softvol.c
@@ -995,7 +995,7 @@ int _snd_pcm_softvol_open(snd_pcm_t **pcmp, const char *name,
 	snd_config_t *slave = NULL, *sconf;
 	snd_config_t *control = NULL;
 	snd_pcm_format_t sformat = SND_PCM_FORMAT_UNKNOWN;
-	snd_ctl_elem_id_t *ctl_id;
+	snd_ctl_elem_id_t ctl_id = {0};
 	int resolution = PRESET_RESOLUTION;
 	double min_dB = PRESET_MIN_DB;
 	double max_dB = ZERO_DB;
@@ -1074,7 +1074,6 @@ int _snd_pcm_softvol_open(snd_pcm_t **pcmp, const char *name,
 					       mode, conf);
 		snd_config_delete(sconf);
 	} else {
-		snd_ctl_elem_id_alloca(&ctl_id);
 		err = snd_pcm_slave_conf(root, slave, &sconf, 1,
 					 SND_PCM_HW_PARAM_FORMAT, 0, &sformat);
 		if (err < 0)
@@ -1093,13 +1092,13 @@ int _snd_pcm_softvol_open(snd_pcm_t **pcmp, const char *name,
 		snd_config_delete(sconf);
 		if (err < 0)
 			return err;
-		err = snd_pcm_parse_control_id(control, ctl_id, &card,
+		err = snd_pcm_parse_control_id(control, &ctl_id, &card,
 					       &cchannels, NULL);
 		if (err < 0) {
 			snd_pcm_close(spcm);
 			return err;
 		}
-		err = snd_pcm_softvol_open(pcmp, name, sformat, card, ctl_id,
+		err = snd_pcm_softvol_open(pcmp, name, sformat, card, &ctl_id,
 					   cchannels, min_dB, max_dB,
 					   resolution, spcm, 1);
 		if (err < 0)
-- 
2.7.4
