Return-Path: <SRS0=wrte=AK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96848C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:17:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A661255A5
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gJEryDfd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MGcNekim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A661255A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8092B839;
	Mon, 29 Jun 2020 19:17:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8092B839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593451076;
	bh=5oyJhYtkB0tdOxeqHS64mGMVAr6Xg+ctGC17qj+umFc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gJEryDfdDWLVdP93nl8QhvVkBrv2+X0Lkg9BVNCleO6SXZRWmR7ndjQ1bvcFHF1Bw
	 8dGv/cYiO89eLWZFV5sTeTWuXU8gh2zv1T8s2JAwQ3twH5lGF+9uSWMMyqvNGHV8iG
	 sdWnuCZr625igJLCVzWuLlFHfuEEkIWZLKjg5AkI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3664F800BA;
	Mon, 29 Jun 2020 19:17:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05F85F8020C; Mon, 29 Jun 2020 19:17:04 +0200 (CEST)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B02EF800BA
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2020 19:17:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B02EF800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="MGcNekim"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efa21d80001>; Mon, 29 Jun 2020 10:16:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 29 Jun 2020 10:16:57 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 29 Jun 2020 10:16:57 -0700
Received: from [10.25.103.164] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Jun
 2020 17:16:46 +0000
Subject: Re: [PATCH v4 12/23] ASoC: simple-card: Support DPCM DAI link with
 multiple Codecs
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
 <1593233625-14961-13-git-send-email-spujar@nvidia.com>
 <874kqu1x70.wl-kuninori.morimoto.gx@renesas.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <1e0cf6d1-bf4e-8808-5390-c8a3b7c7fe7e@nvidia.com>
Date: Mon, 29 Jun 2020 22:46:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <874kqu1x70.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593450968; bh=RaxazFJv01kl+GXduhdNNy3QB5MQDQAMcc2g7XVpJl4=;
 h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=MGcNekimPKBkOEsCk1rJkoseD42Y/vWWmtt6b9wi2eD9y3VoFNf9in23HXcZ21wb+
 +xSu+3Fcnh2ACalnQ0jNDpk4yfNjJ5YItdrjzPRc+VzZqWU+aeKkqBGzaGnun8Yf3U
 1vICpTU8MdTpr0qc6M11PgQcpJHfrzWeNRLam5xXNGQPYJDY4iGB3vz6qElZuhhYBG
 dcIx+VKnI9jE4y4iiTsMFQ1Z3HTp3bUpkPfWqmOgKZ6ew+oMNR4ELfB55KYb7xQ1gi
 REWFicJ1W6BW5uxZeJ6deYeIH7Og+0rnZlf3H3UEgA6OnefYLXCC1DMOoDg9sLsyG9
 VYGUn2BjH8TaQ==
Cc: jonathanh@nvidia.com, nicoleotsuka@gmail.com, alsa-devel@alsa-project.org,
 atalambedu@nvidia.com, swarren@nvidia.com, linux-kernel@vger.kernel.org,
 spujar@nvidia.com, nwartikar@nvidia.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, tiwai@suse.com, viswanathl@nvidia.com, sharadg@nvidia.com,
 broonie@kernel.org, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 digetx@gmail.com, rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
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



On 6/29/2020 6:54 AM, Kuninori Morimoto wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sameer
>
>> The simple-card driver supports multiple CPU and single Codec entries
>> for DPCM DAI links. In some cases it is required to have multiple
>> CPU/Codecs. Currently parsing logic for DPCM link loops over all
>> children of DAI link but assumes that there is a single Codec entry.
>> When DAI link has multiple Codecs it considers only the first Codec
>> entry and remaining Codecs are wrongly treated as CPU. This happens
>> because first Codec is used as reference for parsing all other child
>> nodes.
> (snip)
>> @@ -137,8 +136,13 @@ static int simple_dai_link_of_dpcm(struct asoc_simple_priv *priv,
>>         * Codec |return|Pass
>>         * np
>>         */
>> -     if (li->cpu == (np == codec))
>> -             return 0;
>> +     if (li->cpu) {
>> +             if (!strcmp(np->name, "codec"))
>> +                     return 0;
>> +     } else {
>> +             if (!strcmp(np->name, "cpu"))
>> +                     return 0;
>> +     }
> Checking node name is maybe nice idea,
> but please consider "prefix" here.

Sorry I missed that example where DAI is defined at sound level. I will 
update.
>
> Maybe base issue for multiple codec support
> is that simple_for_each_link() is caring first codec only ?

Yes that is true.
>
>          simple_for_each_link(...)
>          {
>                  ...
>                  do {
> =>                      /* get codec */
> =>                      codec = of_get_child_by_name(...);
>                          ...
>                  }
>          }
>
> Remove above and having simple_node_is_codec(np, xxx) function
> or something can help it ?

Ideally I wanted to remove above two lines and allow empty codec list. 
But some users may expect the parsing to fail if no 'Codec' is found in 
the DAI link, hence did not remove above. If it is fine to remove above 
two lines it would be simpler. The loop inside simple_for_each_link() 
would anyway loop for each child node of DAI link and 
simple_dai_link_of_dpcm() can parse each 'np'.
>
>
> Thank you for your help !!
>
> Best regards
> ---
> Kuninori Morimoto

