Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94585E82CA6
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Sep 2023 15:47:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 307BEA4C;
	Wed, 27 Sep 2023 17:46:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 307BEA4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695829669;
	bh=3FrmzdhTjw5LrzQOkp7joeY5gnZ08aQFmDto0Xk2RDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OcnOFgC3luL2+wlxhTEBjikzM6AzY9ylzV7QncoBAxXbf7CbrqI4I3Rckp0JTk2LM
	 oI2I84FOOrmU+1A2fvnctzdiim+VpSUD3aWzBFWWZb8VbfGcvIeSzlxJKAKtVxeNZ5
	 h7bMNC+5kPTDwEBGff5oPW8wIe/dcKfcxr/DcY60=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 755A1F80130; Wed, 27 Sep 2023 17:46:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 80BC4F8007C;
	Wed, 27 Sep 2023 17:46:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E98D5F8016A; Wed, 27 Sep 2023 17:46:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C28D5F8007C
	for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2023 17:46:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C28D5F8007C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=Jdg7Mxy7
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6C8B561908;
	Wed, 27 Sep 2023 15:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BF3C4339A;
	Wed, 27 Sep 2023 15:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1695829572;
	bh=3FrmzdhTjw5LrzQOkp7joeY5gnZ08aQFmDto0Xk2RDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jdg7Mxy7D4jA3i/D43lRGIJqPBosdIidu+hvsXP+OFbf9RJUra9kj9VAaMLtfVDvi
	 TuqLRrSNTNOxsuIqgQEGQ5UTKdkx+hQ1wfba6lvehEnem1vjSaVZWhwhxCct6RgvZT
	 Q+mAjxijzvfVYio8cGhCNgDjKCPl6uDErTNJjvxE=
Date: Wed, 27 Sep 2023 17:46:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 00/33] Introduce QC USB SND audio offloading support
Message-ID: <2023092752-hardcover-surviving-b9d1@gregkh>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
 <ZRREZl6XLzyY4K95@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRREZl6XLzyY4K95@finisterre.sirena.org.uk>
Message-ID-Hash: KKF3XJT6DJAOZ6HNQ4TMH36IRL7ISF2T
X-Message-ID-Hash: KKF3XJT6DJAOZ6HNQ4TMH36IRL7ISF2T
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KKF3XJT6DJAOZ6HNQ4TMH36IRL7ISF2T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Sep 27, 2023 at 05:04:06PM +0200, Mark Brown wrote:
> On Thu, Sep 21, 2023 at 02:48:10PM -0700, Wesley Cheng wrote:
> > Several Qualcomm based chipsets can support USB audio offloading to a
> > dedicated audio DSP, which can take over issuing transfers to the USB
> > host controller.  The intention is to reduce the load on the main
> > processors in the SoC, and allow them to be placed into lower power modes.
> 
> I had a few small comments in reply to some of the patches but overall
> the ASoC sides of this look fine to me.  I didn't really look at the USB
> side at all, I'm not sure I understand it enough to have any useful
> thoughts anyway.

Thanks for reviewing those portions, I'll look at the USB bits next week
when I get back from traveling.

greg k-h
