Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3124FC2D0A3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:52:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A642222B
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dtnWVa+4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hf6tvqnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A642222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FC461684;
	Tue,  3 Nov 2020 08:51:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FC461684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604389929;
	bh=wkQ8lQXa+pPoFc/lTHNgupAJvnWopotIGxxCxhCLGcg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dtnWVa+4wxzC15rbVO8/sKX7c480l3hb6eSaV5DVdyM5OpLcY77fjgJBriDGPqTxp
	 dwAoERgLLX3F0Ik0rfdyOSfijR6IHUJuUBfxHX2vTrfRkFSKuHVuW9LHAJlBO3VidD
	 agCFDCF8aKALfNReiyZs7KiPyE+foKg/ApKaEc+E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 517A3F80524;
	Tue,  3 Nov 2020 08:45:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EDAE6F80256; Mon,  2 Nov 2020 16:20:52 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E82F0F80229
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 16:20:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E82F0F80229
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com
 header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hf6tvqnc"
Received: by mail-wm1-x341.google.com with SMTP id h22so9885921wmb.0
 for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2020 07:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=//ohTnlCNdzVCN7+X/oV4S8f/hxX7VdQ1OV3L6uwfhQ=;
 b=hf6tvqncwp3fkOIckHP3XNhZspBIs+DJCE72k4fKwWNNEV8tVYATPrk61RVN2LLtoy
 wyuT8kZJhciWHJYnIywhLp+tPKS38UhRZoDdJRNvydyfnF4jPWOOLNFaCIa5fWpPbqiE
 CPEcfMQCT8yeENUO+TRhPv8NZwnqBa/5qBgOFPacWV7BhHFuUJ5ASnX9vmHxuqU/2Ygy
 yl+QCczTs9fSAAWT/g0PiS+PxK7jWNW2R3D8R0j5FcPe+c2M0+55tW8i3tKhxnOrTffM
 d3zN4lSBg/UxZjb51Fwl4foaEs43EhxOe1ue2FxQvf65j62JS7V+E/ior/FALPI70AY8
 3BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=//ohTnlCNdzVCN7+X/oV4S8f/hxX7VdQ1OV3L6uwfhQ=;
 b=mkbLfVTzzqDUOQ4Q5uH9hlTqiPn+9wQNk1pv59RAJT9hmAfiAoGMNihEBDI3B8xKV0
 znlnVnBGcnRtnUTNDdPG7v3P1xjnGk16uOGWTyIfjyTo4BNhg6MdwhyrX+hojBAjxuRH
 OfUsA6xGdwNgqOP0VezWoZ/kX2iBK1IiNSYzfNDMhQer4RkcKHSf95GD+LxqFCYv4kD0
 jJYPnnC4eKUVQAMQlGPtFvSVt0SZE+u/GVJlmzdfw/ktgF23+l4tJ1HXtUZ5goihpql1
 Vpm4xQ6VOcI4q1wdBWoxr+j7GZs/dGmqeD8YqcTJCEQnnW39VxJDeHQ8cWVYnbrs15Xb
 CMvg==
X-Gm-Message-State: AOAM530YLlsRQiKKLgzSoWhohOG7lbpuFvKU+K59pI7n58ugZcSgm1ms
 ArMdgw+l61PGmwA2HDIN3yBBTQ==
X-Google-Smtp-Source: ABdhPJxGlAsjxjuqTsCnImH4txzUDEh+1CeV9f1Ji5E5b7hmF0/rUwH1lj/uHarBz/RRB7bv+TJwGA==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr18034156wmg.124.1604330443460; 
 Mon, 02 Nov 2020 07:20:43 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr.
 [90.8.158.167])
 by smtp.gmail.com with ESMTPSA id b18sm15138014wmj.41.2020.11.02.07.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 07:20:42 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
 Robert Richter <rric@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 1/8] mm: slab: provide krealloc_array()
Date: Mon,  2 Nov 2020 16:20:30 +0100
Message-Id: <20201102152037.963-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201102152037.963-1-brgl@bgdev.pl>
References: <20201102152037.963-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2020 08:45:22 +0100
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-gpio@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-media@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, linux-edac@vger.kernel.org
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

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

When allocating an array of elements, users should check for
multiplication overflow or preferably use one of the provided helpers
like: kmalloc_array().

There's no krealloc_array() counterpart but there are many users who use
regular krealloc() to reallocate arrays. Let's provide an actual
krealloc_array() implementation.

While at it: add some documentation regarding krealloc.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 Documentation/core-api/memory-allocation.rst |  4 ++++
 include/linux/slab.h                         | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
index 4446a1ac36cc..6dc38b40439a 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -147,6 +147,10 @@ The address of a chunk allocated with `kmalloc` is aligned to at least
 ARCH_KMALLOC_MINALIGN bytes.  For sizes which are a power of two, the
 alignment is also guaranteed to be at least the respective size.
 
+Chunks allocated with `kmalloc` can be resized with `krealloc`. Similarly
+to `kmalloc_array`: a helper for resising arrays is provided in the form of
+`krealloc_array`.
+
 For large allocations you can use vmalloc() and vzalloc(), or directly
 request pages from the page allocator. The memory allocated by `vmalloc`
 and related functions is not physically contiguous.
diff --git a/include/linux/slab.h b/include/linux/slab.h
index dd6897f62010..be4ba5867ac5 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -592,6 +592,24 @@ static inline void *kmalloc_array(size_t n, size_t size, gfp_t flags)
 	return __kmalloc(bytes, flags);
 }
 
+/**
+ * krealloc_array - reallocate memory for an array.
+ * @p: pointer to the memory chunk to reallocate
+ * @new_n: new number of elements to alloc
+ * @new_size: new size of a single member of the array
+ * @flags: the type of memory to allocate (see kmalloc)
+ */
+static __must_check inline void *
+krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t flags)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
+		return NULL;
+
+	return krealloc(p, bytes, flags);
+}
+
 /**
  * kcalloc - allocate memory for an array. The memory is set to zero.
  * @n: number of elements.
-- 
2.29.1

