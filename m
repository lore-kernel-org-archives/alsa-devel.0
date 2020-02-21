Return-Path: <SRS0=sxeJ=4J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11D1C35646
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:43:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307CB20656
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C2sLunzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307CB20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D7E516B0;
	Fri, 21 Feb 2020 15:43:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D7E516B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582296236;
	bh=EH07Sa74416rTFrpSSX370sMT98bhk2djbVpHjIuIZY=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C2sLunzXPH/8liVgUglJ6YsRwO1bVrXPgJ/p+VPJTtFl2sprhygMq0wWMl7oxZaj0
	 aHknCMovtFoXP6i2YtCyNZB3ZySggJCsstW5fC891cJOg7xK6oppdUhdJz2nQ26AYy
	 Yy6E+sHbTp/41IdBsNHBXzA3y9urQ1p2EFrk2b8w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0385CF80114;
	Fri, 21 Feb 2020 15:43:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 145C3F8025F; Fri, 21 Feb 2020 15:43:04 +0100 (CET)
Received: from smtprelay.hostedemail.com (smtprelay0183.hostedemail.com
 [216.40.44.183])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBCE4F80114
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2020 15:43:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBCE4F80114
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 815CD18224949;
 Fri, 21 Feb 2020 14:42:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: side25_19d6a506e5525
X-Filterd-Recvd-Size: 1548
Received: from XPS-9350.home (unknown [47.151.143.254])
 (Authenticated sender: joe@perches.com)
 by omf05.hostedemail.com (Postfix) with ESMTPA;
 Fri, 21 Feb 2020 14:42:57 +0000 (UTC)
Message-ID: <1247da797bc0a860e845989241385e124e589063.camel@perches.com>
Subject: Re: [PATCH] Intel: Skylake: Fix inconsistent IS_ERR and PTR_ERR
From: Joe Perches <joe@perches.com>
To: Xu Wang <vulab@iscas.ac.cn>, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org
Date: Fri, 21 Feb 2020 06:41:32 -0800
In-Reply-To: <20200221101112.3104-1-vulab@iscas.ac.cn>
References: <20200221101112.3104-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
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

On Fri, 2020-02-21 at 18:11 +0800, Xu Wang wrote:
> PTR_ERR should access the value just tested by IS_ERR.
> In skl_clk_dev_probe(),it is inconsistent.
[]
> diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
[]
> @@ -384,7 +384,7 @@ static int skl_clk_dev_probe(struct platform_device *pdev)
>  				&clks[i], clk_pdata, i);
>  
>  		if (IS_ERR(data->clk[data->avail_clk_cnt])) {
> -			ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
> +			ret = PTR_ERR(data->clk[data->avail_clk_cnt]);

NAK.

This is not inconsistent and you are removing the ++
which is a post increment.  Likely that is necessary.

You could write the access and the increment as two
separate statements if it confuses you.


