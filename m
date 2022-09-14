Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F28CECAAD3
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Sep 2022 16:08:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4343D18FD;
	Wed, 14 Sep 2022 18:07:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4343D18FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663171718;
	bh=82aUx04eHI09yahgbuVzgSXq0+/mav6hqEkPR67VhsQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Whb1tSaEta3vpve6541b/MhAt5HRAMw8CYp0zXzsKo5WZLFya/qoeFeLc3TpGwyfp
	 4y696Qo6yLvo9D+YUWnd+Ryvfy8XZYb/OnrFI0wvsTZzgBAkvfL0z8JRvucg6+NVB7
	 qYclgKDwJ32KsmyAKFuYhhFcCrlgndRK9a9dNENc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA358F800FE;
	Wed, 14 Sep 2022 18:07:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A13BF8016E; Wed, 14 Sep 2022 18:07:47 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58A08F8008E
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2022 18:07:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58A08F8008E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jCS++KJB"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B0DB1B815CB;
 Wed, 14 Sep 2022 16:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AEFC433D7;
 Wed, 14 Sep 2022 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663171648;
 bh=82aUx04eHI09yahgbuVzgSXq0+/mav6hqEkPR67VhsQ=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=jCS++KJB/CZ+B2i/zdT4JAg499bIRZ1AwzeKdtH5jQJ2vOUaDl3wb3VGW7vrfcn3d
 KaeQKsa5WQlZ7nfvkSPzZQbmKaE4twriBSSM31J6caQPUkPgcv6+oJr5sKJnPHx+zI
 5bV1C6qf8nBm2h3aZtL+3dpcM5ry4U2KxNDzl3FoAWUz1JCHl6Nms8p2ELwStDGCx7
 ntjKzFPNuobJJmH8blUVBg2S2GJtOsiO/x3rtDVlysWdHB6sb+Dtr7GNHtP9O9Ew9D
 ER/0Np4cEmNJ65xrY2VEKhd0izwKsrYtNUS3xZAsXmrwmy0SXUOFVKHlXoUkTSJ6St
 yPGYFCl2oZ8IQ==
From: Mark Brown <broonie@kernel.org>
To: wangkelin2023@163.com, perex@perex.cz, Liang He <windhl@126.com>,
 alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
In-Reply-To: <20220914134354.3995587-1-windhl@126.com>
References: <20220914134354.3995587-1-windhl@126.com>
Subject: Re: [PATCH] ASoC: eureka-tlv320: Hold reference returned from
 of_find_xxx API
Message-Id: <166317164529.1330978.15444876619664038221.b4-ty@kernel.org>
Date: Wed, 14 Sep 2022 17:07:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-7dade
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

On Wed, 14 Sep 2022 21:43:54 +0800, Liang He wrote:
> In eukrea_tlv320_probe(), we need to hold the reference returned
> from of_find_compatible_node() which has increased the refcount
> and then call of_node_put() with it when done.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: eureka-tlv320: Hold reference returned from of_find_xxx API
      commit: bfb735a3ceff0bab6473bac275da96f9b2a06dec

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
