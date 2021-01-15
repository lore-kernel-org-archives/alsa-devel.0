Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58972C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 18:42:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D15523A5E
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 18:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D15523A5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35E0D1775;
	Fri, 15 Jan 2021 19:41:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35E0D1775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610736151;
	bh=F4kLAf9R0ghx49EeJvRjtIFFPVO7b3uHP1ijB7EELjg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iVpqIe2BC7U2ADSQPOiikx6Nl2LGifaXfcwpZIOT9jf63RMBVKWS+JxwxkdXtjCFK
	 PRZVh/j5fXgMbi/0TXh41HoBOmLV4R+UIYHlyLg2oQWL0M9tekDLiygJHWoJLljEef
	 XODmfV8RHYVvS4vFVhZdj6rO33ItN6x/v/EzY/1w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62DBEF8016D;
	Fri, 15 Jan 2021 19:41:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6939CF801ED; Fri, 15 Jan 2021 19:41:38 +0100 (CET)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB13FF80134
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 19:41:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB13FF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="Mb4qmN7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610736092;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:From:
 Subject:Sender;
 bh=n5j/PCsBiI+eTqeB1Vv28jfg7d9qKU2MR3f363gYRJo=;
 b=Mb4qmN7jEKbOEPl9Pjc+uUJDW1d8oqtnBEQW/pEbvmwsUrWeShvqENpjqw3C0mXsfY
 90J99yf/PyL7T6TRLDnuAxwFqvmkLMn8hDCoVbCMRr7uRXj+CC8V6Z15Dc9ggA3Xnt8u
 C5f4nAyt2cOgu0i9ofRueky83VdCXpMmrrgw35sdr4Xx2uGlIUx1IB6KRcFEt5xjTP0X
 cqF/+9UDkAHTdeWWbZP40DS0FbdnxQHBC+wpdwXmWmdB5a6PFfocxS2fvOUqTDNQl4pr
 22rdO/PAy/8mdMLVZJ84b8QTNvdHJe/zbw944foQwAFLykOiebBGVjNSPTwDmcgyIm9w
 W0vg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j4IczHa4o="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
 with ESMTPSA id R0a218x0FIfVs6F
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 15 Jan 2021 19:41:31 +0100 (CET)
Date: Fri, 15 Jan 2021 19:41:25 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: qcom: lpass: Fix hardcoded SC7810 DAI IDs
Message-ID: <YAHh1d1Xs7c+MwJM@gerhold.net>
References: <20210114094615.58191-1-stephan@gerhold.net>
 <68691a9f-f65d-da1a-a413-b624567ccc5f@linaro.org>
 <YAHHtup8hgfdf1qm@gerhold.net>
 <9349c21b-7cd3-3c7b-91a9-9bbf0d5c4f15@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9349c21b-7cd3-3c7b-91a9-9bbf0d5c4f15@linaro.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
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

On Fri, Jan 15, 2021 at 05:15:53PM +0000, Srinivas Kandagatla wrote:
> On 15/01/2021 16:49, Stephan Gerhold wrote:
> > Right now it declares just a single DAI, but multiple "ports":
> > 
> > enum lpaif_i2s_ports {
> > 	IPQ806X_LPAIF_I2S_PORT_CODEC_SPK,
> > 	IPQ806X_LPAIF_I2S_PORT_CODEC_MIC,
> > 	IPQ806X_LPAIF_I2S_PORT_SEC_SPK,
> > 	IPQ806X_LPAIF_I2S_PORT_SEC_MIC,
> > 	IPQ806X_LPAIF_I2S_PORT_MI2S,
> > };
> > 
> > static struct snd_soc_dai_driver ipq806x_lpass_cpu_dai_driver = {
> > 	.id	= IPQ806X_LPAIF_I2S_PORT_MI2S,
> > 	/* ... */
> > };
> > 
> > I suppose we could just declare this as MI2S_PRIMARY but not sure if
> > that is accurate. Do you have more information about this platform?
> 
> Looking at the specs it does show that it has 0-4 total 5 I2S interfaces,
> however Am unable to find a  proper name similar to other MI2S.
> This one is the last one (4)!
> 

I'm still a bit unsure how this would fit into the shared lpass.h
dt-bindings, given that we need MI2S_PRIMARY, etc for MSM8916/SC7810
but some different ones for IPQ806X.

But I would also need to check how to implement .of_xlate_dai_name first
for example, so I think it's easier if you can prepare a patch to
implement your idea. I would be happy to test it. :)

Then we can just drop this patch set, I don't mind.

Thanks!
Stephan
