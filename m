Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FD0C7EE23
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Jun 2023 15:46:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C52A774C;
	Thu,  1 Jun 2023 17:46:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C52A774C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685634410;
	bh=YU6Gm1YiO17K+MphtoRoKgPhTOkXNovZgUttO4A1VO0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Cstxjcvzf56Ya/hU4tlHg8Z7/+62GhOjD5OCFxlRGx1QhKLotCfq1cBj7hoeq9YW7
	 PrpI0eGIMLN+IXeMskWIlHObR4lSCxgPPuYlMmL/9RiKPLrNnMXZaEWpWXOchQ0INh
	 yVgBZSppO48sKaZzbUh6iX5CeXb3W7C2UilS3YBY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 86726F80588; Thu,  1 Jun 2023 17:44:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E37DEF80579;
	Thu,  1 Jun 2023 17:44:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8160F8016B; Thu,  1 Jun 2023 17:44:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1BF5DF800ED
	for <alsa-devel@alsa-project.org>; Thu,  1 Jun 2023 17:44:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BF5DF800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=l5/S6Irj
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9AE646D8;
	Thu,  1 Jun 2023 15:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF6AC433A0;
	Thu,  1 Jun 2023 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685634274;
	bh=YU6Gm1YiO17K+MphtoRoKgPhTOkXNovZgUttO4A1VO0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=l5/S6IrjoKCHeei+z85Bz1sGf08FxYGZ+09+7u4phDtB9cfiAqGkTw+hD6QU+y7ku
	 QsqFn1qXZSPC7fZNxnU+GG861Xt6D/YZGi/vjeLsX36l4JASXP7rgVRzAIpE0gbfDl
	 x23dlEX7DyT3EB1bkLlyB8Z0dyffxnqqwWbATWbBBqb2wCydBKE2LfF6Zk6cnVJBul
	 UMQqxfxTYiLyBZOsQz0XFKEHnI5+9ARtmdapn2/7ePKdl51j35TUnFNLm3EHv7nvr/
	 DIRv5EO7+L8aJlmD5Jer2LIE2ndBNcctjsf1GHNqA/cmtjuT4HtLofNCiRiAOCjYem
	 cAMFzFzieJMwA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 ryans.lee@analog.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 =?utf-8?q?=E2=80=9CRyan?= <ryan.lee.analog@gmail.com>
Cc: jairaj.arava@intel.com
In-Reply-To: <20230601130600.25344-1-ryan.lee.analog@gmail.com>
References: <20230601130600.25344-1-ryan.lee.analog@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: max98363: Removed 32bit support
Message-Id: <168563427297.132600.17300649682311812802.b4-ty@kernel.org>
Date: Thu, 01 Jun 2023 16:44:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: 5WRQT3ZFVQZHCTW3EOP6JC4TGKH3L2NR
X-Message-ID-Hash: 5WRQT3ZFVQZHCTW3EOP6JC4TGKH3L2NR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5WRQT3ZFVQZHCTW3EOP6JC4TGKH3L2NR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 01 Jun 2023 06:05:59 -0700, “Ryan wrote:
> MAX98363 does not support 32bit depth audio.
> Removed 32bit from the supported format list.
> Instead, added 16bit and 24bit to the list.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: max98363: Removed 32bit support
      commit: 0e2ee345856454632dcd2f3ee2ba4bb3f8632f74
[2/2] ASoC: max98363: limit the number of channel to 1
      commit: 3a67ad17b47ed111bda692238b6a19420e6934c8

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

