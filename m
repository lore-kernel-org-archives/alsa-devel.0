Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8801C43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:57:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32B116025F;
	Tue, 30 Jun 2026 13:56:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32B116025F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782820620;
	bh=Fmj0UvlNYeh0M8dAvXiFurkpaGJ1mwBSxgmJkJxwKCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PLVTZwEFXzPcD8bl1s7ETGqW+oZ+HVO/3DkQN0DVwpujp1lQkGfATIyLYvxJNNNMy
	 yrxvq2/cuGPJacWJ0QV430tFp1wGFEc/A8QaMfvYW9++hGrpLyt5YV1S/6kZaxWx5I
	 5EZm/xJQeUJg2pT3yHOB7OgYTjpYRH/NT5bIPU+Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F896F80750; Tue, 30 Jun 2026 13:54:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A90A3F8075C;
	Tue, 30 Jun 2026 13:54:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22956F80549; Fri, 26 Jun 2026 15:48:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782481690;
	b=iPSUDfhFHyEUv0bSavN43YCPND7ZqYIC078yD+rZnpBWOuC2gYnYd/lb9gDRbjRMg9fp
	 AOtDUnBldPzGhVmk2XXfhEdX3toFB7V+DjZ2ugFJnv66Uy0xEYjS0ZFT0gag1d20e8oUU
	 XsMM6T6mHgPl80GMOI144yEmjO9xSSHO0zrhvsp6hAlwFi1FLR4EkZGJ6ptpvfUhaHATf
	 y2YNiOm5o8MNiCO63H3PCu7T7foWwFOr4C4XX9IIs5e05Duk64nIKUX1XRKD3stmVJEYL
	 aTbc4np2ddtheXvpYIx6znIPw4BZ+OZU6QDHy960tNUQltUV2XpfbSgwJ2+C4o20mhw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782481690;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Fmj0UvlNYeh0M8dAvXiFurkpaGJ1mwBSxgmJkJxwKCA=;
	b=CURb85kpvKkqsA1K5DZ0vtR72jNDu4Db8pgGuovxneLQG8eDEV16lqcHNuEsmwehjINW
	 C2OJzMGjCToVm+v1KWCOH109nkw/gDsPLe+RdxLecUkRgUyEDn9EEP6NC2984UvXBaLfv
	 TRdqhLIeysyq2ptXnN6gGQJQXiRGgqqvs4i+zQD7M1R0nObfcXtQ16mU0eapcMk9lO6ff
	 PEjAFi/5kpTeb34Wni+ksBP2H97p+U9rkeLIBoumcXOJknCgGBd5jv21QakKD8x/X3dxQ
	 XZb9O75QrPhVesidj0B7tZ/ENCXyZAJ7GBinTKbP5VOdyZHEX/jCzjCWOGlgIGy2EDg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mlhGXnR7;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9128AF800D0
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2026 15:48:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9128AF800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mlhGXnR7
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-491609cdd8fso6495265e9.2
        for <alsa-devel@alsa-project.org>;
 Fri, 26 Jun 2026 06:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481689; x=1783086489;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rgr46SxhdjeIkGhYXOPemxka+uic54Qm3KOgU974BkA=;
        b=mlhGXnR7Ct33p1+APjEm9539gDifaeQHljBiBmYibTgFE8vbo0M35z1OJqkRZin73I
         7/SAbh+YkmAgesRETJ/pzbjT2wxVKsEGfqSM4FDBI1SyrGcomXuGy0Lf93igy059Nzyi
         IzpPXp906sadPn0dQR0oKcZamngcnnAwfMFiwAoyUyqFX3gjJRnormg5+AY/fhQx1Mk3
         aaqJfQ3OyI95JhHpW75+DWHXfFdmy3EvwM2QBQ0HOervhZYZMCmLmRc4AgPRLxoOg9uN
         oDdkrENIWq+K9PGizAnvwIkeU+UXroUwsGefnjfnIZSA+azEdeAgysGbRDoPfHzSvgT8
         K/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481689; x=1783086489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rgr46SxhdjeIkGhYXOPemxka+uic54Qm3KOgU974BkA=;
        b=lI4kch1Z5HtfKEw0oWMdaIX4gH5SNq8QVjVylMcg4hETHtuTrl+a96bINUEJAuK8JX
         u6r/xYNMzWgjTouCnZyVdxPo5Dfh+DPt/jGEJr9/cxvfKWXD+n3yIkrHBfX7fwmmWX8e
         4UV1/30vsHVvRMzBdRtYA2q197956eH1YfzqjdsBIKDtgXB1m4M5eDAGvoS2jhgEx/Tz
         yGZpCxMM1E9DkiMFDHvvjrAzpB6xoaqcsyHjL977RDi4zYLiomnNua1LOWqgdm3DfU+m
         shgP6YepnYnks55h6787a0g0QGdIC67AcolaCFLx2VEkVmuFnn2o3f5SXbb9M9Hk3BA6
         mxvg==
X-Gm-Message-State: AOJu0YwCA/zmBKzRPad5r3n5KgQEtAcgNtp2gD395hZ50HlBSJdj8H+1
	ZnOYswHk3g1a473YLFrdldzrtmuu4tTBx5WFJ/Vtd+Z+Hdb0NQHlervj
X-Gm-Gg: AfdE7cmFl9T0MuZFGF81qaypOPArtjtSA5JEHsFOl6O/u1RRkbtABCMN3Smm4YD5TfX
	jBFW4M8WjjQG5uPXPBiAEFMFZx+mUZ9iGibkYuS8XArfthDgGh2eqbsCFtn2+7V4mvQjrEO+YxW
	aqlmNrQi+ks3fg5Yhu8kedfx+pGf0jMVI32VeqUQBs7FFY2XOCDsdfUdbs/4NDgCL4QYroN+8yv
	/anASe1YnluiYNI9FNpbVpbp2Pwj9JCDokPM6E6Xx5nXdTTpOG4e739ojYcAO3IeMUQhMElOZaI
	BOJsac3j1YydB35SlW6mn1Dqe6GNlXLoGmsx5+KNVhoAE+8rN3Qt3qb7gQrzfxrh2+Pn0QGoNjt
	8+URgCyyXrvmaT2B2fajQ2WD/FLXyzv5rkh8AwcZea0DbIKYY0B2PrcT27kgtj2J7NQH740Ckw3
	6IdGqaxV8wwqcKJcOn/ivWiN3G1Uyw+IE8791Jm32KZhyOra4NCisrDg==
X-Received: by 2002:a05:600c:a086:b0:492:6954:1036 with SMTP id
 5b1f17b1804b1-49269541111mr57411275e9.14.1782481688782;
        Fri, 26 Jun 2026 06:48:08 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il.
 [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:08 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 6/6] ALSA: rawmidi: propagate resize_runtime_buffer() error in
 input_params
Date: Fri, 26 Jun 2026 16:47:09 +0300
Message-Id: <20260626134709.27883-7-nevergfx1@gmail.com>
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
Message-ID-Hash: 3WMW5IDJXZ6WHCAAN4GRWWMGUPIUJNNA
X-Message-ID-Hash: 3WMW5IDJXZ6WHCAAN4GRWWMGUPIUJNNA
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:54:07 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3WMW5IDJXZ6WHCAAN4GRWWMGUPIUJNNA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

snd_rawmidi_input_params() calls resize_runtime_buffer() but ignores
its return value, unconditionally returning 0.  This silently swallows
-ENOMEM (allocation failure), -EINVAL (invalid parameters), and -EBUSY
(buffer in use).

When resize fails, the framing and clock_type parameters are still
applied to the substream, but the buffer remains at its old size.
This leaves the stream in an inconsistent state where the configured
framing mode does not match the buffer layout.

Return the error from resize_runtime_buffer().

Fixes: 08fdced60ca0 ("ALSA: rawmidi: Add framing mode")
Cc: stable@vger.kernel.org
Reported-by: Omer Cohen <nevergfx1@gmail.com>
Signed-off-by: Omer Cohen <nevergfx1@gmail.com>
---
 sound/core/rawmidi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index XXXXXXXXXXXX..XXXXXXXXXXXX 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -784,7 +784,7 @@ int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 		substream->framing = framing;
 		substream->clock_type = clock_type;
 	}
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL(snd_rawmidi_input_params);
--
2.43.0
