Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649DBC2BD09
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jun 2024 08:30:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9E1984C;
	Mon, 24 Jun 2024 10:30:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9E1984C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719217815;
	bh=GyOe0Bk1Qy0x3Zlayl0mhf95b8D33vUNBo/LqZn8X8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=r4O6ybv33tTf0rnc5iPxygfNyXjVok5+r5tKTbQVNafMeTcSW8DGKr9zKi+j2ydXO
	 UEAOqWowJamnEcuT2R5ShI759XQ1bUuIveCPmAIorH33RXkIsOBcPUwPKai7KP++Bm
	 wI4DWTvoy/wlmjdSIOiCb/PdmbwK+ZDdLOetxqVY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D5DFF805B4; Mon, 24 Jun 2024 10:29:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2741DF805B5;
	Mon, 24 Jun 2024 10:29:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 846E5F80495; Mon, 24 Jun 2024 10:25:53 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2AC90F800ED
	for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2024 10:25:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2AC90F800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=WARdO+Xq
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-681ad26f4a5so2364902a12.2
        for <alsa-devel@alsa-project.org>;
 Mon, 24 Jun 2024 01:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719217540; x=1719822340;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GyOe0Bk1Qy0x3Zlayl0mhf95b8D33vUNBo/LqZn8X8U=;
        b=WARdO+XqChCafzANcUfgDwoBIm6WOa2CyP5JwMsUUoOGEGMR+zAXnNHDyvQuswgbhI
         avN49yFJDhxusA0euLWJxkQ/wmp8OE32Qyi9m7lw7U7K7rMZMmyTu/PQfRcDsd5M0SqI
         dnF97g0fgu/jMy9CBOA9GdsSrHeIEtbvec/u8l/QYFhAkXFeRXGewBEwFyJgYaER1MPQ
         UAzSlnWrgY8HyZKODGqJ01IJ/k3L7eiq6qSYe4xn2bROzHuhuuXZkPKw4uAJfAtZbuu+
         q3uLnp1JyBLPYf5xWLXetvZqo5A83htMfSYuopUSvhyK2oa6I/j4SZgrG/LZLbFxDQJK
         5/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719217540; x=1719822340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyOe0Bk1Qy0x3Zlayl0mhf95b8D33vUNBo/LqZn8X8U=;
        b=QA9uX3I74PJ0Fv5dedjh5I5QMtDtbhkjjpQTUfwLLexhtzqikNuG8uXfItyOQF/+MT
         CG8xWj3A57mmpinOckYcb4GNNSCs2E57iNu1k6nVFZtXUaHxA2Toxahj+d2eLO6b/11V
         Z+K/5U8IZniePQXxfY5CBXVlEmZmDxJw/OvxY5RQ2BFGpWFJNnY6XMiYkIp8CsCeJ7KV
         u0gsfKpPhUsbClMIjkTkIMZeJhQzkY4G3FFiMGcFtTAGDJaITvldO9hY526PpQqW4CnC
         n7vUb0qdEYW3a9g+4+Vgoiyl0SZWGepeY8oeblj+gqgSyYdreGIx1tsxlLydADk4WZmR
         Nnbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDquHrvTF8cxnD2dAt5yiyQLpRth4xLYXg3RBsFrcpI5UOfqm0vUfBSJbzaqqDtEcWVJmhFn66yAhayFlRVB/GwI7COxetLHbKj50=
X-Gm-Message-State: AOJu0YzNpVI69sQBYEmCr12eKfTrUqgc6XNStmCFCV4ugQNW1RVlwDO6
	VRGk5qZVpu6OU1q6cRseoAGvppIcpLSCFKNJz0eHkn1SOufuT03xMt9Umu00+PBYpok6yWz6m/n
	YRztOR08eJFRCeIc1lLHzTNZA7d4=
X-Google-Smtp-Source: 
 AGHT+IH3LtoObSSGd0RS8q2XD+O5g3y4osc0/P7Bukg9/CjaM2KmYXfvOjyoBTJLOJuktChRLOrA3O/E8uVnomjgyns=
X-Received: by 2002:a17:90b:4c89:b0:2c5:249d:67be with SMTP id
 98e67ed59e1d1-2c86126b700mr2556400a91.22.1719217540209; Mon, 24 Jun 2024
 01:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240615125457.167844-1-rauty@altlinux.org>
 <2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
 <CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
In-Reply-To: 
 <CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
From: Rauty <rautyrauty@gmail.com>
Date: Mon, 24 Jun 2024 11:25:03 +0300
Message-ID: 
 <CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad
 330-17IKB 81DM
To: Gergo Koteles <soyer@irl.hu>, alsa-devel@alsa-project.org, tiwai@suse.com
Cc: perex@perex.cz, kailang@realtek.com, sbinding@opensource.cirrus.com,
	luke@ljones.dev, shenghao-ding@ti.com, simont@opensource.cirrus.com,
	foss@athaariq.my.id, rf@opensource.cirrus.com, wzhd@ustc.edu,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: K6SSCOT3D553H2CSTV7NSEK3MD53Q5NX
X-Message-ID-Hash: K6SSCOT3D553H2CSTV7NSEK3MD53Q5NX
X-MailFrom: rautyrauty@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K6SSCOT3D553H2CSTV7NSEK3MD53Q5NX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I haven't changed the patch yet, but it's already in the stable-queue:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.10/alsa-hda-realtek-enable-headset-mic-on-ideapad-330-1.patch
Do you still need changes from me?
