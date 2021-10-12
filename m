Return-Path: <SRS0=z7f8=PA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7726AC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 11:53:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4535601FF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 11:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4535601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 290751664;
	Tue, 12 Oct 2021 13:52:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 290751664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634039583;
	bh=o6LEWxjfXfp30LbQaKNcCyE8qgJU6luVJ0mAH9tlT7s=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gR3/5yDIUv6XpV2hxNMXOsdXjzSVw5zYBafwOGmh59o8SIqmNgthJywSX6Olv5j/g
	 pDbqXwUkTcfM4CVJpgvmBSJrMwbPQAhB9NZjltP6hUhQeJ/I094tVUzmGQvAJ4li0o
	 HmdlE6pzD1Rr3S0T6gG8PXXu5vyFwgn9MPMrs0cc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A91D0F801F7;
	Tue, 12 Oct 2021 13:52:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1264CF80212; Tue, 12 Oct 2021 13:52:11 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78ED4F800CB
 for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2021 13:52:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78ED4F800CB
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="227074277"
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; d="scan'208";a="227074277"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2021 04:52:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; d="scan'208";a="625919818"
Received: from anicol1x-mobl.ger.corp.intel.com (HELO [10.249.40.213])
 ([10.249.40.213])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2021 04:52:00 -0700
Message-ID: <b4f96793-de6f-0b0e-346d-f6a53633575f@linux.intel.com>
Date: Tue, 12 Oct 2021 14:52:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] ASoC: rt1011: Fix 'I2S Reference' enum control caused
 error
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
 jack.yu@realtek.com, lgirdwood@gmail.com
References: <20211011144518.2518-1-peter.ujfalusi@linux.intel.com>
 <163403898174.2091644.13928014844510803055.b4-ty@kernel.org>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <163403898174.2091644.13928014844510803055.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 seppo.ingalsuo@linux.intel.com
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

Hi Mark,

On 12/10/2021 14:45, Mark Brown wrote:
> On Mon, 11 Oct 2021 17:45:18 +0300, Peter Ujfalusi wrote:
>> Access to 'I2S Reference' enum causes alsamixer to fail to load:
>> $ alsamixer
>> cannot load mixer controls: Invalid argument
>>
>> cml_rt1011_rt5682 cml_rt1011_rt5682: control 2:0:0:TL I2S Reference:0: access overflow
>>
>> The reason is that the original patch adding the code was using
>> ucontrol->value.integer.value[0]
>> instead the correct
>> ucontrol->value.enumerated.item[0]
>>
>> [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: rt1011: Fix 'I2S Reference' enum control caused error
>       commit: c3de683c4d1d68ff27f21606b921d92ffdea3352

I have noted that this patch is not enough to fix the i2s reference
support and a complete patch has been already sent:

https://lore.kernel.org/alsa-devel/20211012063113.3754-1-peter.ujfalusi@linux.intel.com/

What keyword should I use next time to 'block' a patch applied?
Fwiw, this was my note:
https://lore.kernel.org/alsa-devel/e18ce962-736c-ea17-5ac2-1330026cdc90@linux.intel.com/

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 

-- 
Péter
