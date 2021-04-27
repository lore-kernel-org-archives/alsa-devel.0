Return-Path: <SRS0=XYKd=JY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF60C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 14:17:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC31613DD
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 14:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC31613DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 092BE16A3;
	Tue, 27 Apr 2021 16:16:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 092BE16A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619533042;
	bh=UT4NzLcNGinTAwJTIh8qF5o7iai2Z95aQ2kqbfsCMSo=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lScEdSwNskt05uy1MuJbjrCYIjRb2tHfEowL769dMl3P/dm7BKOdbHHo2S7zC4gcZ
	 Za2o3+dmeSgqll6HUTmhZjP21ETOVY87byV2zw07LGITF/uy1pIDUyTCDwFF1tAeKe
	 JLMI7YtDux/jasV5ZSDHdqUlmukVoEhGKDvOMxx0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 903F8F801D8;
	Tue, 27 Apr 2021 16:16:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1DBDF801EC; Tue, 27 Apr 2021 16:16:29 +0200 (CEST)
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 586DBF8012A
 for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2021 16:16:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 586DBF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc
 header.b="jGcp9sIg"
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id C8EE122235;
 Tue, 27 Apr 2021 16:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1619532971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sc5lE7XVA8uqcT97dhZBrRqd/hj5Vji9p6la8KLT4XA=;
 b=jGcp9sIg4CorqrT4liRVviHwsJMX70KeTl9FMdkXVTqI413ppWEE9qxri9ULuZGgd7e4zr
 7DDg7J8xwbdF+ZOWTv0guh5ryqRN0VrQJDGmkQS1TUIB0u+nWXkBKCjMbLVNb78mhRl7Rf
 5onsZDZSxPw4oap+SSXZ7RGBxKWcb+U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Apr 2021 16:16:10 +0200
From: Michael Walle <michael@walle.cc>
To: Mark Brown <broonie@kernel.org>
Subject: Re: broonie-sound/for-next bisection:
 baseline.bootrr.asoc-simple-card-probed on kontron-sl28-var3-ads2
In-Reply-To: <20210427135703.GH4605@sirena.org.uk>
References: <6080e82c.1c69fb81.cd60c.2a13@mx.google.com>
 <3ca62063-41b4-c25b-a7bc-8a8160e7b684@collabora.com>
 <877dkp5141.wl-kuninori.morimoto.gx@renesas.com>
 <20210426144242.GF4590@sirena.org.uk>
 <8735vc4r59.wl-kuninori.morimoto.gx@renesas.com>
 <20210427101926.GA4605@sirena.org.uk>
 <ea2b6dae-3087-67d3-8473-410255a51e23@collabora.com>
 <e20b9c8a2715b5d091a8d1f37ba890b4@walle.cc>
 <20210427135703.GH4605@sirena.org.uk>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <cc9a39f977c3765d1060ab1b0038bc79@walle.cc>
X-Sender: michael@walle.cc
Cc: Jon Hunter <jonathanh@nvidia.com>, alsa-devel@alsa-project.org,
 Stephan Gerhold <stephan@gerhold.net>, kernelci-results@groups.io,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Guillaume Tucker <guillaume.tucker@collabora.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Heiko Thiery <heiko.thiery@gmail.com>, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org
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

Am 2021-04-27 15:57, schrieb Mark Brown:
> On Tue, Apr 27, 2021 at 03:43:42PM +0200, Michael Walle wrote:
>> Am 2021-04-27 14:51, schrieb Guillaume Tucker:
>> > On 27/04/2021 11:19, Mark Brown wrote:
>> > > On Tue, Apr 27, 2021 at 07:28:34AM +0900, Kuninori Morimoto wrote:
> 
>> > > > > > If so, all sai1 - sai6 are using "fsl,vf610-sai",
>> > > > > > all saiX doesn't have .name. I think it should have different name.
>> > > > > > In your case, at least, sai5 / sai6 needs to have

Where does that (null) come from? I've briefly tried the following
patch and I'd assume I get a duplicate for "abc-wm8904-hifi", but I 
still
get the old (null)-wm8904-hifi.

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 407a45e48eee..36280008b5c6 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1081,6 +1081,7 @@ static int fsl_sai_probe(struct platform_device 
*pdev)
         sai->cpu_dai_drv.symmetric_rate = 1;
         sai->cpu_dai_drv.symmetric_channels = 1;
         sai->cpu_dai_drv.symmetric_sample_bits = 1;
+       sai->cpu_dai_drv.name = "abc";

         if (of_find_property(np, "fsl,sai-synchronous-rx", NULL) &&
             of_find_property(np, "fsl,sai-asynchronous", NULL)) {


> There was a question from Morimoto-san (quoted above) about the 
> hardware
> configuration so he could confirm what patches to write.

We are using two instances of the fsl,vf610-sai, yes. Was that the
question?

-michael
