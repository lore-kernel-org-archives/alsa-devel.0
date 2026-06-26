Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2500FC43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:55:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24E3060238;
	Tue, 30 Jun 2026 13:55:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24E3060238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782820528;
	bh=EmKi2C493iDbBWdx+ptjz1WR/dnYiIh7do+rNIXRds4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=olJieVk5HLSDvBdj2V5sdhtXkbUXyGzpNPdadF2dic6F/v7wmg2/gAEZuoyuzFtFM
	 xR9MdVkKsHv9s45TEcEW2CksMfufhAhFoSf1+TA56VQgM0jTYRinb1UQCrOWKtXbDi
	 lotYw1RwWjSNVmzXST4hqQskxZvcAEdp+voU6FpU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 99255F80613; Tue, 30 Jun 2026 13:54:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 942D3F806A0;
	Tue, 30 Jun 2026 13:54:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C9B1F80527; Fri, 26 Jun 2026 15:48:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782481684;
	b=ADbZJOW6d7mEo956wd/TwnnZ9hG7w9D1D6vZRicePb+Q7oLDrqOSYkghPoB51QBbcjp6
	 x2rr9w1O7VKIXVZm3JWFj+tqocAoisxCBnrlqAXgazoWQh/g3zgs5eT/LQf68Pv13CB+m
	 4zP705Iqh++OFfm+unp9W4O2kcpGIgyygzdHuedgeIB0i/xBDpEJVUis+Ma4jk6GfLDCN
	 NQIucll41us5Eh2+Z/wehqVcFiJGWAH3ddyTa/Sfdi1QaQZ5cUeS7eR7nhJDWD1ahR7Oj
	 QcL56+8Qxlix/kvQxy5rE7jxEwBEX8CmhtqMg6SwQYHNb9u1Jen7e9sOA0DOtAuCkig==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782481684;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EmKi2C493iDbBWdx+ptjz1WR/dnYiIh7do+rNIXRds4=;
	b=h+eCxR37hm0h/tmyKbwWqulLDUMbnXml2aasO3HPI3ze07LKO6UR2hhTuWilQMuVOeDU
	 1cdFS3QrQmdtF2NASIyo8mtQFPZu5xJA7Npt2feKk0T/A3vPhY9b142k4VtH0LBt0XoSx
	 YhDWaDmpOIicsYV7Qw8Spss3t7Prckjl4Gwu8To+ZNH+ZO9nDGgWf+rgcPUQ1kZIR41ql
	 lCtn6is53BRt3tGuO5ZtcKQqQhIEZnahXbHJmybq0yohux0kBUS8Ugo6WMDk6mOlihTWc
	 lOoQoaSBf9YUotjwhfJBF3yz7TygtD5tSPDys1+RFaJLj36k0oX9G8P03B5bUyXm03w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LoKwwk0d;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 78500F8025A
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2026 15:48:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78500F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LoKwwk0d
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-462342ac290so1039300f8f.2
        for <alsa-devel@alsa-project.org>;
 Fri, 26 Jun 2026 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481682; x=1783086482;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93eF1nP8FA0jQ23r3uigA9hOS1jY1X3Q7tz40Q/msFw=;
        b=LoKwwk0dvyLyHhvdkBG06W03TB+3GFjfuW7ZBKwT6veQBR9ihk/yLY4FlFpQ+Y5Cho
         gmOTeEKbAKWqwRc7IHNS05J/8XRrJ1uv3bU5lO8ipMrVcvr7P6sZlih9dF8AY3V1h787
         IBVZVuhSv7541bek550HAAIq3Y3IjWiYApt8JdviaymoKGLzg4JbWjdvTwp1IDGKVOGJ
         1Uswn1ZXBYbwNFffx5awq0Mjqtb5xmX8YnolVNJwDz4C9xvRgCC1gZlME4IrlrKG9g2U
         ZLC2EIzNVrVE/1MIp0fYdcsI3/znr/tkdwRH958a9iPAF6ba+sy7QcoTm1yu+P41m4ie
         HJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481682; x=1783086482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=93eF1nP8FA0jQ23r3uigA9hOS1jY1X3Q7tz40Q/msFw=;
        b=DMmqXq40IIp/9jD7MlPVXJRIaVlhX61rS8cP124IAtwME794kzl/LDtoTpmeLeEzTp
         LQvik41tHFn81nxfTb2NGT/RiNnmU/ORGQGytmu5l3JKf+0Qwdd2+Bvo0mMSRfKZPbHX
         dVWMZrHSwbv9SYomPmg3ar/oT5aGiMMsmJhElyX42JMhT0VVGY4+TW5Eb0Hg4/L2la3u
         PhLUKe+L80Al+awr9KX7zVrl+lgLcmXqueFtOlxgcALz9c2ba57OfAzuo+4imOyfdYoK
         bA1/JF7ps6H2glVCvXC8HsLLSb25vlLEgvqDJlQqYtEhuLpBgUA+HrKQzVBrjZRvp5EI
         9AGg==
X-Gm-Message-State: AOJu0YyTS7PG5441oDpQu/htczIjKM84nfxgj/YLYO8V4V9l7qhnFxl/
	i8q2g2+NBguXP66f+gRaAY4LdXNlQTenKJz2+MY6Dwr6l9MQiTv8/UnR
X-Gm-Gg: AfdE7cmPHZovqKudsBs9kK1/hfLblr3KftlTT2kzXgnEfTKevCLTm7UPQ4DNy2k8Icc
	7w4r1stHF8qdUQPx5F/7Uv1aLoYMKFt+t5fQO7zH76mUY198IbIPbLvPmwAmJqN7VucsuvH1DJ/
	HJLvb+V+ZOzVSyIOmC/KqBX5vBpsM60NhNbe9nFyfDaTBbG6UvwuCP1/KsNzjfU2SGaU80gX7EU
	tdMc2r+XX9/+4NMcSkYZLB/ZttnXw/XZNs0lH3/d0n4XKK/EWq6MUAIQJAA41gqQrvPuiwKIel9
	EvZ8EQK/p6CKN4Lr8FN2+hFx5vtCSSxsVyKrPaXjqlBgJkXn2nIBWqxa3ldSpsj135HDI2qOhdn
	XpJfocmG1dK3QJ8mp/Nq1ZEj5oZG3roxgjyKaBj9m5jH1dgyvF7i0+qEW+9EAfMVnIBdP/96vuw
	HqqBNa8asfOQgwumwwEb0YB7rfuaWs7KlR6faA2kkUcMgWmP1bWMlJHA==
X-Received: by 2002:a05:6000:2f82:b0:439:c18f:5aaf with SMTP id
 ffacd0b85a97d-46dc2359072mr12358019f8f.34.1782481682461;
        Fri, 26 Jun 2026 06:48:02 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il.
 [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:01 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/6] ALSA: compress: fix buffer leak on set_params driver
 failure
Date: Fri, 26 Jun 2026 16:47:05 +0300
Message-Id: <20260626134709.27883-3-nevergfx1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626134709.27883-1-nevergfx1@gmail.com>
References: <20260626134709.27883-1-nevergfx1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: nevergfx1@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: TKEETJL7LSU5XGALO2VFD7UM3SDKIJ4U
X-Message-ID-Hash: TKEETJL7LSU5XGALO2VFD7UM3SDKIJ4U
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:54:02 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TKEETJL7LSU5XGALO2VFD7UM3SDKIJ4U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_compr_set_params() calls snd_compr_allocate_buffer() which stores
the new buffer pointer in runtime->buffer, then calls
ops->set_params().  If the driver callback fails, the function returns
the error but runtime->buffer already points to the new allocation.
On a subsequent set_params retry, snd_compr_allocate_buffer() overwrites
runtime->buffer with a fresh allocation without freeing the previous
one, leaking kernel memory.

An unprivileged user with access to a compress offload device can
trigger this repeatedly to exhaust kernel memory.

Fix by saving the old buffer state before allocation and restoring it
if the driver callback fails.

Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
Cc: stable@vger.kernel.org
Reported-by: Omer Cohen <nevergfx1@gmail.com>
Signed-off-by: Omer Cohen <nevergfx1@gmail.com>
---
 sound/core/compress_offload.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index fd63d219bf86..XXXXXXXXXXXX 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -665,14 +665,28 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		if (retval)
 			return retval;

+		void *old_buffer = stream->runtime->buffer;
+		size_t old_size = stream->runtime->buffer_size;
+		unsigned int old_frag_size = stream->runtime->fragment_size;
+		unsigned int old_fragments = stream->runtime->fragments;
+
 		retval = snd_compr_allocate_buffer(stream, params);
 		if (retval)
 			return -ENOMEM;

 		retval = stream->ops->set_params(stream, params);
-		if (retval)
+		if (retval) {
+			/* Restore old buffer to avoid leak on retry.
+			 * Free the newly allocated one if it differs.
+			 */
+			if (stream->runtime->buffer != old_buffer &&
+			    !stream->runtime->dma_buffer_p)
+				kfree(stream->runtime->buffer);
+			stream->runtime->buffer = old_buffer;
+			stream->runtime->buffer_size = old_size;
+			stream->runtime->fragment_size = old_frag_size;
+			stream->runtime->fragments = old_fragments;
 			return retval;
+		}

 		if (stream->next_track)
 			return retval;
--
2.43.0
