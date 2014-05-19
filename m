From: Matt Reimer <mreimer@sdgsystems.com>
Subject: [PATCH] ALSA: ASoC: wm9713: correct mono out PGA
	sources
Date: Mon, 19 May 2014 09:35:47 -0700
Message-ID: <1400517347-3673-1-git-send-email-mreimer@sdgsystems.com>
References: <1400186759-24248-1-git-send-email-mreimer@sdgsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f41.google.com (mail-pb0-f41.google.com
 [209.85.160.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 64084260890
 for <Alsa-devel@alsa-project.org>; Mon, 19 May 2014 18:36:01 +0200 (CEST)
Received: by mail-pb0-f41.google.com with SMTP id uo5so6141568pbc.28
 for <Alsa-devel@alsa-project.org>; Mon, 19 May 2014 09:36:00 -0700 (PDT)
In-Reply-To: <1400186759-24248-1-git-send-email-mreimer@sdgsystems.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
Cc: broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Matt Reimer <mreimer@sdgsystems.com>
List-Id: alsa-devel@alsa-project.org

The mono output PGA input only has four possible sources, so
omit the rest.

Signed-off-by: Matt Reimer <mreimer@sdgsystems.com>
---
 sound/soc/codecs/wm9713.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 5f69b52..caf0269 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -74,8 +74,7 @@ static const char *wm9713_rec_src[] =
 	"Mono Out", "Zh"};
 static const char *wm9713_rec_gain[] = {"+1.5dB Steps", "+0.75dB Steps"};
 static const char *wm9713_alc_select[] = {"None", "Left", "Right", "Stereo"};
-static const char *wm9713_mono_pga[] = {"Vmid", "Zh", "Mono", "Inv",
-	"Mono Vmid", "Inv Vmid"};
+static const char *wm9713_mono_pga[] = {"Vmid", "Zh", "Mono", "Inv"};
 static const char *wm9713_spk_pga[] =
 	{"Vmid", "Zh", "Headphone", "Speaker", "Inv", "Headphone Vmid",
 	"Speaker Vmid", "Inv Vmid"};
-- 
1.7.5.4
