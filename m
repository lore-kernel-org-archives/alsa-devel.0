Return-Path: <SRS0=HClt=XR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1599CC4360D
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Sep 2019 03:33:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94844208C2
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Sep 2019 03:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sHi10XPc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tESkEsjo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94844208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7E101673;
	Sun, 22 Sep 2019 05:32:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7E101673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569123203;
	bh=GiMFFrj2h5XDmnK2Bro/gZsKvNKdRi/nwiR/pmOoQpw=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sHi10XPcL4bDYaQ+iwDZvtB8o/Yc3boARg7QKL/ATrDEDjoVNAD8UmUQYXCyVSOWK
	 53z3pLcQgJsd7SgWcQwcWnjzXg3T5U16oNaoclEVuAQyWsFS3QgGBtWqOQyJ4QGr3X
	 COIPi68X0P1madx5wgma2fWFc3eySJUe/PGdVxR0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C195F805F7;
	Sun, 22 Sep 2019 05:30:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6AA69F805FE; Sun, 22 Sep 2019 05:30:37 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC85CF805F7
 for <alsa-devel@alsa-project.org>; Sun, 22 Sep 2019 05:30:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC85CF805F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="tESkEsjo"
Received: by mail-pg1-x533.google.com with SMTP id 4so5965054pgm.12
 for <alsa-devel@alsa-project.org>; Sat, 21 Sep 2019 20:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9Sm5R9yykGoPjeHN7OkLR+8HnHRjBpk/gYjTySZNOLU=;
 b=tESkEsjoc/5465aPQ3SLR5qOZcy6Cm68bJNIBRp1nW73PG9U1Lt/ESEfXwG+8jfeUq
 0XFZuj5zW+Okw7bv9xDIP5w34tI9R9QcEtQBYaGnIW1/dEoigaWZcpG2Pcy1H9vF4mXn
 ETPyLHq6LQaSoepg6a6RB+pSCfYewClICMuQeHCq7ES8xD78M4mOaPeCH0FKe5Yv+B7U
 qKHvx2bLJC1MBBo+/edTw7eHEcO4Jnee5YK5UOlrq5hMlAOgllZNkmwEciS0kxpOZSkD
 2V8yJ/AGX9D792fe0nLh7KK7s1AJ7DZ/tgpcyYEqyqZ723+aoErTB3cZ/0ssFX/nxQcY
 ojog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9Sm5R9yykGoPjeHN7OkLR+8HnHRjBpk/gYjTySZNOLU=;
 b=cQFVgvXnwZKHhJKyxMTVWCEsPdUyh0gL9u+02uf+S22TqkweJm+XHxb7WYUzJDwVkQ
 mi8zK8ssy3gexOsBsjKWZUjV8MlwYYMjpiIFMsakte9k2nYowHHAA1DclbwJ2XxQJb14
 vKiChub+GE+Yn/egBki+CU5UUR5osOmFTPX+GD+06nQsRlJzwIsIFqiXDpqVox2Jq3dH
 NYYHHoUifUTSrL6Ifjq3APC7bQ/UNTAJiDaPE5hsM2iTyeZu3+GslQKHQti+kOdmnXPL
 zkhayLYov+i4F7UPF7HqjhKnzEeJd6RVj/iZsthjOEFa4OIIHlISu9nnBwJK1BIqHH9t
 4z0Q==
X-Gm-Message-State: APjAAAWoYaTWUVYjs01ye0MH1pqXlTSqqRaz0kQ+8yJD+0NXp5GwVSYI
 OSztrlZFp2Ktl0+debcplUul0pac
X-Google-Smtp-Source: APXvYqyOo5yYgeWcoOIvrSvQbj64krzBOCuRSXkwC2Om8FT1rpwzvU3/UdzLcOQ8di31WtfY9+bgmA==
X-Received: by 2002:a62:2702:: with SMTP id n2mr26759787pfn.73.1569123032645; 
 Sat, 21 Sep 2019 20:30:32 -0700 (PDT)
Received: from localhost.localdomain
 ([2407:7000:aa04:fb00:ce0f:a0bf:1ece:a196])
 by smtp.gmail.com with ESMTPSA id l12sm4559532pgs.44.2019.09.21.20.30.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 21 Sep 2019 20:30:32 -0700 (PDT)
From: Ben Russell <thematrixeatsyou@gmail.com>
To: alsa-devel@alsa-project.org
Date: Sun, 22 Sep 2019 15:28:53 +1200
Message-Id: <20190922032853.6123-4-thematrixeatsyou@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190922032853.6123-1-thematrixeatsyou@gmail.com>
References: <20190922032853.6123-1-thematrixeatsyou@gmail.com>
MIME-Version: 1.0
Cc: Ben Russell <thematrixeatsyou@gmail.com>
Subject: [alsa-devel] [PATCH 3/3] pcm_local: assert() when using mutexes
	incorrectly
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This makes it easier to find pcm mutex handling errors.

Signed-off-by: Ben Russell <thematrixeatsyou@gmail.com>
---
 src/pcm/pcm_local.h | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 649d84f2..c1f881a6 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -1153,23 +1153,39 @@ static inline void sw_set_period_event(snd_pcm_sw_params_t *params, int val)
  */
 static inline void __snd_pcm_lock(snd_pcm_t *pcm)
 {
-	if (pcm->lock_enabled)
-		pthread_mutex_lock(&pcm->lock);
+	int lock_err;
+
+	if (pcm->lock_enabled) {
+		lock_err = pthread_mutex_lock(&pcm->lock);
+		assert(lock_err == 0);
+	}
 }
 static inline void __snd_pcm_unlock(snd_pcm_t *pcm)
 {
-	if (pcm->lock_enabled)
-		pthread_mutex_unlock(&pcm->lock);
+	int unlock_err;
+
+	if (pcm->lock_enabled) {
+		unlock_err = pthread_mutex_unlock(&pcm->lock);
+		assert(unlock_err == 0);
+	}
 }
 static inline void snd_pcm_lock(snd_pcm_t *pcm)
 {
-	if (pcm->lock_enabled && pcm->need_lock)
-		pthread_mutex_lock(&pcm->lock);
+	int lock_err;
+
+	if (pcm->lock_enabled && pcm->need_lock) {
+		lock_err = pthread_mutex_lock(&pcm->lock);
+		assert(lock_err == 0);
+	}
 }
 static inline void snd_pcm_unlock(snd_pcm_t *pcm)
 {
-	if (pcm->lock_enabled && pcm->need_lock)
-		pthread_mutex_unlock(&pcm->lock);
+	int unlock_err;
+
+	if (pcm->lock_enabled && pcm->need_lock) {
+		unlock_err = pthread_mutex_unlock(&pcm->lock);
+		assert(unlock_err == 0);
+	}
 }
 
 /*
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
