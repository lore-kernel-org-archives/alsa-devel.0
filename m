Return-Path: <SRS0=W2oN=D2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041F4C433E7
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 04:32:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7BA22240
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 04:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="srtRW10u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rF7+S2/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7BA22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E86B1788;
	Mon, 19 Oct 2020 06:31:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E86B1788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603081936;
	bh=53ZDBjX76Wu6crbEcXkzj6kGA6iuzYR4kjBAROcngic=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=srtRW10uXXLO3HFNMpMnOVH7vS5xZFbOezQ/0YcL3CabDN7NfaLpDhV+O1uPRJxLY
	 XDio6vOAb5hTXfUr20AEjAUiT3IIFhxyhlFEzvNqXrORTs9wJ0WvExcgbRDAQqE3MU
	 oETUaBMtJqTnMA4asS5f+76KIZfySCrTy/Rqg1/0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CEB8EF801D5;
	Mon, 19 Oct 2020 06:31:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8357AF80247; Mon, 19 Oct 2020 06:31:23 +0200 (CEST)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB4F5F8010F
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 06:31:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB4F5F8010F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="rF7+S2/a"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8d16600000>; Sun, 18 Oct 2020 21:30:24 -0700
Received: from [10.25.98.225] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 04:30:58 +0000
Subject: Re: [PATCH v4 09/15] ASoC: dt-bindings: audio-graph: Convert bindings
 to json-schema
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <1602859382-19505-1-git-send-email-spujar@nvidia.com>
 <1602859382-19505-10-git-send-email-spujar@nvidia.com>
 <87o8kz9blh.wl-kuninori.morimoto.gx@renesas.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <2c9abfd5-f7eb-0b8d-f45f-9f56f37881b5@nvidia.com>
Date: Mon, 19 Oct 2020 10:00:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o8kz9blh.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603081824; bh=JlVHUDKLpcK1i8rBNnQBiUlJRXSUCLWhMPCqRDHsvmI=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=rF7+S2/aZqYZK1QazdBEO1FX30HJnmmW1idk6J3T9yuuBVdxr/O2FodsXSOZY0d8Q
 oDLeJosw9P2zcz7RL0J9S9imoz7FgiMPulBVhyvZGnBZpB99MJ1K3/vfGZ91m+JC27
 7qUIdZCU0CKNOuOYhKCBSxPx25QCpz5g9+B6x0b1urfVtOhzN0i9LuWP+Nevk0Llau
 BiHPIUCiltWH4p3WwOUP4KcawDHY4pZDusjMQCzHgE9TlN1b9Dwo5Lzw2YsR7xiqjV
 G8eKfgm9lOME0mIpy7u+TO9KAdhslZkGTz20qIV8fohNH2nc/TiHAMUNa0NkDmJPEC
 M1Zy97K3dr9WA==
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, atalambedu@nvidia.com,
 linux-kernel@vger.kernel.org, thierry.reding@gmail.com, rlokhande@nvidia.com,
 swarren@nvidia.com, tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
 jonathanh@nvidia.com, devicetree@vger.kernel.org, nicoleotsuka@gmail.com,
 robh+dt@kernel.org, linux-tegra@vger.kernel.org, mkumard@nvidia.com,
 viswanathl@nvidia.com, lgirdwood@gmail.com, nwartikar@nvidia.com,
 p.zabel@pengutronix.de, sharadg@nvidia.com, dramesh@nvidia.com
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

Hi Morimoto-san,

>> Convert device tree bindings of audio graph card to YAML format. Also
>> expose some common definitions which can be used by similar graph based
>> audio sound cards.
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
> I'm posting this patch to Rob & DT ML.
> Not yet accepted, though..

Thanks for letting me know. I guess below is your patch,
http://patchwork.ozlabs.org/project/devicetree-bindings/patch/877dtlvsxk.wl-kuninori.morimoto.gx@renesas.com/
Do you have plans to resend this or send next revision?

I can drop my patch once yours is merged and refer the same for Tegra 
audio graph card.

Thanks,
Sameer.


