Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A0CC43461
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:05:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72EF224B1
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 17:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YbV7U1dJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjID6Ilf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72EF224B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1C3F850;
	Wed, 16 Sep 2020 19:04:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1C3F850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600275910;
	bh=oUrT5gwD52MsR1wVTFrUE/WFQvwScZ/Kn5UNNx4HIXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YbV7U1dJQISSHS1/y8b9GFC7pNe6vqflHw+G6lkTi3IOCTkXitdzxEKf7SmqVTdDB
	 kByfetUmSu9BnvqjKlbP7BB93C9sOjmMNziUqLX7vqpQ4strI9faVZ0pqZKA22sr+S
	 gVhfK/OmoV84eHHBP2HLRRSYDemKHH3AwJCbvyHY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64C05F800BB;
	Wed, 16 Sep 2020 19:04:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8FFD8F80150; Wed, 16 Sep 2020 19:04:18 +0200 (CEST)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7303BF800BB
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 19:04:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7303BF800BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="JjID6Ilf"
Received: by mail-lj1-x241.google.com with SMTP id k25so6530896ljg.9
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oUrT5gwD52MsR1wVTFrUE/WFQvwScZ/Kn5UNNx4HIXA=;
 b=JjID6IlfOKBWQ4lGtoBOpv1ttQeatHSDCajwiJ0azKXbH3YYrtGydW+Gxgc9Piel58
 YFhSrOBPjpmjpppbHq0U1XIL2d7aM4huBXm1h4WWTeRveWVq+kXGVPdqcbZUiqkY8pop
 Wd86Q/TDYKOncWV1Y5HGdXg4ibithp/E8iohuJpujgMxmv3d/X2gB4S8O8jMFW/FikAq
 FYHhoI1jGVqUqtPlRtThH8ISjo9nJmtJbc7R8zCOsqzCnsiOS6x38RzgGJY6PcCS1z4h
 LRNXYbtrV+wpzUFIBRj6Vj/XisBq07u82l92zuLu4ecwxS7qL7Y5yT/EKsYpV7mrhasE
 K9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oUrT5gwD52MsR1wVTFrUE/WFQvwScZ/Kn5UNNx4HIXA=;
 b=RoxNnYugN+EkOnFjnCE8rIMkANNL+XD+Qz4u9bpMiiCRQcWqnFPFxWpgpCaxxA1n7V
 5ApEmYtIX0RLguC3Y5N/OEq+9EE1iJwFQ/+A3RH+tf4XgLo4XKMHHuoRXPb06CwNcWob
 dZ4j9J7UuaTeb8HOcb+vRvHmd15e5r/KTnzbtHT1nk5W5WgtviA90W+HdJmr3rQC/ZDS
 KH/HLvqk29k8IwQghuh4PW0Owf7WXyHpGGgG+EBNE/rAzKLl0qvLwF2bQxY1MtZVyxG2
 GRB3gh4+t/QoKEsYljafWQlO4lEjevyOC09RBTaCRCDPApSYNpv9YEqZR4pYG9xVdAJp
 xRuA==
X-Gm-Message-State: AOAM532pa0KhCjWzJFjTcon91JFOjd6Dlpf3haFBjD98aVrvcWxnLd/2
 HBqKm2ud85NIT9zbtNlR4R5oybieBQjAKKNQG30=
X-Google-Smtp-Source: ABdhPJyHd0Ooh4IK/vHvj2P4gv3lfDfIBiO8RqhPNolmmBPPICV/UOwNTXFmvzSGmOtJPgxjXHBzXE9TuLHprQ7UyvE=
X-Received: by 2002:a2e:a550:: with SMTP id e16mr9601438ljn.125.1600275845628; 
 Wed, 16 Sep 2020 10:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
 <1600251387-1863-2-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1600251387-1863-2-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Sep 2020 14:03:54 -0300
Message-ID: <CAOMZO5CZtdxbZdnXrckgYE7bzW-PDo2XOfQobuTf91C1hp462g@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: fsl_sai: Add new added registers and new bit
 definition
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Shengjiu,

On Wed, Sep 16, 2020 at 7:23 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> On i.MX850/i.MX815/i.MX845 platform, the sai IP is upgraded.

Please avoid such internal SoC namings and use i.MX8MQ/i.MX8MN/iMX8MM instead.
