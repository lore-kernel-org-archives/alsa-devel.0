Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719E9C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jul 2022 08:51:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80B8116BD;
	Tue, 19 Jul 2022 10:51:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80B8116BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658220717;
	bh=+KKcUverqM8Vz477kbN5kDnNNkbyk2nz9Lt1LZbrJXU=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a0N62izSzHUIkjkCsYbFj5bZq1L2pc/A/yx7ZcpCh8aM6Xvp2qa2XlS/i3Sg79OM9
	 ziaiGiyIUBHi5y1NyYdZSd1ZEj5omuTCSU/6Qj0PgfOdfT8K/BhcrzpdUIGoswSMMT
	 AKEjT2Fx+tH+N2qlx+UySXHQ20guNocIBL6PUT2M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DBCDF8016D;
	Tue, 19 Jul 2022 10:51:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33972F801EC; Tue, 19 Jul 2022 10:51:05 +0200 (CEST)
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB480F80125
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2022 10:50:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB480F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de
 header.b="lj/QvJBX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de; 
 s=default2002;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=XIfwQqwv6I4CbgnbmPDv+MqZItMy77JpgvCGazDhqr8=; b=lj/QvJBXQhqxz6ILWqFC2u60x6
 WY6IpmZA4hbZtvH/p33SgbcLssNOBR4TZ6GBvf5POjxSiLAPW81bKpBc0V3vg554NF3RITyjzuVXv
 7sE+OWZ5ObTRcMwPmt2ssrXefdcDN2Qw2hEjvwJXk8TiiPieoVNstUPO3hymTmZ1+rO0aDryQsdKk
 1f/utMOFtY17NBbFLaioLrDJD6+3veTToSV5HLMONJbuj/GgyGvFKGjwGC/s6OoFQiID6b8hWX/ut
 JyqThaUmFpFoREQRWl2WSY3QL2ZFklo3OvCKDSwKnFjfo+VU5xs91b3oUu99+qqulYMTI6Fn3pDHb
 R0g2Pl1A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <lars@metafoo.de>)
 id 1oDiwT-000AFZ-NB; Tue, 19 Jul 2022 10:50:57 +0200
Received: from [2001:a61:2a04:b01:9e5c:8eff:fe01:8578]
 by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <lars@metafoo.de>)
 id 1oDiwT-000GEn-IQ; Tue, 19 Jul 2022 10:50:57 +0200
Message-ID: <d7307c80-47e1-ef4b-42a9-dcbb8f555789@metafoo.de>
Date: Tue, 19 Jul 2022 10:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: ASoC: Is this bug ? DAPM source vs sink
Content-Language: en-US
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mark Brown <broonie@kernel.org>
References: <87o7xloca2.wl-kuninori.morimoto.gx@renesas.com>
From: Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <87o7xloca2.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26606/Tue Jul 19 09:57:30 2022)
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

On 7/19/22 08:19, Kuninori Morimoto wrote:
> Hi ASoC
> Cc Lars-Peter
>
> I have noticed that DAPM source vs sink are strange.
>
> ASoC had used source/sink or input/output before,
> but it was exchanged by this patch
>
> 	a3423b02cf745c1418f1f199646c450d6fc9ca4e
> 	("ASoC: dapm: Consolidate input and output path handling")
>
> I think source/sink pair are converted to SND_SOC_DAPM_DIR_IN/OUT
> by this patch.
>
> 	source <=> IN
> 	sink   <=> OUT
>
> But, its for_each are inverted
>
> 	#define snd_soc_dapm_widget_for_each_sink_path(w, p) \
> 		snd_soc_dapm_widget_for_each_path(w, SND_SOC_DAPM_DIR_IN, p)
>
> 	#define snd_soc_dapm_widget_for_each_source_path(w, p) \
> 		snd_soc_dapm_widget_for_each_path(w, SND_SOC_DAPM_DIR_OUT, p)
>
> I have thought this for_each is for special handling,
> but, the original was sink is for sink, source is for source after all.
>
> 	#define snd_soc_dapm_widget_for_each_sink_path(w, p) \
> 		list_for_each_entry(p, &w->sinks, list_source)
>
> 	#define snd_soc_dapm_widget_for_each_source_path(w, p) \
> 		list_for_each_entry(p, &w->sources, list_sink)
>
>
> So, I guess current for_each is wrong, but I'm not 100% sure
>
>
I don't think DAPM would work if this was wrong. If you look at that 
patch it consistently converted

`sources` to `edges[SND_SOC_DAPM_DIR_OUT]` and `sinks` to 
`edges[SND_SOC_DAPM_DIR_IN]`


