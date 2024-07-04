Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE06C3271F
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jul 2024 17:41:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4E5FE8E;
	Thu,  4 Jul 2024 19:41:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4E5FE8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720114914;
	bh=AZVCVtzXgu3SguLD0qkz/t/YJ3VfflMJ9hh3F4VHkkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dXWW3YFxDgwbEmej0P1h5HSYwkVPYfNLcUKiFH9ZzFEpnxbgkES3rYcWSiknQ75BR
	 /crK/dmxy/gvr+UUyKRn1Z0HAIkjWk24khm2V5Xa7P4VhnsQ/SRXhcb1ARcMK3enGn
	 K3t5XTi7k7Zk760kcFD10q4pamYmvDXuaXFJJF3o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B538FF805BB; Thu,  4 Jul 2024 19:41:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 44CD9F805B5;
	Thu,  4 Jul 2024 19:41:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6511EF8025E; Thu,  4 Jul 2024 19:41:09 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5E747F800FA
	for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2024 19:40:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E747F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gj/sDUNT
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 33B61624DC;
	Thu,  4 Jul 2024 17:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A332C3277B;
	Thu,  4 Jul 2024 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720114855;
	bh=AZVCVtzXgu3SguLD0qkz/t/YJ3VfflMJ9hh3F4VHkkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gj/sDUNTsiqudX819V3D7fzCcQq6GFZeGHkdxwNN/+IYva3NtVxymYeIuMWGxpAgq
	 2uSkEK73vA+ysoZxio3tMR9XhPeTVlLg3DBS04ejRssG/G04aiifIo9E+ur6Z7vt5t
	 Wh0IZJWe2dYQsSdoyzbpQ9LCV5LdFqoykQVtzGcglNge0XlCFVaQLLS6mufk7jHqj8
	 8JpzxpbS4gkwWreK3QVoxTS4WzG59MQf+b2Qwgme1j3KjNa5PdFyosPaZI1uLnoJ8u
	 RvvD/nZpZEjwXW6x1gnot7e9aiMs5AnnTCIPTOA1Cenety6pS0vWNQT1jVS9JXK6Ur
	 a2vwh/28SmaaA==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
 pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
 zhourui@huaqin.com, alsa-devel@alsa-project.org, i-salazar@ti.com,
 linux-kernel@vger.kernel.org, j-chadha@ti.com, liam.r.girdwood@intel.com,
 jaden-yue@ti.com, yung-chuan.liao@linux.intel.com, dipa@ti.com,
 yuhsuan@google.com, henry.lo@ti.com, tiwai@suse.de, baojun.xu@ti.com,
 soyer@irl.hu, Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com,
 cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com,
 savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com, jesse-ji@ti.com,
 darren.ye@mediatek.com
In-Reply-To: <20240704094939.1824-1-shenghao-ding@ti.com>
References: <20240704094939.1824-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoc: tas2781: Set "Speaker Force Firmware Load" as
 the common kcontrol for both tas27871 and tas2563
Message-Id: <172011485009.96119.17388266064091597967.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 18:40:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: FCRV7QCLWYKIL5Y3Q2FGE5JRLFO6H5VS
X-Message-ID-Hash: FCRV7QCLWYKIL5Y3Q2FGE5JRLFO6H5VS
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FCRV7QCLWYKIL5Y3Q2FGE5JRLFO6H5VS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 04 Jul 2024 17:49:37 +0800, Shenghao Ding wrote:
> Set "Speaker Force Firmware Load" as the common kcontrol
> for both tas27871 and tas2563 and move it into newly-created
> tasdevice_snd_controls, and keep the digital gain and analog
> gain in tas2781_snd_controls.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2781: Set "Speaker Force Firmware Load" as the common kcontrol for both tas27871 and tas2563
      commit: cabf0b0cff07bc8d6e80ab6a8f8a127a2708147b

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

