From: Michael Forney <mforney@mforney.org>
Subject: [PATCH 5/6] Remove unused empty struct
Date: Tue, 11 Jun 2019 23:08:13 -0700
Message-ID: <20190612060814.13534-6-mforney@mforney.org>
References: <20190612060814.13534-1-mforney@mforney.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEA3CF89730
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 08:08:23 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id f21so2301217pgi.3
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 23:08:23 -0700 (PDT)
In-Reply-To: <20190612060814.13534-1-mforney@mforney.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 src/pcm/pcm_direct.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/pcm/pcm_direct.h b/src/pcm/pcm_direct.h
index a71aab13..221edbe1 100644
--- a/src/pcm/pcm_direct.h
+++ b/src/pcm/pcm_direct.h
@@ -186,8 +186,6 @@ struct snd_pcm_direct {
 			mix_areas_24_t *remix_areas_24;
 			mix_areas_u8_t *remix_areas_u8;
 		} dmix;
-		struct {
-		} dsnoop;
 		struct {
 			unsigned long long chn_mask;
 		} dshare;
-- 
2.20.1
