Return-Path: <SRS0=2Byq=DF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B803C2D0A8
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 05:34:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C93F21D7F
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 05:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M6NptwbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C93F21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7B5B1DF4;
	Mon, 28 Sep 2020 07:33:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7B5B1DF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601271256;
	bh=+x7QAn2uYVocNUkCVMeJdKDwZojnJ6iZ+Nm6GD4zjj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M6NptwbPTATldqhoDf1CaGV8j03GRDCQMo2vWDEkj/P7183axn6rV3r7py+eefP8m
	 vnmguFxNRQq94XUlsO2xm6xlgtQ72S4Y7bzpf7mRS03lQAZt/+ReYQDMIX1zZ2fg2D
	 HMHiGoFd90xzoK85gLygW+6jV8taaqOnbvKVK190=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEF21F802C4;
	Mon, 28 Sep 2020 07:32:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BF21F802D2; Mon, 28 Sep 2020 07:32:53 +0200 (CEST)
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E456DF800FD
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2020 07:32:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E456DF800FD
Received: by mail-lj1-f193.google.com with SMTP id k25so7222948ljg.9
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 22:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+x7QAn2uYVocNUkCVMeJdKDwZojnJ6iZ+Nm6GD4zjj8=;
 b=erLAootG1gxM5AWmhVcMbxMVKoq/Yxo385kFQAASCD0xnIjMRIoaxh0VBv0/WFcQWg
 XBd3H8evV9JdnN1OilkiJlKx5bdTKx2dYS0S6oO0zBrLPNdnaHc8u+mK0tBtrpFrWTmj
 oXtZtvUwysCz4IiDtwD3W7ZFKnVuKpB3m+5RLY001bVQs4NPodFhlitN25YJaf/7SBxE
 TXDejV160/MYpmU/d0++DFrrzsA52CHZFSbYehj+pNbvUwtox4RjDH2+SJkd07eZQsZH
 WTKK7g8aFuf3ToafR3eeZUBfibNxKwWSHcPOed7tZrBqTMytd6Zf/tq8wHdsAXrvBh/H
 DvqQ==
X-Gm-Message-State: AOAM531EV+ldg3DglKWHdl+Ki2/TJwTZilZHINZkYFTfuTy6vEYjFi9/
 pHmkPCge9NgAdBGexOkdfofbRsnsnhtVqQ==
X-Google-Smtp-Source: ABdhPJxYhl6jHEd3q0qsvWGzYwO6QdDC+9Spo5k4uJZTKI4qDskg/e8DJbwzQTq7ZhJOHoUnAl6hpA==
X-Received: by 2002:a2e:a288:: with SMTP id k8mr4571633lja.234.1601271161567; 
 Sun, 27 Sep 2020 22:32:41 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com.
 [209.85.208.170])
 by smtp.gmail.com with ESMTPSA id v18sm2728277lfa.238.2020.09.27.22.32.41
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2020 22:32:41 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id w3so7244328ljo.5
 for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2020 22:32:41 -0700 (PDT)
X-Received: by 2002:a2e:760e:: with SMTP id r14mr4070333ljc.331.1601271160985; 
 Sun, 27 Sep 2020 22:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200927192912.46323-1-peron.clem@gmail.com>
 <20200927192912.46323-11-peron.clem@gmail.com>
In-Reply-To: <20200927192912.46323-11-peron.clem@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 28 Sep 2020 13:32:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v67_9phiOxDTDmCLwSuFzADDXqLwW+d48OUNZ_1m2vPCMQ@mail.gmail.com>
Message-ID: <CAGb2v67_9phiOxDTDmCLwSuFzADDXqLwW+d48OUNZ_1m2vPCMQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 10/20] arm64: dts: allwinner: h6: Enable
 HDMI sound for Beelink GS1
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree <devicetree@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Mark Brown <broonie@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Mon, Sep 28, 2020 at 3:29 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
>
> Now that HDMI sound node is available in the SoC dtsi.
> Enable it for this board.
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
