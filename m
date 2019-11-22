Return-Path: <SRS0=m6EI=ZO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D86C432C0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:44:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF02D20674
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="e6WlktAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF02D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 375241839;
	Fri, 22 Nov 2019 18:43:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 375241839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574444680;
	bh=Gi1oTOaTXIAxp8+BJqQlHcTIPkyYrp3oapEscBvU82E=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e6WlktAgoC0ZlTFuOJOxiJzMdQfS5xkuMah4qGVxermzEwbycdiXaC16VFyGeZEl7
	 86B0aKWfadtQPncfTh2dPbYOnsRmtbLJlKH+bZGgxy2HaGfEEIzXXoCoX9zmexImo1
	 pe7Swg0WgtOC4c43R5nZrXjl8Z1Y/zabIbqFeQI8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5549EF80228;
	Fri, 22 Nov 2019 18:39:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91F13F800EE; Fri, 22 Nov 2019 18:39:03 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EBD9F800EE
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2019 18:38:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EBD9F800EE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Nov 2019 09:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; d="scan'208";a="238683044"
Received: from sygreen1-mobl4.amr.corp.intel.com (HELO [10.252.195.68])
 ([10.252.195.68])
 by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2019 09:38:49 -0800
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87r2208o9g.wl-kuninori.morimoto.gx@renesas.com>
 <87h82w8o4k.wl-kuninori.morimoto.gx@renesas.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4381c599-bfdc-1dcf-d3cd-9a9eb90bb510@linux.intel.com>
Date: Fri, 22 Nov 2019 10:43:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <87h82w8o4k.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH 07/14] ASoC: soc-core: rename
 snd_soc_add_dai_link() to snd_soc_add_pcm_runtime()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 11/21/19 11:40 PM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Now soc-core and soc-topology is using snd_soc_add_dai_link().
> It sounds like dai_link function.
> But, it creates new pcm_runtime (= rtd), and connect it to card.
> The purpose is adding pcm_runtime, not dai_link.

this function seems to have 2 purposes, dai_link operations and 
pcm_runtime creation.

int snd_soc_add_dai_link(struct snd_soc_card *card,
			 struct snd_soc_dai_link *dai_link)
{
	/*
	 * Notify the machine driver for extra initialization
	 */
	if (card->add_dai_link)
		card->add_dai_link(card, dai_link);
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
