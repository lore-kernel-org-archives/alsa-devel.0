Return-Path: <SRS0=jAxA=GI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0D4C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jan 2021 06:32:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75F922838
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jan 2021 06:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75F922838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D4DD1669;
	Tue,  5 Jan 2021 07:31:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D4DD1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609828315;
	bh=it6t+8n8vyDORX1wRCYhRSmF/edjbso4T9TfC+IVIdk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B5LvpyfGb6dCtJvYd/KyWzQEOE0EpJiB2hsi/t2BXZBJ34EemPaMMRsSlLmA23yHQ
	 02fpYkOZZtIhwpWhdGb92aNdnWXwU70XxUgFMvL1DaAPVtfYPfitskPXX8RY9mHiO8
	 0gmdpAHZs+WnW5TE0hzbkf6OcF5pWF8prqLzP3FA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CC22F801F5;
	Tue,  5 Jan 2021 07:31:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE9C0F80258; Tue,  5 Jan 2021 07:31:01 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F343DF8012B
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2021 07:30:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F343DF8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="VRFUKKcl"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff407920000>; Mon, 04 Jan 2021 22:30:42 -0800
Received: from [10.25.100.71] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan
 2021 06:30:35 +0000
Subject: Re: [PATCH 2/2] ALSA: hda/tegra: fix tegra-hda on tegra30 soc
To: Peter Geis <pgwipeout@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Peter De
 Schrijver" <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Mohan Kumar <mkumard@nvidia.com>
References: <20201225012025.507803-1-pgwipeout@gmail.com>
 <20201225012025.507803-3-pgwipeout@gmail.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <0c3665b2-bac6-546a-bdd4-0ab7a90adf7c@nvidia.com>
Date: Tue, 5 Jan 2021 12:00:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201225012025.507803-3-pgwipeout@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1609828242; bh=+TbvEK70pgMeNJJMJSEFAbEVqczYIlNcn1A6iMFsvnE=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=VRFUKKclHq/2JaUXtTHG2IvmplsF4cEUVv+dvwRSHRNg9oDsK0HASEjYbR6dysveJ
 hz5IEXn8h96NnUF4hw650hWsM4Npsn1Q4peEf6yOgPD5qf4KBoqdwEgr3HOkuJjq6y
 VCtU5PeVRothSPjDO0pAphq5l/bCRR9zQJN63G16mcpuvtnto5XS8ixo4mLJ+jwNpi
 TdOmEkn9RRteF8QEWVSIY+Zmc1Dc45G0uZGJZ1+fejUs+ll5D5OLqTmF1g2+wfsmA7
 H3nO6isudhca8rAGTYv6fJmmoLWKKideLZldwEPmvKcwps3+951MupvV78dc/hPtud
 Y2qtuKU+3NpnA==
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



On 12/25/2020 6:50 AM, Peter Geis wrote:
> External email: Use caution opening links or attachments
>
>
> Currently hda on tegra30 fails to open a stream with an input/output error.
> This is similar to the issue referenced in [1].
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
> [1] states "Due to a legacy HW design problem", implying the issue applies to all previous tegra-hda devices.
> The tegra-hda device was introduced in tegra30 but only utilized in tegra124 until now.
> For this reason it is unknown when this issue first manifested.
>
> Applying the fix in [1] universally resolves this issue on tegra30.
> Tested on the Ouya game console and the tf201 tablet.
>
> [1] 60019d8c650d ("ALSA: hda/tegra: workaround playback failure on Tegra194")

This issue was never seen on Tegra210/Tegra186 and hence at that time it 
was thought to be specific to Tegra194. I never tested this on Tegra30 
since I don't have this device. I will clarify this with HW folks if 
workaround is safer for all chips.

>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Ion Agorria <ion@agorria.com>
> ---
>   sound/pci/hda/hda_tegra.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
> index 70164d1428d4..f8d61e677a09 100644
> --- a/sound/pci/hda/hda_tegra.c
> +++ b/sound/pci/hda/hda_tegra.c
> @@ -388,8 +388,7 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
>           * in powers of 2, next available ratio is 16 which can be
>           * used as a limiting factor here.
>           */
> -       if (of_device_is_compatible(np, "nvidia,tegra194-hda"))
> -               chip->bus.core.sdo_limit = 16;
> +       chip->bus.core.sdo_limit = 16;

Future Tegra chips address this problem and hence cannot be enforced by 
default. May be we can have like below:

if (of_device_is_compatible(np, "nvidia,tegra30-hda"))
chip->bus.core.sdo_limit = 16;

>
>          /* codec detection */
>          if (!bus->codec_mask) {
> --
> 2.25.1
>

