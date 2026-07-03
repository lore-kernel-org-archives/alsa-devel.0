Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7638FC43458
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:20:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF833601CF;
	Fri,  3 Jul 2026 21:19:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF833601CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783106400;
	bh=5bnoL34Fc+g4Q3ymM94IRJxC/h39tYJqWKB0c4xGYfY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eVg2CrNfXhg5ETuIPzfLErYqbllv5lBxGO8OVRlcDQo6TGdn6SzHQ4PivNVoEYafo
	 cl8ramkb0Ujq0dIje6YzAH5805wC016wwaQPGpTs853N8GnrGP/3sMkdOMO5Qjlc9n
	 pwI4liI+zHdI4nwGiGZAbbw0odZfvHDqghThkbqk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47BA9F805EF; Fri,  3 Jul 2026 21:19:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D7967F805F2;
	Fri,  3 Jul 2026 21:19:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 700F6F80579; Fri,  3 Jul 2026 21:19:18 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783106357;
	b=L/i8nIYzAntllzWOyZtKe8jsDLI1kfaDZNcrLHf8lC5lc3Vgfs5aJeh2VIV1dgcvEFYH
	 54Oba1Rf7Ddsf0xxVPVxfSnJEDs74EZyljorTGR232igb7fOncNIo8AdTXy0Q8w/Ez0og
	 9YKo+L5xZTgeWixE9lEqQME+5PBm3LAEBpSoQNBMGLhYex6+TEdxhEVoEjz0TsyhOq3Uj
	 986u8LSxk6rQ1vZ1B0/DTkawChk/qiA42Tpsyhd5HXTw3hDh8aiByRw/qzybsuMdjSUoS
	 G3geL2ZLc6+CCAHBEEPQcV+OGjrXykovnVkLm1CE6lHSBfzSbFlea+oCwpum8Y6+7Lw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783106357;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=5bnoL34Fc+g4Q3ymM94IRJxC/h39tYJqWKB0c4xGYfY=;
	b=hZxSDFMXaTNRH+edEpkWz/RTULG2UCQvIfQtNYo5X/X342eAaF2OgMrXVOl2+pgg5E24
	 HBa/hpMmq6U5DW5kVL1LgMMvySDDR0NPrNbXUBcFq9yYdH/f4+jbxFIqYLDf0I2c/4Cbe
	 GasNGLIVLkcXoccYgmGCd/wFAkQA9PuHul3Ank+OjJ28k2P5PtJiC3o6eeijHbxelm+YS
	 kP+3jlpn0flL6l/wH6cIN2nqq4/Pc4DnpGQXlnybOYeFqrovOD8sWklXreWyX+UayRMpL
	 vnADww59mEvg6XEWDNTj+OM5dYiKuXdt3IREEC4pgNKCqcAhZX4uUoUnWr4jiNXiPSQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="jq/Wr5hh";
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6A828F8045D;
	Fri,  3 Jul 2026 21:19:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A828F8045D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jq/Wr5hh
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D9950600AF;
	Fri,  3 Jul 2026 19:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032F41F000E9;
	Fri,  3 Jul 2026 19:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783106352;
	bh=RzJyimwNUF1dVrJv+JdJbcLPCQubYPOuUrKjB+T3LK0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jq/Wr5hhbiA3Zgsumy6vf8k7tBr3t62wth79bRvqldMuKedcnR6Ik7Aqna7hyGigT
	 vLmf7muKXhNDF8Kvz0EgFz897ssMb7iEiLPJbhYqml4GKbD14Bn6JXAVeDcm93plGI
	 Nm327Kl9WLIIcMZFJ3IAnk/1Ke7leqhnCcQ4m70uaIViupMse8ys3WwOzmUr5eo5vx
	 aPp3MRClD3q+tOo+318w+qoi2NlmudS8gUQJ6zNZtq/nwdmPGYSsWxmgLFhsIGR/33
	 orTzlq8NQ6oG1K2Ml9CQAi+dTu9Ku26OdFh1WE8TzBv4cJPSRxHS2k55P3xLBRXA9Z
	 g6Sk1q+UeqRpA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 perex@perex.cz, tiwai@suse.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 mario.limonciello@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
In-Reply-To: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 00/16] ASoC: SOF: amd: add support for ACP7.B/7.F
 platforms
Message-Id: <178309681808.182374.1529641210373313366.b4-ty@b4>
Date: Fri, 03 Jul 2026 17:40:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5bnoL34Fc+g4Q3ymM94IRJxC/h39tYJqWKB0c4xGYfY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqSAssZJdllMoR5fxZ5/TdvrSwiQzyGEBeEc9t0
 3du6WZttniJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakgLLAAKCRAk1otyXVSH
 0OuqB/9H72aDhwaI1Sf0jagwXDz9SsaKDUJdAmTslBgD7luIxNT5cigQSEl5zg66zjr3xUgELyF
 RmoeZs4P4GkDY7O9trzfLDRzbjuoTMm6LhIykSpnN1OXoF1myV/2Z1Px/LeSXXUgyF/StFjngeu
 O/bIw62m/HHyWf3bCwY8aX+7DuUvXGwOZH6vjBgK8H0y0QXsvsZwajBZcDfGxWEEsxZqJ27ZBRd
 JooE6AvakPpRjohBzr0aixB1mt4CTkm0AXrhwKQuJMvEHQc6nc1VlGHkwvmEVY97HF6Muv40I8M
 4Pxucjtpq2RvjHIVIRPHGt9ds4+FwIk+OhYlzDCV/3CwUuGD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: HJV367TAUNCKMG5ZVRI7EIJR77DO7XN7
X-Message-ID-Hash: HJV367TAUNCKMG5ZVRI7EIJR77DO7XN7
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HJV367TAUNCKMG5ZVRI7EIJR77DO7XN7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 01 Jul 2026 15:25:01 +0530, Vijendar Mukunda wrote:
> ASoC: SOF: amd: add support for ACP7.B/7.F platforms
> 
> This patch series adds Sound Open Firmware (SOF) enablement for AMD
> ACP7.B/ACP7.F platforms by introducing a dedicated ACP7x PCI driver/ops
> layer built on the existing ACP SOF infrastructure, plus required IPC3
> topology/token extensions for ACP7x I2S/TDM.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[01/16] ASoC: amd: acp: add ACPI machine table for ACP7.B/7.F SOF driver
        https://git.kernel.org/broonie/sound/c/ec2332472f58
[02/16] ASoC: SOF: amd: add base platform support for ACP7.B/7.F
        https://git.kernel.org/broonie/sound/c/0ec5afad9d31
[03/16] ASoC: SOF: amd: mask ACP7x PGFSM status poll
        https://git.kernel.org/broonie/sound/c/237efba38c4f
[04/16] ASoC: SOF: amd: refactor SW1 I2S error reason clear in acp_irq_handler
        https://git.kernel.org/broonie/sound/c/571464f543f6
[05/16] ASoC: SOF: amd: add ACP7x probe and remove
        https://git.kernel.org/broonie/sound/c/78d99c2c5eee
[06/16] ASoC: SOF: amd: add ACP7x IRQ handler for DSP IPC
        https://git.kernel.org/broonie/sound/c/a3674345f902
[07/16] ASoC: SOF: amd: extend signed firmware pre-run for ACP7x
        https://git.kernel.org/broonie/sound/c/cbdafd2acdee
[08/16] ASoC: SOF: amd: require full ACP header for ACP7 signed firmware
        https://git.kernel.org/broonie/sound/c/d6869ae07d21
[09/16] ASoC: SOF: amd: validate SizeFWSigned before signed FW length on ACP7x
        https://git.kernel.org/broonie/sound/c/c04de2d88c0b
[10/16] ASoC: SOF: amd: add post-firmware-run delay for ACP7x
        https://git.kernel.org/broonie/sound/c/7a81f54a0483
[11/16] ASoC: SOF: amd: extend configure_and_run_sha_dma for ACPI signed FW flag
        https://git.kernel.org/broonie/sound/c/d0c32fdc1907
[12/16] ASoC: SOF: amd: wire signed firmware load callback for ACP7x via ACPI
        https://git.kernel.org/broonie/sound/c/7af6ac41cd47
[13/16] ASoC: SOF: amd: load ACP7.B/7.F signed data firmware to SRAM
        https://git.kernel.org/broonie/sound/c/deb631c3f387
[14/16] ASoC: SOF: amd: add ACP I2S format field and topology token
        https://git.kernel.org/broonie/sound/c/08c5e98b7b5f
[15/16] ASoC: SOF: amd: add ACP7x I2S DAI type and topology support
        https://git.kernel.org/broonie/sound/c/3805b8e6f932
[16/16] ASoC: SOF: amd: add system and runtime PM ops for ACP7x
        https://git.kernel.org/broonie/sound/c/1c9646f3180e

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

