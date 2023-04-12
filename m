Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8DAC77B6E
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Apr 2023 16:48:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB4B41094;
	Wed, 12 Apr 2023 18:47:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB4B41094
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681318079;
	bh=hUyUk0HVEmauyGnxF8rmJvXXqxDZnnR+L7bxIlBZgzA=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cHReQgA4ScgZ20z5ToFd7EZO34ZJ7ZgEw18gQGk6fOEjjAKGLIbb3QN8xwp5R7PEc
	 Idtj8xpMjLytWEr9URRlgIFX5rbC8d6phTKznKpKfNUgvSL3yLh9wKVYukhiOp1OHg
	 Ng4MXLiXEjjY1lJg7f2V3QLMVg5c3GyfYp0vsQDU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B39A5F80529;
	Wed, 12 Apr 2023 18:46:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 986DBF80448; Wed, 12 Apr 2023 18:46:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 16186F8025E
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2023 18:46:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16186F8025E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IWCHHZdq
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D8B4163590;
	Wed, 12 Apr 2023 16:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DFEC4339C;
	Wed, 12 Apr 2023 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681317967;
	bh=hUyUk0HVEmauyGnxF8rmJvXXqxDZnnR+L7bxIlBZgzA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IWCHHZdqVbKsnt4g/P6d1WohBEW0XsZkZzwD6aN3vbjzbeSYVyfVRjwNqL0qYt64w
	 sXwE+SJDt4SUD/usBEDkUVBU+uesxwYQBRQrBuJ8Xh7BE/hb/EyhAqDlpRItlsGRxK
	 J/yFBdEqZfsfwi4muh16sMzAEGm54KObHWbW1T/dMO9V7SEqCg8z5/lS2Bli9CkkCE
	 06G6VGfoVduk//DuceYP8YIstvbghsdMxkoB9Olzm0nscr4b/yePmAaeyx/8o7cbi6
	 PJvtkyxBlu/aEKKtJGW5UtpQKUpPOT4+gnzo9Ol28bZZeEejOzJrPpqIw/W4fnlm6/
	 hHAC9Fc2SdeBQ==
From: Mark Brown <broonie@kernel.org>
To: devicetree@vger.kernel.org,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
In-Reply-To: <20230411165951.2335899-1-alexander.sverdlin@gmail.com>
References: <20230411165951.2335899-1-alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: sound: ep93xx: Add I2S description
Message-Id: <168131796432.93781.16086400644681374069.b4-ty@kernel.org>
Date: Wed, 12 Apr 2023 17:46:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Message-ID-Hash: MNQY7TCZG7SY7LEJXVCS5B7AS3K25SAM
X-Message-ID-Hash: MNQY7TCZG7SY7LEJXVCS5B7AS3K25SAM
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Hartley Sweeten <hsweeten@visionengravers.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MNQY7TCZG7SY7LEJXVCS5B7AS3K25SAM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 11 Apr 2023 18:59:50 +0200, Alexander Sverdlin wrote:
> Add device tree bindings for Cirrus Logic EP93xx internal SoCs' I2S
> controller.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: sound: ep93xx: Add I2S description
      commit: 13b1b95245a7c2dc959b06ed7f02f4832e401cd2
[2/2] ASoC: ep93xx: Add OF support
      commit: b599a4d7d905a8e8cf5c36ccae0b3dd97c956075

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

