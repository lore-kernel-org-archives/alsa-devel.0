Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A049C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 17:50:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB62F63225
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 17:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB62F63225
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51A971888;
	Tue, 16 Nov 2021 18:50:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51A971888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637085053;
	bh=9S8Obok4VkO6PP9b543MeICB3R+R1lg4Lv5qK4BCG+c=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r65HFb9xDU7dfCYC47gdeAxMpc8s69jstl8f8lUBAUvBFkENJeoYuZs7EA6jM8JP7
	 llhWnrFBOW56AYWd925JPLVXYQDBTIKwvIgcmD3vyi9kJN4r8GViXouY8rKqY+Cnmn
	 zwO5zLHPCMJoUMxL2fzq/i1NgNNkVd9M3UzH3dH8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CC1DF804FA;
	Tue, 16 Nov 2021 18:48:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18339F804F1; Tue, 16 Nov 2021 18:48:28 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9FA3AF8026D
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 18:48:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9FA3AF8026D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="csT1QYII"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FED361465;
 Tue, 16 Nov 2021 17:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637084899;
 bh=9S8Obok4VkO6PP9b543MeICB3R+R1lg4Lv5qK4BCG+c=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=csT1QYII1A9SSj1BKK1YBn+/Lv+JfddMBRUjXtYLZPa44I3Vai3t2TED0eR+ld/1n
 mM4oNr9Z1vh2Yj03vrERWtlL62BDXSvctH34qHxFsoWZDCETmk1zWnpTEoLZDATKet
 O5wDsboqoqpGMZGOkWy3PHQFdQpxTwxSZUdZrWSHBOdSNoWlZe4KCHhgkg3rH/OcN2
 TXM6RTkIuWCW3kZZo/ZiITZmsfbL9yaI1WFQSfq8NI9cxH9yuqrLjsVqUKJaQgBFgk
 wtgL3qhYtPuFq2eOuintZhmyrBJL6Ph4YDd0VYA1bvCHy+8+gkUXvoWZe+I8q3+r0V
 oNZWI/cj8MZnw==
From: Mark Brown <broonie@kernel.org>
To: pierre-louis.bossart@linux.intel.com,
 Daniel Baluta <daniel.baluta@oss.nxp.com>, alsa-devel@alsa-project.org
In-Reply-To: <20211116124131.46414-1-daniel.baluta@oss.nxp.com>
References: <20211116124131.46414-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH] ASoC: SOF: i.MX: simplify Kconfig
Message-Id: <163708489732.808776.5580166615449013834.b4-ty@kernel.org>
Date: Tue, 16 Nov 2021 17:48:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: daniel.baluta@nxp.com, daniel.baluta@gmail.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 ranjani.sridharan@linux.intel.com, linux-imx@nxp.com, kernel@pengutronix.de,
 peter.ujfalusi@linux.intel.com
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

On Tue, 16 Nov 2021 14:41:31 +0200, Daniel Baluta wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Follow the Intel example and simplify the Kconfig
> a) start from the end-product for 'select' chains
> b) use 'depends on' to filter out configurations.
> c) use snd-sof-of as a common module without any 'select'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: i.MX: simplify Kconfig
      commit: 7548a391c53cab2af0954d252cc5a9a793fd4c0e

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
