From: Rosen Penev <rosenp@gmail.com>
Subject: [PATCH] alsamixer: Remove exp10 usage
Date: Sun,  1 Sep 2019 18:22:29 -0700
Message-ID: <20190902012229.15796-1-rosenp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DF07F80306
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2019 03:22:33 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id f19so5889998plr.3
 for <alsa-devel@alsa-project.org>; Sun, 01 Sep 2019 18:22:33 -0700 (PDT)
Received: from localhost.localdomain (76-14-106-55.rk.wavecable.com.
 [76.14.106.55])
 by smtp.gmail.com with ESMTPSA id n9sm3373173pfa.154.2019.09.01.18.22.30
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2019 18:22:30 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

exp10 is a GNU extension and not available everywhere (eg. uClibc-ng).

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 alsamixer/volume_mapping.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/alsamixer/volume_mapping.c b/alsamixer/volume_mapping.c
index 48cfbe2..29ab061 100644
--- a/alsamixer/volume_mapping.c
+++ b/alsamixer/volume_mapping.c
@@ -108,9 +108,9 @@ static double get_normalized_volume(snd_mixer_elem_t *elem,
 	if (use_linear_dB_scale(min, max))
 		return (value - min) / (double)(max - min);
 
-	normalized = exp10((value - max) / 6000.0);
+	normalized = pow(10, (value - max) / 6000.0);
 	if (min != SND_CTL_TLV_DB_GAIN_MUTE) {
-		min_norm = exp10((min - max) / 6000.0);
+		min_norm = pow(10, (min - max) / 6000.0);
 		normalized = (normalized - min_norm) / (1 - min_norm);
 	}
 
@@ -143,7 +143,7 @@ static int set_normalized_volume(snd_mixer_elem_t *elem,
 	}
 
 	if (min != SND_CTL_TLV_DB_GAIN_MUTE) {
-		min_norm = exp10((min - max) / 6000.0);
+		min_norm = pow(10, (min - max) / 6000.0);
 		volume = volume * (1 - min_norm) + min_norm;
 	}
 	value = lrint_dir(6000.0 * log10(volume), dir) + max;
-- 
2.17.1
