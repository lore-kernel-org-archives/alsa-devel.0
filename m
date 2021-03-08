Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3A5C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:10:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5092E65210
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5092E65210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82A3918D3;
	Mon,  8 Mar 2021 17:10:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82A3918D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615219854;
	bh=Mf3s++F+roSsKbeUSSBnZ0WX1am7caRBqSAvElmITo8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lnzeHSf3Q79xvyMB1YXUmbSOf898T/UqeCNmU3wMUj79i0YYQ8tCrqquno4pKpg5Y
	 Xfv6UglyXxfS2pVqmZBY0jyLuM577dRBR1xTrsizZBFdKsHu85kjZ0GvRUHWn5zuaa
	 cHieBwg3IFGgtxR+1CeYD3QDzjMgTGHkkdiEUsZA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE133F8042F;
	Mon,  8 Mar 2021 17:08:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C071EF8049C; Mon,  8 Mar 2021 17:08:25 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13E31F80475
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 17:08:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13E31F80475
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gURt287c"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC66F65224;
 Mon,  8 Mar 2021 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615219701;
 bh=Mf3s++F+roSsKbeUSSBnZ0WX1am7caRBqSAvElmITo8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=gURt287cb+ZBP41h26X+oEgKMYM78JtKeDH7AmFLrdoDtPZXx1M1UnqtDH+FzNPip
 VlhYuMQjwBWng7U6AHJp7SPULVkTgQPn+rnBwJiVAQaI1JZSek7o7SM5CwrE4XjKFA
 s40F99/GReFoD0ZqYXiXq39Ke++IVK7GSEB42k3QtAlV2ysOZ+4305+R+z02YaTlel
 3DF7Ork6eUfnsZuEgTAYvcZr4Z2RaH8mzl5NIEgzlerrGvBmvbzMMGOQ6V26FP7BMJ
 02+nCeMzxHTT4f6zEDYfjPVuPG/JGugAkJikSLMhTEufJiXZktsobGaNfsi0PwIrIz
 KaaE96iawt5xw==
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20210306230223.516566-1-hdegoede@redhat.com>
References: <20210306230223.516566-1-hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] ASoC: rt5645: Move rt5645_platform_data to
 sound/soc/codecs/rt5645.c
Message-Id: <161521960849.9621.11184287795041859626.b4-ty@kernel.org>
Date: Mon, 08 Mar 2021 16:06:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Bard Liao <bard.liao@intel.com>
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

On Sun, 7 Mar 2021 00:02:22 +0100, Hans de Goede wrote:
> sound/soc/codecs/rt5645.c is the only user of the rt5645_platform_data,
> move its definition to sound/soc/codecs/rt5645.c and remove the now
> empty include/sound/rt5645.h file.
> 
> Note since the DMI quirk mechanism uses pointers to the
> rt5645_platform_data struct we can NOT simply add its members to
> the rt5645_priv struct and completely remove the struct.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: rt5645: Move rt5645_platform_data to sound/soc/codecs/rt5645.c
      commit: b0c95242ebc233f8907366ae815ce1d8e7516907
[2/2] ASoC: rt5645: The ALC3270 variant does not have a headset-mic pin
      commit: 2eac35f48c075dcd939bc418fe786f4f221aee8e

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
