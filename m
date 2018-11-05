From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: dapm: Use less aggressive caching to
	ensure correctness
Date: Mon,  5 Nov 2018 19:19:12 +0800
Message-ID: <20181105111912.14464-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com
 [209.85.210.73])
 by alsa0.perex.cz (Postfix) with ESMTP id C2BBB267692
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 12:19:41 +0100 (CET)
Received: by mail-ot1-f73.google.com with SMTP id v4so6225928otb.0
 for <alsa-devel@alsa-project.org>; Mon, 05 Nov 2018 03:19:41 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: tzungbi@google.com, lars@metafoo.de, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

Commit 92a99ea439c4 ("ASoC: dapm: Use more aggressive caching") only
invalidates necessary caches to improve the cache hit rate.  However,
in snd_soc_dapm_add_path(), the cache is too aggressive which results
in wrong state of the audio map.

E.g. imaging the following examples during snd_soc_instantiate_card():

time 1: at the beginning

  in:-1    in:-1     in:-1
 out:-1   out:-1    out:-1
      A -----> B       Spk

time 2: after someone called snd_soc_dapm_new_widgets()
(e.g. create_fill_widget_route_map() in sound/soc/codecs/hdac_hdmi.c)

  in:0    in:0     in:0
 out:0   out:0    out:1
     A ----> B      Spk

time 3: route added to Spk

  in:0    in:0      in:0
 out:0   out:0     out:1
     A ----> B ----> Spk

time N: route added from SIGGEN

  in:1    in:0    in:0      in:0
 out:0   out:0   out:0     out:1
SIGGEN ----> A ----> B ----> Spk

In the end, the path will not power on but it should be.  At time 2, the
caches have been polluted.  At time 3, it will not get the correct state
if snd_soc_dapm_add_path() does not invalidate "out" of B and A.

time 3 (expected result):

  in:0    in:0      in:0
 out:1   out:1     out:1
     A ----> B ----> Spk

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a5178845065b..2914f3adb333 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2722,7 +2722,7 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 		dapm_mark_dirty(widgets[dir], "Route added");
 	}
 
-	if (dapm->card->instantiated && path->connect)
+	if (path->connect)
 		dapm_path_invalidate(path);
 
 	return 0;
-- 
2.19.1.930.g4563a0d9d0-goog
