Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD14C7619D
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:58:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF77D20725
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Pi6Uc+cR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF77D20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 170D1167D;
	Mon, 17 Feb 2020 08:57:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 170D1167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581926312;
	bh=kd/E47H2/j5X/UKQwogahyvnX9rYTjNz8XqiZtKTkYw=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pi6Uc+cRwPl0W5e6xBc+SQOjPFyYZjzW9B20R+GrMjJ29QUFlKNorasAPVerEQqR4
	 ebXmMpOy7bPsGne6Qv8lv9s1naDBYUrccDZXnsxYOL9n2pIeY6EHnM0P+p46mxXier
	 EheNHR04vGG/pkSSpSzNNHrJuQOP0oQ8FghWDPos=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3BB2F800C4;
	Mon, 17 Feb 2020 08:57:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8786EF80172; Mon, 17 Feb 2020 08:57:39 +0100 (CET)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80A78F800B6
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 08:57:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80A78F800B6
Received: by mail-ed1-f68.google.com with SMTP id t7so7944919edr.4
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 23:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RXwH2ZY89QD7QWNaSd/vgTmgRslu6k13i/RLcLVOpys=;
 b=iXy8hOiPwmYLQerUGBoysrxyUeBf0RIpqVTgc/C8wYXyNkxd38q97BFTfMJYTq0dC2
 gcEJbqT89vld7g/ffBByFjW14pzsgKNgkBp5BcXPpiYwUj0Rg/8y79xP8bncckpjGeRb
 QlhMNHlaMK9+VWlU7rAF8Udl1c2t6igrP8QG4xi8r1JJ41oZM/TX6d8L6HBnU8FP2d9I
 U+SfIe4gRnpvxJ7d/F24kePOqIJcVBmWIFyCGbxP90fyoKOudhiJ2rRvgehp2un1zPE3
 SqDVUd+Eg91f4iH+7OPiIM9ZFRWN8CGvzD65iuh/QOngPmyaWvwixSL8LvJDLr8COVUY
 +0mQ==
X-Gm-Message-State: APjAAAXmn5e7BW5I9duE0Zkz4laE/aRJIchn5yKFZU8+ie93dmYue6Sp
 FLaUh5U/q1VMPl6wC5SmkPOtkXfuLEo=
X-Google-Smtp-Source: APXvYqwhFDlhYI7068SEovI60gl3y+M58+P78S0jDu5PrJWl1VDfGg666vfGyIa1vO0MMOq3tqdidA==
X-Received: by 2002:aa7:da18:: with SMTP id r24mr12906098eds.111.1581926255511; 
 Sun, 16 Feb 2020 23:57:35 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com.
 [209.85.128.48])
 by smtp.gmail.com with ESMTPSA id x15sm450673edl.48.2020.02.16.23.57.34
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2020 23:57:35 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id a5so16068009wmb.0
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 23:57:34 -0800 (PST)
X-Received: by 2002:a05:600c:34d:: with SMTP id
 u13mr21328621wmd.77.1581926254712; 
 Sun, 16 Feb 2020 23:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-15-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-15-samuel@sholland.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 17 Feb 2020 15:57:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v67ZtOajmfvoFNfsqWJ4K3pjfW16uoWYnMUcpqi7fg5XAw@mail.gmail.com>
Message-ID: <CAGb2v67ZtOajmfvoFNfsqWJ4K3pjfW16uoWYnMUcpqi7fg5XAw@mail.gmail.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Mark Brown <broonie@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [RFC PATCH 14/34] ASoC: sun8i-codec: Fix
	AIF1_MXR_SRC field names
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

On Mon, Feb 17, 2020 at 2:43 PM Samuel Holland <samuel@sholland.org> wrote:
>
> Even though they are for the left channel mixer, they are documented as
> "MXR_SRC". This matches the naming scheme used for the main DAC.
>
> Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
