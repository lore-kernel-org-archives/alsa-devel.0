Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E64C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:00:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68072206CD
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hfO/mvc/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="amcogKLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68072206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB67A820;
	Tue,  7 Jul 2020 20:59:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB67A820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594148442;
	bh=dYDxYvPT32BLVDMVsQAF83e+xGeSLhuqg+mfXEUM7b4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hfO/mvc/O1XOVCYj1Siyz/dZ5GnnSacIj86T0VEGN3XSj1JbsCHIaS333H9IAsIcU
	 tbIY9v6IRkjrauLx+Cnz0Z1lri3FCKO++8X7fZ4JvNjbAwr6A38AfTQG0awqBz6T2n
	 M/NhQ8L9+xfVRmJiTDWDfpeCcxx8dO9CN0xdXzew=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77E55F8011F;
	Tue,  7 Jul 2020 20:59:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE818F8025A; Tue,  7 Jul 2020 20:59:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89F00F801F9
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 20:59:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89F00F801F9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="amcogKLN"
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A190C20771;
 Tue,  7 Jul 2020 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594148378;
 bh=dYDxYvPT32BLVDMVsQAF83e+xGeSLhuqg+mfXEUM7b4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=amcogKLNwPWNZWTJA/bClGo+zbp+dlirYL+aO6XBIv774Zp+ALWBpN5UqSwBomBDc
 Zsu72EkQYEJrg0wVmqiEn3br6EQj9S05pNcP7kK3xAH2PLZExIcsKG7YZNWfN5fcIY
 93yfGpg/J8a8ULQTSm/FuR8M/tU+NiMa4ML6SD9I=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 1/4] crypto: lib/sha256 - add sha256() function
Date: Tue,  7 Jul 2020 11:58:15 -0700
Message-Id: <20200707185818.80177-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707185818.80177-1-ebiggers@kernel.org>
References: <20200707185818.80177-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-efi@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@google.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.01.org,
 Ard Biesheuvel <ardb@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Eric Biggers <ebiggers@google.com>

Add a function sha256() which computes a SHA-256 digest in one step,
combining sha256_init() + sha256_update() + sha256_final().

This is similar to how we also have blake2s().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/crypto/sha.h |  1 +
 lib/crypto/sha256.c  | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/crypto/sha.h b/include/crypto/sha.h
index 10753ff71d46..4ff3da816630 100644
--- a/include/crypto/sha.h
+++ b/include/crypto/sha.h
@@ -147,6 +147,7 @@ static inline void sha256_init(struct sha256_state *sctx)
 }
 void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len);
 void sha256_final(struct sha256_state *sctx, u8 *out);
+void sha256(const u8 *data, unsigned int len, u8 *out);
 
 static inline void sha224_init(struct sha256_state *sctx)
 {
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 2e621697c5c3..2321f6cb322f 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -280,4 +280,14 @@ void sha224_final(struct sha256_state *sctx, u8 *out)
 }
 EXPORT_SYMBOL(sha224_final);
 
+void sha256(const u8 *data, unsigned int len, u8 *out)
+{
+	struct sha256_state sctx;
+
+	sha256_init(&sctx);
+	sha256_update(&sctx, data, len);
+	sha256_final(&sctx, out);
+}
+EXPORT_SYMBOL(sha256);
+
 MODULE_LICENSE("GPL");
-- 
2.27.0

