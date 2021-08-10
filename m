Return-Path: <SRS0=vr1N=NB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4054C4320A
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 14:51:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC4A60F25
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 14:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DC4A60F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CFAD847;
	Tue, 10 Aug 2021 16:50:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CFAD847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628607094;
	bh=6bWvrTdryJ9Kr+Y1iNZlAE5XmrjtHq6EDhqbPAS8m0o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CvMSq4k4wrh4/W5JsHfiP80a/R/xvadUh837tYWphjGuGDO69zPkiLUxeUF05GRe/
	 J65QcDoQDizgG6kUTCb9D+J9HT9FMbsuCRWJ4zkDj2ZdPhmAIYXKuptBY4VvRjMnib
	 RQayvM6YxBJ2rwsRcbfU4lDiBRYYnKFCO3WRvB5U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D25DF800FD;
	Tue, 10 Aug 2021 16:50:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB031F8025D; Tue, 10 Aug 2021 16:50:42 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFCF0F800FD
 for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2021 16:50:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFCF0F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="mFTNiEeP"
Received: by mail-pj1-x1031.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so4726874pjr.1
 for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2021 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6bWvrTdryJ9Kr+Y1iNZlAE5XmrjtHq6EDhqbPAS8m0o=;
 b=mFTNiEePHCF7XmyJghvQPKq30kaOpRtFtuYP6xhlzI6pVuGt2sl7m0mZrrark+VIUG
 yoCyQPbjLzBvvKkYaPnOpnoVrtR+mJOHttmB3QyYTrXt8g6gbr0I6/v3wrdqE12UkgfS
 GjkpHMA9yccRsMnmaODhdCBUWYLX+Bouc4Z7DN+p8mPNsfslT+54rv+4E28P4EubVlPq
 GMlF5RYYOVcym8KVDjuyDJSgIbjn4FegzlT4rnIm8SMOQewO1vs+Nlc+mSOuyDLVbGOz
 YE+dQ4cmhGLTkVXIvHZDB7QeDLGC7zWrnb4BtkLVBFf97YSYvkkzmY3Flcm07LHtq6x7
 FE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6bWvrTdryJ9Kr+Y1iNZlAE5XmrjtHq6EDhqbPAS8m0o=;
 b=Lcmzxbj7HCGjgHHRULSvkNuIeCI1DuhRlrhn7lmVobj+b26G6G54R+T/WfSaLI21YG
 327RIZxY9HbYK4qLxSzIelau4ryjjtKR/sjP0+myWLDCTDnVhxeDINUfQTZVMZa5fQMc
 3mSvaLztVEZhmOT2P6OTv+ukD4g5qa0M8pohumXzHewFp5skrsMtCE/GUW9VSBpDqLT8
 /wvba5uhtn/vG8K3eNdpjiBZQMsSno/sDpqtVrrnCkYmAcZe6aCOCCi+xq/b8Rc7TKkQ
 C9ByRhDfPZQsKQogWhLunXYqlHSHV28OHS2tKgBul9pmEkJ9hasuUR2d3l1SaGSH1uox
 6lxg==
X-Gm-Message-State: AOAM532SA6/kvgYcngs9MJzzcRIDkl8Bc7Zn/VodWAyFf1SPDHsO5t4C
 B1P4b7/U1r0dAThg1Q1Rk3s=
X-Google-Smtp-Source: ABdhPJwkOSfcfZo6LGbrekBJx5KKCk3AMDZVd3aoAe8eSroO+qK8UyLljCVix2ubOaGyFkcjCkMulA==
X-Received: by 2002:aa7:8c56:0:b029:3c2:ca37:800 with SMTP id
 e22-20020aa78c560000b02903c2ca370800mr29525852pfd.54.1628607033175; 
 Tue, 10 Aug 2021 07:50:33 -0700 (PDT)
Received: from localhost.localdomain ([143.244.60.168])
 by smtp.gmail.com with ESMTPSA id u20sm27404885pgm.4.2021.08.10.07.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Aug 2021 07:50:32 -0700 (PDT)
From: youling257 <youling257@gmail.com>
To: imre.deak@intel.com
Subject: Re: [PATCH 1/2] ALSA: hda: Release controller display power during
 shutdown/reboot
Date: Tue, 10 Aug 2021 22:50:18 +0800
Message-Id: <20210810145018.24001-1-youling257@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623134601.2128663-1-imre.deak@intel.com>
References: <20210623134601.2128663-1-imre.deak@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, tv@lio96.de, alsa-devel@alsa-project.org,
 intel-gfx@lists.freedesktop.org
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

it cause my intel 7820hk cpu failed shutdown.
