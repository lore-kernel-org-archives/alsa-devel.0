Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BD7C432BE
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 22:37:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F1461029
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 22:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4F1461029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC22E170E;
	Wed,  4 Aug 2021 00:36:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC22E170E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628030232;
	bh=gIYIjPjQ0ojhmbqr95RFToHQcd4l1aybGPv9KyjhSuI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A+7wNwbO0JEwgsUL9hOuNsc8wzfS3dgXqLiLDYP4HrSREdZtZLWEX/EX8zDC8G/Si
	 MAa5oyn9ZSvvm0TOaPCuWcqQQ33Zd04pMfZHxVfnxFoK4AGt5dCyBZgnUHRLpSC+M/
	 WG4hn47QztTsNsdEipRFfL13XDmZyUFwcrwpDzSQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D2CBF802E8;
	Wed,  4 Aug 2021 00:36:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74DEDF802E8; Wed,  4 Aug 2021 00:36:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 192C6F80095
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 00:36:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 192C6F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="sB+w1Kai"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AA0F601FD;
 Tue,  3 Aug 2021 22:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628030174;
 bh=gIYIjPjQ0ojhmbqr95RFToHQcd4l1aybGPv9KyjhSuI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sB+w1Kaip8snuALRVdkK93XxTcGNKVJWAQACAXyyIP9IFtj4h+LWtvOLkjfaBsp8b
 mh+A4qDLqSwAqN/ZSC3GmDsQhCkKb1Moe1ZsJN+o7S+OVliZ2h+TYwhqQbALkQTxvf
 6mKBXxjA9Eq0sS0TmV5kHkO5Oy9sUSNyJZljbjEvjcCrQffaBQQnLpxnNHY9acoLC4
 i94wT5RUK6Qu+IERZyPLThwGuy3Az5ohXtWuo/ID3HXQFIYX22/yg9RRerUQOlYca9
 l4OlbrvJELl9ukHFM7BJICOu7TdodfLOR3PuVAO/rBtaxYiw+DOpX0hMR1ZZG6NvKW
 DyVfQqLRSEaeg==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/4] ASoC: SOF/Intel: machine driver updates
Date: Tue,  3 Aug 2021 23:35:36 +0100
Message-Id: <162802985540.42099.5913593680949715642.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802152151.15832-1-pierre-louis.bossart@linux.intel.com>
References: <20210802152151.15832-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Mark Brown <broonie@kernel.org>
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

On Mon, 2 Aug 2021 10:21:47 -0500, Pierre-Louis Bossart wrote:
> Two quirks added for Dell XPS 9710 and Intel reference boards, and two
> minor cleanups.
> 
> Pierre-Louis Bossart (3):
>   ASoC: Intel: sof_sdw: add quirk for Dell XPS 9710
>   ASoC: Intel: update sof_pcm512x quirks
>   ASoC: Intel: sof_sdw_max98373: remove useless inits
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: Intel: sof_sdw: add quirk for Dell XPS 9710
      commit: b8cab69b0ed9ee10f2a86670ce41ffad991c8dc9
[2/4] ASoC: SOF: Intel: Use DMI string to search for adl_mx98373_rt5682 variant
      commit: 46fa9a158327dd40238fa8e76af4bafdfcb8129e
[3/4] ASoC: Intel: update sof_pcm512x quirks
      commit: 22414cade8dfec25ab94df52b3a4f7aa8edb6120
[4/4] ASoC: Intel: sof_sdw_max98373: remove useless inits
      commit: d4321277b3b90474302a9b3b5ca124bcf0f29f00

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
