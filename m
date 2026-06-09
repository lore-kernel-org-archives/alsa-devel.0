Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1205CCD8CB9
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:58:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33EF6601DA;
	Tue,  9 Jun 2026 20:57:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33EF6601DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781031488;
	bh=G2Z5NS2xDG4M9YKrcDluy8jz5tamfGMg0EPSN0X7lE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IuNpHIWiiyig5C1MiyIhTPwnji7Dthc58j+s3wtwq/A11kp4tl/jmEcOpcnBdf2A5
	 /rP3ZnsCzRJD8Bg8u1Jtic3OU4ua9612zgRE8ICWRrKKFokr5Z5LQ/GOiYMDXl44Cq
	 H95Bm8I9e3RzgkKMA+njqkZpDwLabqks4tYONmfo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7BD66F805FB; Tue,  9 Jun 2026 20:57:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 292B1F805F3;
	Tue,  9 Jun 2026 20:57:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BE49F80496; Tue,  9 Jun 2026 20:57:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781031450;
	b=R+PJtwXAjabKNX32bv6LC192DudJ/IAQTc9BR+5djli/uBU8mJt4YigYJ2/qlN8dGCFm
	 XvVAYxdv6TOFqElh/r5rL/LuN8S5UNs96pjcmkh+wJ8CkeoAR0d+5l3ww0FFC3qVVdZ1C
	 uO8sQePhTfrtVSe9DzeVspvGlMRqYzs0p5plcNkNEqc6Nl5H1UAdDGjf//iepKNF9snV3
	 GPd0+dHjfI8IszV8Cb0R6rs5sBO+SHrBlzKz/r3qJoo9xJ9Ph7QCoHD4L3dCxflLWul9/
	 UHwz9LVprQM6mz1sIRSdss5NNz08xzyfc1eAq5laHesqel8abrZi4gNbEsguhtqm8lw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781031450;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=G2Z5NS2xDG4M9YKrcDluy8jz5tamfGMg0EPSN0X7lE0=;
	b=jigbZ0kZxY6SsEQmm+q2J1R8JWbcU71xukSFVR+VqDRzKo1FhKLYQLyL/DzcGtSXRN93
	 khnsfWDBXM5ARrPB3V9/iFLMQJTqsCWQxLqfhrRsDgRKSI5iXHpxCccfCLwlLrK8AmZ6S
	 rgMZal73DVVd+fD/BHXOWslpLvdq9wUtfJnPtQur5qN3FHI1X5+Xlx3LoERyp01q37qW6
	 7LlWFboBWDVcj3Y5AuhiyZ9Uw7FWu0UfCmEK/3im5gMJFe1iexvrR6HWFG+EaD+UlCl/c
	 5yyD2b77zJyzBg4ESX10K9KxWOxEqEhe13hwArRMFA4yVUxqLod+c+UiJlfBVH963cQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FX2IpsCt;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D746FF801F5
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 20:57:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D746FF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FX2IpsCt
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8ccef9eabccso66269316d6.1
        for <alsa-devel@alsa-project.org>;
 Tue, 09 Jun 2026 11:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781031448; x=1781636248;
 darn=alsa-project.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vckHDIVp33JUJr5L2rtWc/jepwGt4FiqEYrRaAimoV4=;
        b=FX2IpsCtaoG5du0vPXFvv3Atgq2hP2qdj1uVPXcXXdn+ISXVnxwa7y6Zl2iLOKcHFn
         8PbjXDjI545PUUTJ9/ZCgiyQjEJFTirvkubV12IjWUfJMW1L6IXrk3svp7J2l9iW25OX
         owdGDZuvGJPC2lRZM1T+9s+QI89wEECM+mZYeS8nnTjowUsqcuvMOpZ1OBSa4E/Nhlhf
         Oif/Fp7ITeXFGyLpP379HczJcBhbU04iQkPeHBJSBuY/Lqm7350WJWhlBS4oT5frRqw6
         S0mWD3c1dZ+Jf057tbj2USE0Ivk+DL8BaEbsGXht4xASjHY3n5NJPcApoZi/0roQh9b+
         Csvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031448; x=1781636248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vckHDIVp33JUJr5L2rtWc/jepwGt4FiqEYrRaAimoV4=;
        b=EEzLAp5nusv+oEqHYWWZbRR5h3MtRjcj78qpA7pOSvbN1hF61oteKsnho0CdNZqum2
         TSmPUCTQ4vZ5A3eWCsvWLi4MpYk6Hw9Oj/OBQyiPml2oqYhSlky8ojwbtYt9mK4zi/y2
         +PqbqZucwqGsByjv6+utfD4JgyelxTzQdFR2TGPJHTV53bYeNixlge6BhF9wzlZ/QyzV
         rsH+xznYVmVqvs5SK9HeqXK2TphgeMjaUcNjTBq9ouVCA73+OdzYytX5sPuejBbgqsmW
         x1d0c7xKBULHIGEKgPX/Nf2cbJVWpiIU02UWZoIVOsac9OMKOeCC2iCdEG7dhJIwQDlw
         K4sA==
X-Gm-Message-State: AOJu0YwjBlbZK12yoACfbyVvM/IxPoyVk5UFOjiNgYZo6i46LfXiGGaj
	r2D54aC8Xq1c826nzYZcqN0w9dJyOGQkjFBrxnhJX8Uw9V84DoX8OHHJ
X-Gm-Gg: Acq92OEmBEKtSNc2kg/AuOdoYIxtsvx/flFSikZkJ3Q57GZO9L/H4vUjnqCRQY1dySf
	cDo1uxn7qCv4NWB5nZZyid1j86bmNldyBJJ4cMe7onRwpoRhRvKYmArFfexA9kyGz6P+9wDzuq2
	FM5rwmiuBbV2aeCkZvlDysf1kKBunKVrtfSey7T1ZjXsTrF6k+wJRm85bPfrGaTdEQIQfaleFBf
	nQrvSzXS6yZvgerg+G6oBMMBytenlEkuGOUq+xfPiKnBX1IftlsEe4j0MueBMgnrOqnVDuWjyxN
	HtuILk0Bj967sqWQ5K88MLGTkeuvC/eNMX+c5fGUQvfzL4NwuK1cVlkQiAIZ277933qJUgsRPOk
	JJux4jvkTfqrrrXYd0SsjBfTbF2ORY687DUqQdBhxAhXP3MJm1d/k6pw8/4vET94iOyyOPuFrna
	V9hOHakcuHv6teu4QQJa6K
X-Received: by 2002:a05:6214:4991:b0:8ac:a91c:c8d with SMTP id
 6a1803df08f44-8cee8c5a665mr261494276d6.14.1781031447915;
        Tue, 09 Jun 2026 11:57:27 -0700 (PDT)
Received: from geday ([2804:7f2:800b:dd29::dead:c001])
        by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccd9fa53sm210602756d6.8.2026.06.09.11.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:57:27 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:57:19 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: =?utf-8?B?RsO8cnN0?= Blumier <seal@furst.blue>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP 255 15.6 inch G9
 Notebook PC
Message-ID: <aihhuk1OrH-s8q9i@geday>
References: <20260507202754.16114-1-seal@furst.blue>
 <0dac82c6-da2a-4026-b528-51f64462a895@furst.blue>
 <49b6cb61-c543-4406-97b6-359f17df4ecf@furst.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49b6cb61-c543-4406-97b6-359f17df4ecf@furst.blue>
Message-ID-Hash: GCI4E2LSEWAJV5SS55TKBLUMPO6FFY6A
X-Message-ID-Hash: GCI4E2LSEWAJV5SS55TKBLUMPO6FFY6A
X-MailFrom: geraldogabriel@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GCI4E2LSEWAJV5SS55TKBLUMPO6FFY6A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Furst,

On Tue, Jun 09, 2026 at 08:40:04PM +0200, Fürst Blumier wrote:
> Hi,
> 
> I haven't heard back in a month about this so I wanted to ask if there 
> are any changes you'd like to see or if I have to submit the patch 
> differently, since this is the first time I'm contributing here.

Please provide a commit message sufficiently descriptive of your
changes. Patches should be Cc:ed for linux-sound mailing list, not
alsa-devel.

Last but not least, do not concatenate your first and last
name in the Signed-off-by. The patch itself looks OK.

Thanks,
Geraldo Nascimento

> 
> If you'd like me to resubmit the patch, I can do that as well. Thank you 
> for your work!
> 
> Best,
> 
> Fürst Blumier
