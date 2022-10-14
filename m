Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1548CC433FE
	for <alsa-devel@archiver.kernel.org>; Sun, 16 Oct 2022 07:32:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A2BC865E;
	Sun, 16 Oct 2022 09:31:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A2BC865E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665905533;
	bh=5ohpNpHEIIgmjx+RPDTPc8fknjoZyXhSN6zUY07xDgU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LFT1SHusL2QpuQToFvhJbe9jNB47COL0cdxhf+PF9+19JJ7s3XwdedJwllJ/u6nnk
	 CEFEctj0BImVEhOPPUNVbIsAlzNbm5PYQ1nQWEAxE1HiK7w+lo2m/0eiJC41MPc43T
	 VFUdlXa/2wvDNToLnQNN212rSiKZ9L5VQ+2dzNjc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D88AF8057C;
	Sun, 16 Oct 2022 09:28:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E144AF80224; Fri, 14 Oct 2022 12:57:56 +0200 (CEST)
Received: from smtp-out-12.comm2000.it (smtp-out-12.comm2000.it [212.97.32.82])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A9D8F800F3
 for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2022 12:57:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A9D8F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=mailserver.it header.i=@mailserver.it
 header.b="QYh57PWl"
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch
 [31.10.206.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: francesco@dolcini.it)
 by smtp-out-12.comm2000.it (Postfix) with ESMTPSA id 62D85BA1B17;
 Fri, 14 Oct 2022 12:57:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
 s=mailsrv; t=1665745071;
 bh=5ohpNpHEIIgmjx+RPDTPc8fknjoZyXhSN6zUY07xDgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QYh57PWluCTyCOKlcNt6Tht9vUkxOXP+rmpJcieIUSr2yvgm/APPEjWfgFUhdlh0A
 oKQ6Bs/CutMgDOTUa8XX2mP5ZWQHBILvHb+6BRVnoZ2HFDi7Hfv3YcLvAjXW9h5S7M
 4PzgSfZaQQ/OPuTm4UR1sjzOaw4noeoAeILDoI+YySLiVeJ/k1Vg9mzOYXj+PcJP0D
 a2zXsAevV3CIz9SbfZF4Z4e2GjCTpQNmTPdQI225kuJzcIsHQvbkVFrraFJcXKEm8M
 cVqFzjh60bn5JwUeNjstEXgcZuoa29mSlFztKDyGGJHExHebGrDtJmteSCNNiub3lD
 vLgro8h2lVbyA==
Date: Fri, 14 Oct 2022 12:57:38 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Benjamin Marty <info@benjaminmarty.ch>
Subject: Re: [PATCH v2] ASoC: nau8822: add spk boost and spk btl options
Message-ID: <Y0lAoncWmUg/K7ET@francesco-nb.int.toradex.com>
References: <20221014085253.73733-1-info@benjaminmarty.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014085253.73733-1-info@benjaminmarty.ch>
X-Mailman-Approved-At: Sun, 16 Oct 2022 09:28:42 +0200
Cc: wtli@nuvoton.com, alsa-devel@alsa-project.org, broonie@kernel.org,
 kchsu0@nuvoton.com, lgirdwood@gmail.com
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

On Fri, Oct 14, 2022 at 10:52:54AM +0200, Benjamin Marty wrote:
> diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
> index 1aef281a9972..812b8254f9a0 100644
> --- a/sound/soc/codecs/nau8822.c
> +++ b/sound/soc/codecs/nau8822.c
> @@ -379,6 +379,12 @@ static const struct snd_kcontrol_new nau8822_snd_controls[] = {
>  		NAU8822_REG_DAC_CONTROL, 5, 1, 0),
>  	SOC_SINGLE("ADC 128x Oversampling Switch",
>  		NAU8822_REG_ADC_CONTROL, 5, 1, 0),
<snip>
> +	SOC_SINGLE("Speaker BTL Configuration",
> +		NAU8822_REG_RIGHT_SPEAKER_CONTROL, 4, 1, 0),

We proposed the exact same change and it was not considered fine [1],
this is considered a system property and should be configured from
something like a device tree.

I would appreciate if you could add me in cc on any follow-up patch on
that, thanks.

Francesco

[1] https://lore.kernel.org/all/20220207153229.1285574-1-francesco.dolcini@toradex.com/
