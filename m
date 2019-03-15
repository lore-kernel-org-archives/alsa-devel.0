From: Chih-Wei Huang <cwhuang@android-x86.org>
Subject: [PATCH 4/5] Android: avoid link_warning
Date: Fri, 15 Mar 2019 17:17:05 +0800
Message-ID: <20190315091706.26772-5-cwhuang@linux.org.tw>
References: <20190315091706.26772-1-cwhuang@linux.org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6162AF89705
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 10:17:47 +0100 (CET)
Received: by mail-pg1-x543.google.com with SMTP id k11so6014183pgb.8
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 02:17:47 -0700 (PDT)
In-Reply-To: <20190315091706.26772-1-cwhuang@linux.org.tw>
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
Cc: alsa-devel@alsa-project.org, Chih-Wei Huang <cwhuang@linux.org.tw>
List-Id: alsa-devel@alsa-project.org

It will be treated as an error.

Signed-off-by: Chih-Wei Huang <cwhuang@linux.org.tw>
---
 src/pcm/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 11aec805..4bb5fe5f 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -1053,7 +1053,7 @@ int snd_pcm_hwsync(snd_pcm_t *pcm)
 	snd_pcm_unlock(pcm);
 	return err;
 }
-#ifndef DOC_HIDDEN
+#if !defined(DOC_HIDDEN) && !defined(ANDROID)
 link_warning(snd_pcm_hwsync, "Warning: snd_pcm_hwsync() is deprecated, consider to use snd_pcm_avail()");
 #endif
 
-- 
2.20.1
