From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: dapm: Recalculate audio map forcely when
	card instantiated
Date: Wed, 14 Nov 2018 17:06:13 +0800
Message-ID: <20181114090613.140247-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com
 [209.85.166.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D45F267839
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 10:06:36 +0100 (CET)
Received: by mail-io1-f73.google.com with SMTP id z17-v6so15264889iol.20
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 01:06:36 -0800 (PST)
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

Audio map are possible in wrong state before card->instantiated has
been set to true.  Imaging the following examples:

time 1: at the beginning

  in:-1    in:-1    in:-1    in:-1
 out:-1   out:-1   out:-1   out:-1
 SIGGEN        A        B      Spk

time 2: after someone called snd_soc_dapm_new_widgets()
(e.g. create_fill_widget_route_map() in sound/soc/codecs/hdac_hdmi.c)

   in:1     in:0     in:0     in:0
  out:0    out:0    out:0    out:1
 SIGGEN        A        B      Spk

time 3: routes added

   in:1     in:0     in:0     in:0
  out:0    out:0    out:0    out:1
 SIGGEN -----> A -----> B ---> Spk

In the end, the path should be powered on but it did not.  At time 3,
"in" of SIGGEN and "out" of Spk did not propagate to their neighbors
because snd_soc_dapm_add_path() will not invalidate the paths if
the card has not instantiated (i.e. card->instantiated is false).
To correct the state of audio map, recalculate the whole map forcely.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6ddcf12bc030..b29d0f65611e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2131,6 +2131,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	card->instantiated = 1;
+	dapm_mark_endpoints_dirty(card);
 	snd_soc_dapm_sync(&card->dapm);
 	mutex_unlock(&card->mutex);
 	mutex_unlock(&client_mutex);
-- 
2.19.1.930.g4563a0d9d0-goog
