Return-Path: <SRS0=6VrY=KF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B00C433B4
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 12:28:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9186145F
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 12:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9186145F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD56516A2;
	Mon, 10 May 2021 14:27:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD56516A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620649700;
	bh=xWrbsbdV88A6FYiboCIsSoLilUAmIJD4Ej+mgY5nMK4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BhjwbyE+2d2x6I/ubj+tFPCwEupVvFbJwY147a9ZKVxdYngXxM/IIhHwelnJ4m23U
	 rRggg/LwidO0k8iJVYcR4O6wi++9iOH5iV+GeDZFoY4EQ4YR4LzP3gjrL9ltqvMQkl
	 H0yRm/9Bxqk9QnHquLE/L9qau7oAaYUdld/XIY7U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CE21F80240;
	Mon, 10 May 2021 14:27:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51682F80240; Mon, 10 May 2021 14:27:28 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C5E5F800B4
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 14:27:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C5E5F800B4
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: gtucker) with ESMTPSA id 5D9E91F40E82
Subject: Re: [PATCH 0/4] ASoC: simple-card / audio-graph re-cleanup
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>, Michael Walle <michael@walle.cc>
References: <87cztzcq56.wl-kuninori.morimoto.gx@renesas.com>
From: Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <6bd59423-6467-3103-a596-3a85204158a6@collabora.com>
Date: Mon, 10 May 2021 13:27:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <87cztzcq56.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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

On 10/05/2021 02:51, Kuninori Morimoto wrote:
> 
> Hi Mark, Guillaume
> 
> KernelCI had reported that my previous cleanup patches for simple-card / audio-graph
> broke kontron-sl28-var3-ads2 sound card probing.

Could you please add this trailer, or maybe the maintainers can
add it when applying the patches?

  Reported-by: "kernelci.org bot" <bot@kernelci.org>

Thanks,
Guillaume

> It reported that it is using same name for dailink->name.
> 
> At first I thought that the issue was fsl,vf610-sai doesn't have .name on driver.
> But real issue was that cpu->dai_name removed on simple_parse_node(),
> and dailink->name was based on it.
> We need to set/get dailink->name first, and call simple_parse_node().
> This patches are do it.
> audio-graph has same issue. [4/4] patch is for it.
> 
> I hope these patches has no issues on kontron-sl28-var3-ads2.
> 
> Link: https://lore.kernel.org/r/87h7k0i437.wl-kuninori.morimoto.gx@renesas.com
> Link: https://lore.kernel.org/r/20210423175318.13990-1-broonie@kernel.org
> Link: https://lore.kernel.org/r/3ca62063-41b4-c25b-a7bc-8a8160e7b684@collabora.com
> 
> Kuninori Morimoto (4):
>   ASoC: simple-card: add simple_parse_node()
>   ASoC: simple-card: add simple_link_init()
>   ASoC: audio-graph: tidyup graph_dai_link_of_dpcm()
>   ASoC: audio-graph: tidyup dai_name seting timing
> 
>  sound/soc/generic/audio-graph-card.c |  48 +++----
>  sound/soc/generic/simple-card.c      | 187 ++++++++++++++-------------
>  2 files changed, 122 insertions(+), 113 deletions(-)
> 

