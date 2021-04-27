Return-Path: <SRS0=XYKd=JY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3311EC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 12:53:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1056109E
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 12:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1056109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B33C16DF;
	Tue, 27 Apr 2021 14:52:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B33C16DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619527991;
	bh=xePMUxVP5Nq3m95RDxxAIAvRcimdqGzs2gf2aFwKhVY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZIKxXXpl5WRDBBceh8Sh6ZtW0MJMwLjT/HsPvJg0QDjXOR6r8hI0fbO4WcrOEy1vi
	 zXtVE5M8sMpbJMAE1AD6IbACI/6xB619jtGFx8xCvZd0Md2UrPaC1gmQYXqJAewid/
	 SfMRzKNq+2IDVKZ1QSUx7B8QEfBmP447Ynt4lm8s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A5DFF801D8;
	Tue, 27 Apr 2021 14:52:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 334A7F801EC; Tue, 27 Apr 2021 14:52:16 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B2A5F800C0
 for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2021 14:51:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B2A5F800C0
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: gtucker) with ESMTPSA id E09B91F425B2
Subject: Re: broonie-sound/for-next bisection:
 baseline.bootrr.asoc-simple-card-probed on kontron-sl28-var3-ads2
To: kernelci-results@groups.io, broonie@kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Heiko Thiery <heiko.thiery@gmail.com>, Michael Walle <michael@walle.cc>
References: <6080e82c.1c69fb81.cd60c.2a13@mx.google.com>
 <3ca62063-41b4-c25b-a7bc-8a8160e7b684@collabora.com>
 <877dkp5141.wl-kuninori.morimoto.gx@renesas.com>
 <20210426144242.GF4590@sirena.org.uk>
 <8735vc4r59.wl-kuninori.morimoto.gx@renesas.com>
 <20210427101926.GA4605@sirena.org.uk>
From: Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <ea2b6dae-3087-67d3-8473-410255a51e23@collabora.com>
Date: Tue, 27 Apr 2021 13:51:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427101926.GA4605@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Jon Hunter <jonathanh@nvidia.com>, alsa-devel@alsa-project.org,
 Stephan Gerhold <stephan@gerhold.net>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Thierry Reding <treding@nvidia.com>
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

+Heiko +Michael

On 27/04/2021 11:19, Mark Brown wrote:
> On Tue, Apr 27, 2021 at 07:28:34AM +0900, Kuninori Morimoto wrote:
> 
>>>> If so, all sai1 - sai6 are using "fsl,vf610-sai",
>>>> all saiX doesn't have .name. I think it should have different name.
>>>> In your case, at least, sai5 / sai6 needs to have
> 
>>> You could send a patch along with re-adding the three patches I dropped?
> 
>> Thanks, I can do it.
>> But I want to confirm above first.
>> Let's keep Guillaume's happiness :)
> 
> This board is in the Kontron lab - KernelCI is just reporting results
> from it, we'd need to connect with someone from Kontron for system
> specific questions.  Guillaume, I don't know what e-mail they wanted to
> be used here?


We can have KernelCI tests re-run with extra kernel patches in
any lab, but yes for discussing actual changes related to the
platform it's best to ask Kontron folks directly.

Heiko, Michael, is this something you can please help with?


Best wishes,
Guillaume


P.S. archive: https://groups.io/g/kernelci-results/topic/broonie_sound_for_next/82277947
