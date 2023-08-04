Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C991FC001DE
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Aug 2023 18:02:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7D77827;
	Fri,  4 Aug 2023 20:01:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7D77827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691172164;
	bh=1hJX0Qsn3PckAB/1P1OTSGpu76JT60kf6EKnI/WcEuc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pD7YPW0sfKJBq0QDMtvwYyJo4kMmkxa2Rywb27xESKIFNd1wV71gfWP0jj95EGNiw
	 e0WNoQkTU0vQq0yi5X/+HHiCNMQivMN6k3W4tu3XF9WO9g2z2ww/quOb45h5qTgsgv
	 kfRLJ81jfaCJlJExC5/Ao8NPiUIV1BJXpf2bqQM8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1015F80551; Fri,  4 Aug 2023 20:01:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DAE73F8025A;
	Fri,  4 Aug 2023 20:01:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3ACF7F8025A; Fri,  4 Aug 2023 20:01:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EC168F80087
	for <alsa-devel@alsa-project.org>; Fri,  4 Aug 2023 20:01:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC168F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VoNGsY5I
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4E3B36205A;
	Fri,  4 Aug 2023 18:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1682C433C8;
	Fri,  4 Aug 2023 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691172073;
	bh=1hJX0Qsn3PckAB/1P1OTSGpu76JT60kf6EKnI/WcEuc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VoNGsY5Ip1m0qInMW+/Ql++rDf8/vM5p7lYcoYTZO0lrBkR5RTqPikw8c85u9tdjV
	 ZskoiO3QRdK3juM9Ah4asw9ppG1/b4K7PImsolVzPyVCoye3cM0xpkxb+6eubDkoAB
	 QjXTF/E5UbM7ANl4WqjXrKye7Ol3QcLesDMn7O8HxQqqmh2WEU+9KGcYwWymeWzdfW
	 M9fZw6R5yHMmxQn50dNlt25QUKT1rY36CV/bWCh+2QL7UEb0tlSjPcAVukGa57If1p
	 dymTwOWUnY+O6214Rj3cQ5+D0fhMB1jYOS2b00KDDmO0PoRRY9pMyWmymJTpaZ0qW9
	 jNG2J7CeSj03Q==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com
In-Reply-To: <20230804034734.3848227-1-yung-chuan.liao@linux.intel.com>
References: <20230804034734.3848227-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] ASoC: max98363: don't return on success reading
 revision ID
Message-Id: <169117207237.132360.10487571822966594387.b4-ty@kernel.org>
Date: Fri, 04 Aug 2023 19:01:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: 6NTQV2S4VI2IRDTHRRMBOFDSMDUOUMLE
X-Message-ID-Hash: 6NTQV2S4VI2IRDTHRRMBOFDSMDUOUMLE
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6NTQV2S4VI2IRDTHRRMBOFDSMDUOUMLE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 04 Aug 2023 11:47:34 +0800, Bard Liao wrote:
> max98363_io_init needs to keep going when we read revision ID
> successfully.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98363: don't return on success reading revision ID
      commit: 385311101538b071a487a9245e01349e3a68ed2c

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

