Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E030C43334
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jun 2022 20:27:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C346B16A4;
	Mon, 27 Jun 2022 22:26:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C346B16A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656361658;
	bh=0gkPYZkAytUKwYehss9sX2aUqJc+ekk8q6CPMwD/KRE=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JGCJE1KHFgmy1r55vQBJHEGT6R9YH/8jpjdjCI/WDwMcCiGWbEJD083MNHBE8kVTa
	 ybFtCLS6deJPmYPqsGXAXfVk9cvh/XKbywDmXsrTfI0x00Pl58rlraTQ5im3PuVdqu
	 +rk8QVqKm6f0T3GmU6ecHyOVwFITtKJ12SihW738=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CA4BF8012F;
	Mon, 27 Jun 2022 22:26:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63854F8028B; Mon, 27 Jun 2022 22:26:46 +0200 (CEST)
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa1.perex.cz (Postfix) with ESMTP id A2BFCF800E9
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2022 22:26:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2BFCF800E9
Received: from [192.168.178.106] (p57bc972b.dip0.t-ipconnect.de
 [87.188.151.43])
 by mail.bugwerft.de (Postfix) with ESMTPSA id 38719282FDC;
 Mon, 27 Jun 2022 20:26:42 +0000 (UTC)
Message-ID: <b59afe57-7608-f049-c075-1a95d65984c4@zonque.org>
Date: Mon, 27 Jun 2022 22:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: (subset) [PATCH 0/8] ASoC: max98396: Some assorted fixes and
 additions
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, ryan.lee.analog@gmail.com
References: <20220624104712.1934484-1-daniel@zonque.org>
 <165636115333.3997797.6298161546515778991.b4-ty@kernel.org>
From: Daniel Mack <daniel@zonque.org>
In-Reply-To: <165636115333.3997797.6298161546515778991.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
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

On 6/27/22 22:19, Mark Brown wrote:
> On Fri, 24 Jun 2022 12:47:04 +0200, Daniel Mack wrote:
>> This is a series of some patches that I collected while using the
>> max98396 driver is a TDM mode setup.
>>
>> They correct BSEL and PCM mode configs, add support for power supplies
>> and add some bits to the documentation.
>>
>> The code is tested in TDM-16 and TDM-8 mode with 32 channel width.
>>
>> [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Umm, I was about to send out a new version of this series tomorrow to
address the things you pointed out, and some more detected by the test bots.

Which patches got applied now? I only see "Fix register access for PCM
format settings" in for-next and for-5.19 currently?


Thanks,
Daniel



> Thanks!
> 
> [1/8] ASoC: dt-bindings: max98396: add voltage supplies
>       (no commit info)
> [2/8] ASoC: dt-bindings: max98396: Add #sound-dai-cells
>       (no commit info)
> [3/8] ASoC: dt-bindings: max98396: Document adi,bypass-slot-no
>       (no commit info)
> [4/8] ASoC: max98396: add voltage regulators
>       (no commit info)
> [5/8] ASoC: max98396: Improve some error prints
>       (no commit info)
> [6/8] ASoC: max98396: Fix register access for PCM format settings
>       commit: cf5c888539f353cb10e127d3a8754554cacd293a
> [7/8] ASoC: max98396: Implement DSP speaker monitor
>       (no commit info)
> 
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

