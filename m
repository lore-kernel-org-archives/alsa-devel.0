Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0218C3ABDD
	for <alsa-devel@archiver.kernel.org>; Tue, 20 May 2025 09:21:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5820B601D7;
	Tue, 20 May 2025 11:20:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5820B601D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1747732857;
	bh=FWkVhd1e+rN1MkOzu4aHGcRnovRlUpyoL9e1RjZDZbg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BmKmWdCJN8Bhq1kmvlKs/diEVbzriYEFT9E2M/n66puxjg9N3Tculd9TPeWN5L/f7
	 cbqq8FgEhsnV5CASNNJYNvAjmZlHvGCjmlMXvxb/V58B5gaqjpFbZGlODV+1IUe75b
	 caYAMKPWTTnWauVJjF7KSNiwiHi2Sb/WlhbRh8iE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8917F8055B; Tue, 20 May 2025 11:20:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AEDEEF80588;
	Tue, 20 May 2025 11:20:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7FD85F80537; Tue, 20 May 2025 11:20:16 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 830D9F801F7
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2025 11:20:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 830D9F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=nU6XevwZ
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AFD206116E;
	Tue, 20 May 2025 09:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315A8C4CEE9;
	Tue, 20 May 2025 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747732811;
	bh=FWkVhd1e+rN1MkOzu4aHGcRnovRlUpyoL9e1RjZDZbg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nU6XevwZtsjz3fhIloVUfKKBKAnx50q0s1Xzds7pkLTR4lNxpp7v9gYrV3AAQjS8h
	 h9keywuf9JyEIc3htyb2xfuETfyLjv9Y4tz1Xe6qe+hWnxs3X4jgnybQ88Ibac3rD6
	 Ej0FJ9LgjCZ3cBvrAqJ+RgOFVaImgvVidt2DGfQ4rQ93ojrFG436osus3HWmz6B36D
	 huMztsBVbQ6SQ95p7fAvNzLDpjWeoGZR1mozP/a7HNhzKni56sZy8kGyARmzXVaOxD
	 vdOqvk+K8fD7sCNiB0nhR8HJRqNvgkdro0/V3F0dkT5f5xvRjYPs3+a8xhTNTLlpsl
	 +qy18x+gHKNzw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Brady Norander <bradynorander@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Aleksandr Mishin <amishin@t-argos.ru>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20250330130844.37870-2-bradynorander@gmail.com>
References: <20250330130844.37870-2-bradynorander@gmail.com>
Subject: Re: [PATCH v2] ASoC: amd: use new ACP dev names for DAI links
Message-Id: <174773280875.19497.14903647004144204228.b4-ty@kernel.org>
Date: Tue, 20 May 2025 10:20:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1
Message-ID-Hash: GRFP4D5HY4RFQ3FKNDZTBKMMVDMBD377
X-Message-ID-Hash: GRFP4D5HY4RFQ3FKNDZTBKMMVDMBD377
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GRFP4D5HY4RFQ3FKNDZTBKMMVDMBD377/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 30 Mar 2025 09:08:45 -0400, Brady Norander wrote:
> On AMD SoC platforms with an ACP2x gpu ip block (such as stoneyridge),
> the amdgpu driver will create several platform devices for the ACP ASoC
> driver to communicate with the ACP hardware block on the gpu. These
> platform devices include dma for audio and one or multiple i2s
> interfaces. The amdgpu driver has always created these platform devices
> with automatic ids. The ASoC machine drives hardcode the platform device
> name. This creates an issue where if the ACP platform devices are not
> the first to be created, the ids can be different to what the machine
> drivers expect, causing them to not find the ACP platform devices and
> failing to load. Switch to using static ids for these ACP platform
> devices so that the names never change.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: use new ACP dev names for DAI links
      commit: 51590571433e32cacce10b11051c6ff056bf0aa8

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

