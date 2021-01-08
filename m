Return-Path: <SRS0=g0zL=GL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06311C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 15:16:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D8C238EC
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jan 2021 15:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D8C238EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A92D1674;
	Fri,  8 Jan 2021 16:16:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A92D1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610119012;
	bh=1q5hLo23EQKXYIhpVQwFoETHWNnYcnPc6Y1PJ4guCX0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kn0RLkjQwtjy6Q4HVGtXC5WjFzSc1nWot+D+BC5dsBNs5mlKBX4DCm6DiftbWZq84
	 QIu6vOxbblED0z1usOf9O0WIRTaegazFYWWeeqUcvnfiAN55XbvRgS0P6iSW4L6An+
	 F7GUR5rpZKhWXe33736gOhf0jRm+csu/MxR0yhjQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 548EBF800E9;
	Fri,  8 Jan 2021 16:16:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B65DBF80166; Fri,  8 Jan 2021 16:15:59 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A49C5F800E9
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2021 16:15:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A49C5F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="NjFvgCvW"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff877250001>; Fri, 08 Jan 2021 07:15:49 -0800
Received: from [10.25.98.33] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 Jan
 2021 15:15:43 +0000
Subject: Re: [PATCH v2 2/2] ALSA: hda/tegra: fix tegra-hda on tegra30 soc
To: Peter Geis <pgwipeout@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Peter De
 Schrijver" <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Mohan Kumar <mkumard@nvidia.com>
References: <20210108135913.2421585-1-pgwipeout@gmail.com>
 <20210108135913.2421585-3-pgwipeout@gmail.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <87d7cb13-92af-28ee-2e64-29648aefdc64@nvidia.com>
Date: Fri, 8 Jan 2021 20:45:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210108135913.2421585-3-pgwipeout@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1610118949; bh=QvgaUD/pWxodzW1R5/ccezezD2UdcnNQ0QB4pDiJd9I=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=NjFvgCvWeuJPFhLVJfRCSiXoZR9aV1814DS6IFgco2+Zao6Xyr6Az6roi3ytTfKEQ
 g8M1stC00ZIUDqaGRzyCIPa3Ns5wAmcc6FlcTlTyQeM4HnxTxF4Qzr4QJCi830Bm8G
 IHMalQBYuXRYXDGlTaiWPTXv24G0ZrRF4XGRqmsN2T1CRCTmQ6pJ7hBYx7f3lZ+S/V
 UXtCZgZ1TZ2EZeuWXtC59v8VrYtU5ECnrlziYdBzNLeY94bdVOnT2bXGqkE1hc1PAk
 yqDNIY2Wp6J8i+QI13Gk2pNNHV9UD2m0QYfw05+br0pi/2gAwNwSoNq8dCzC1sLXlO
 elb51gemr6S9Q==
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 Ion Agorria <ion@agorria.com>, linux-clk@vger.kernel.org,
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



On 1/8/2021 7:29 PM, Peter Geis wrote:
> External email: Use caution opening links or attachments
>
>
> Currently hda on tegra30 fails to open a stream with an input/output error.
>
> For example:
> speaker-test -Dhw:0,3 -c 2
>
> speaker-test 1.2.2
>
> Playback device is hw:0,3
> Stream parameters are 48000Hz, S16_LE, 2 channels
> Using 16 octaves of pink noise
> Rate set to 48000Hz (requested 48000Hz)
> Buffer size range from 64 to 16384
> Period size range from 32 to 8192
> Using max buffer size 16384
> Periods = 4
> was set period_size = 4096
> was set buffer_size = 16384
>   0 - Front Left
> Write error: -5,Input/output error
> xrun_recovery failed: -5,Input/output error
> Transfer failed: Input/output error
>
> The tegra-hda device was introduced in tegra30 but only utilized in
> tegra124 until recent chips. Tegra210/186 work only due to a hardware
> change. For this reason it is unknown when this issue first manifested.
> Discussions with the hardware team show this applies to all current tegra
> chips. It has been resolved in the tegra234, which does not have hda
> support at this time.
>
> The explanation from the hardware team is this:
> Below is the striping formula referenced from HD audio spec.
>     { ((num_channels * bits_per_sample) / number of SDOs) >= 8 }
>
> The current issue is seen because Tegra HW has a problem with boundary
> condition (= 8) for striping. The reason why it is not seen on
> Tegra210/Tegra186 is because it uses max 2SDO lines. Max SDO lines is
> read from GCAP register.
>
> For the given stream (channels = 2, bps = 16);
> ratio = (channels * bps) / NSDO = 32 / NSDO;
>
> On Tegra30,      ratio = 32/4 = 8  (FAIL)
> On Tegra210/186, ratio = 32/2 = 16 (PASS)
> On Tegra194,     ratio = 32/4 = 8  (FAIL) ==> Earlier workaround was
> applied for it
>
> If Tegra210/186 is forced to use 4SDO, it fails there as well. So the
> behavior is consistent across all these chips.
>
> Applying the fix in [1] universally resolves this issue on tegra30-hda.
> Tested on the Ouya game console and the tf201 tablet.
>
> [1] commit 60019d8c650d ("ALSA: hda/tegra: workaround playback failure on
> Tegra194")
>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>   sound/pci/hda/hda_tegra.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Peter.

Reviewed-by: Sameer Pujar <spujar@nvidia.com>
