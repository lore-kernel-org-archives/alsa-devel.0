Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F71CC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:37:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB4E20738
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z0BErf5V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GOiXPa9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB4E20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 631C682A;
	Tue,  7 Jul 2020 17:36:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 631C682A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594136230;
	bh=3h9aJUF43V2DbzSBqFx6vfKygSZMyLyOzfpaoHvkIu8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z0BErf5Vo9I+EN1DSrAKD8EFD7ySRwM2005eF6sz1jk+b5hN7hAHjKp3V3X1HZnmv
	 bcUKz0/cx+47oMGrZwDm8ry/Zd5jOxcQsLbDye8OMd8BTzJ+ziCT/1m5f/vVjo3rt1
	 KZ6b0sgL2egHMG7lD/3/nWuYCx5WOQhugCdAQKgI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99A12F8025A;
	Tue,  7 Jul 2020 17:36:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CDE2F80264; Tue,  7 Jul 2020 17:36:08 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E543F800D0
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 17:35:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E543F800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="GOiXPa9L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=qzBTvCbR+3OoqLjJh+mVqJ6CPDGK+xy5f5GtStO5FLY=; b=GOiXPa9L/WXfTTz6pZrK9bVvcX
 QqvRi9Wq9uU5OfHkGTF5gXQZ2jR/MvbXFqMZyo7U28bXpwRF0Auf1R6JCX744qWIFKIWNCHONaKpB
 MxRFZ5g1PIhl6BBMHClQdgpx3A0YH+J9ozM9X/g8lwmKIT+7g7yl1lsoEpegr1bzsov8AlH6dUZDb
 mw/YmIE2WjY1hS9vCHwa5KbuVThWhGvb+EHNSFJ1ud6undxa4hYDfbCY33ngqjbje4AbE5tnUKNsP
 y9s1Zc4jiImhlcnisWcqQych845UCGaEwEOsIZgl2KJEeL9IIYcBqxgHMpwwegBlspM8ktMQG6aUE
 oH48WPdw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jspdL-0005Sa-9K; Tue, 07 Jul 2020 15:35:47 +0000
Subject: Re: [PATCH] ASoC: amd: add ACPI dependency check
To: Mark Brown <broonie@kernel.org>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, alsa-devel@alsa-project.org
References: <1594118813-18689-1-git-send-email-Vijendar.Mukunda@amd.com>
 <159413142467.34737.8485886141400585716.b4-ty@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <755e1c02-21d5-db66-0b52-42ad65888647@infradead.org>
Date: Tue, 7 Jul 2020 08:35:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159413142467.34737.8485886141400585716.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, hui.wang@canonical.com,
 Alexander.Deucher@amd.com
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

On 7/7/20 7:17 AM, Mark Brown wrote:
> On Tue, 7 Jul 2020 16:16:41 +0530, Vijendar Mukunda wrote:
>> Add ACPI dependency for evaluating DMIC hardware
>> runtime.
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: amd: add ACPI dependency check
>       commit: 68d1abe186d1c865923d3b97414906f4697daf58
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


Vijendar, you should have Cc-ed me on the patch and you should have
added this line to the patch:

Reported-by: Randy Dunlap <rdunlap@infradead.org>

Also, now
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

although there are now 2 warnings:

../sound/soc/amd/renoir/rn-pci-acp3x.c: In function ‘snd_rn_acp_probe’:
../sound/soc/amd/renoir/rn-pci-acp3x.c:172:15: warning: unused variable ‘dmic_status’ [-Wunused-variable]
  acpi_integer dmic_status;
               ^~~~~~~~~~~
../sound/soc/amd/renoir/rn-pci-acp3x.c:171:14: warning: unused variable ‘handle’ [-Wunused-variable]
  acpi_handle handle;
              ^~~~~~



thanks.
-- 
~Randy
