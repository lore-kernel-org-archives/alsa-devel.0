From: srv_kaichieh.chaung <srv_kaichieh.chuang@mediatek.com>
Subject: DPCM: skip DAPM_STREAM_STOP event to BE,
	if still used by other FE
Date: Tue, 24 May 2016 13:06:30 +0800
Message-ID: <1464066390.30335.1.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 93C05260568
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2016 07:06:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

Hi,
      Let me illustrate the system first.
FE1 -----+----> BE
         |
FE2 -----+

      When there is multi-FE stream to a single BE, the BE will receive
SND_SOC_DAPM_STREAM_STOP if one of the FE shutdown.
However, the BE is stilled used by another, this will let BE cpu_dai and
codec_dai think they are inactive. The later power check will go wrong.

I have check the latest linux version, and didn't find any related
change.
The following is my change to address this, and will re-send a formal
patch if it's ok.


diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 70e8088..9c2d159 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -163,6 +163,13 @@ int dpcm_dapm_stream_event(struct
snd_soc_pcm_runtime *fe, int dir,
 		dev_dbg(be->dev, "ASoC: BE %s event %d dir %d\n",
 				be->dai_link->name, event, dir);

+		/* don't sent stop event if this BE is used by other FE */
+		if (event == SND_SOC_DAPM_STREAM_STOP &&
+		    be->dpcm[dir].users >= 1) {
+			pr_warn("kc, %s(), be->dai_link->name %s skip stop event\n",
__func__, be->dai_link->name);
+			continue;
+		}
+
 		snd_soc_dapm_stream_event(be, dir, event);
 	}
 

Sincerely,
Kai Chieh
