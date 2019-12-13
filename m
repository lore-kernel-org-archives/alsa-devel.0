Return-Path: <SRS0=T7nt=2D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB5DC43603
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 23:31:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F7A2067C
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 23:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OtJiQM9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F7A2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBDE215E5;
	Sat, 14 Dec 2019 00:31:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBDE215E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576279914;
	bh=v6oSjOTHObS6MuqGUn5N8RE24X+mvQ8/RtI4JrhLy5E=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OtJiQM9Ev/qtdt1kzGpQUqrZwdjdlSFzEIwfgWPDcjhDYVJL3V9VSi4/Jm9jrJra1
	 x3pUFuZk0Y3mBWgSS9RMFb2X/gOrBH/eXdWtT45Xk9Rr3rDIsDhFOpncWR/YPUGs4U
	 6uZJtWawHnDTcpCs/ygBSAGTwyk9o05tisUw1DCk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 407E7F8019B;
	Sat, 14 Dec 2019 00:31:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBF79F801F4; Sat, 14 Dec 2019 00:31:02 +0100 (CET)
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7489DF8014F
 for <alsa-devel@alsa-project.org>; Sat, 14 Dec 2019 00:30:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7489DF8014F
Received: by mail-ot1-f66.google.com with SMTP id a15so1082163otf.1
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2019 15:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gtY2+T1ox0A8va554qxncCqvVnnEac9GVhKoxQz2brU=;
 b=FirV0svTS548CLPpUz3k3FHMsLh3bqSVgUMBiRIaUk6D5iW4mSRUc2cgUdcpr3niZG
 wxEishkrtK/JD0IXGDRHfzUw1/lOn6GSz7uOHx0e93mVHlWrLgR6C8FyWQyDfWsiG3bS
 1CnP+syNZpB7vEr49YNVs5xF1wAUesHKPABxCjF2GghyTWXK7G1qS3EDznTlwYzKqUt5
 RSqdgO/HqnmvtWiTpeCwQ6w7JbGDNtZVjYjcH6Rq7rOww8sgHsWyb3CdgNWdw+1jXU+J
 ZTbDpm2hayzuaFI0yQOc0Qp67EaXNBIgR3YBI4Kh2A11DgvlRuuh5xrwf1GsJ7akpem2
 DhYw==
X-Gm-Message-State: APjAAAUqSKiDh8ZVrDahtNmcNCCd/JeXttoywhcScp2hTSh5oL15UUQI
 awFgNaBnQOxPahclCY2xow==
X-Google-Smtp-Source: APXvYqw2C389pcvF1+lJ2N1jxwZzZt9i/M4bE79s8BprnibexkABp7GRtQp/76wBTLLcKD0z28qDVA==
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr18076404otq.281.1576279856058; 
 Fri, 13 Dec 2019 15:30:56 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id j43sm3920091ota.59.2019.12.13.15.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 15:30:55 -0800 (PST)
Date: Fri, 13 Dec 2019 17:30:54 -0600
From: Rob Herring <robh@kernel.org>
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Message-ID: <20191213233054.GA28177@bogus>
References: <20191202174831.13638-1-angus@akkea.ca>
 <20191202174831.13638-3-angus@akkea.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202174831.13638-3-angus@akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, alsa-devel@alsa-project.org,
 kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, "Angus Ainslie \(Purism\)" <angus@akkea.ca>,
 Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Enrico Weigelt <info@metux.net>, Allison Randal <allison@lohutok.net>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: gtm601: add the broadmobi
	interface
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

On Mon,  2 Dec 2019 10:48:31 -0700, "Angus Ainslie (Purism)" wrote:
> The Broadmobi BM818 uses a different sample rate and channels from the
> option modem.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  Documentation/devicetree/bindings/sound/gtm601.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
