Return-Path: <SRS0=cpFx=IC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE91EC433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 01:02:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5A564EDF
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 01:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5A564EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD63F1AFF;
	Thu,  4 Mar 2021 02:01:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD63F1AFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614819751;
	bh=0vSvXdGmE87HAvoAagW8EnApB1MQYaYgX3xsBx/2nKs=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nPuCkhKY8FH3MVe9qggeBkKTS3OvjMqHoQpbPf25R/THUDdat+JO5fFYqRYh/dW2u
	 lfFhL6UzwWYlkSh/JmBMesD7MqyvyMp1anofuzBqC1sDmzwJp+g3iVstI5ZuUVlnkc
	 hKdhYIPzpcStpEAtTyUxqXpDTQGMTnU+09xYfazU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10AA8F80510;
	Thu,  4 Mar 2021 01:56:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48FB5F80516; Thu,  4 Mar 2021 01:56:41 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95594F80510
 for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2021 01:56:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95594F80510
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="g9HdPDtR"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87A0B64E76;
 Thu,  4 Mar 2021 00:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614819396;
 bh=0vSvXdGmE87HAvoAagW8EnApB1MQYaYgX3xsBx/2nKs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=g9HdPDtRwG7MUHPJIO7+CZWdU7gDbUbt7eIH4NiRc46be4EHnYSUEKdhk/qeHD9YV
 /VuyVpt4Xbf/r6NkydjrNj23OY+5Mh9MDNs5mF7YEzsULtQ2XaHkrpIqQmPjDppOfP
 j7z4vydtAXQniO0J46iVDQtFTPMaBozUa/SxuLDKZGF6mtK9x3QVhx/KeCeY/NdbW2
 Uv4pwwGrCvC+37VUJVTg2CNlv5t+5a+oOsCUBHWB1C0fMwm9ri416zayO98h7loGmY
 ONuL5C3K7ICu2GVU6E7rdsEALqjnlvRTOYufFEhSgyPwntRypBpILmJoncsVuIVSr6
 GNCC/CWlN7Jng==
From: Mark Brown <broonie@kernel.org>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
References: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
Subject: Re: (subset) [PATCH v2 0/7] Add I2S-MCC support for Microchip's
 SAMA7G5
Message-Id: <161481924068.9553.13493874640788116726.b4-ty@kernel.org>
Date: Thu, 04 Mar 2021 00:54:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alexandre.belloni@bootlin.com, lgirdwood@gmail.com, tiwai@suse.com,
 nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
 robh+dt@kernel.org
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

On Mon, 1 Mar 2021 19:08:58 +0200, Codrin Ciubotariu wrote:
> SAMA7G5 includes an updated version of I2S-MCC, found previously on
> SAM9X60. This controller includes 8 data pins, 4 for playback and 4 for
> capture. For I2S and LEFT_J formats, these pins can be used to
> send/receive up to 8 audio channels. For DSP_A, with TDM, any pins pair
> (DIN/DOUT) from these 4 can be selected to send/receive data. This
> version also includes 2 FIFOs (send and receive).
> This patch set starts by moving the driver's bindings to yaml and
> continues with adding a new compatible for the SAMA7G5 variant, followed
> by the changes needed for I2S/LEFT_J support, TDM pin pair selection and
> FIFO support, exclusively for SAMA7G5.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] dt-bindings: mchp,i2s-mcc: Add SAMA7G5 to binding
      commit: 4423a2724e3d1d55adfb1d515a9fa0759e95451e
[2/7] ASoC: mchp-i2s-mcc: Add compatible for SAMA7G5
      commit: 02d212ce7c72509139ceeee46f631fdf20e4c2fb
[3/7] ASoC: mchp-i2s-mcc: Add multi-channel support for I2S and LEFT_J formats
      commit: 89dcd5cc4bee9f87ef597374a8d7dc0c51436fb2
[4/7] dt-bindings: mchp, i2s-mcc: Add property to specify pin pair for TDM
      commit: d43f821b8a0162de9e9d392a8f1907c5638f558a
[5/7] ASoC: mchp-i2s-mcc: Add support to select TDM pins
      commit: 1d6257bbe6e9fcaf639f313ccd4cebe1f5e46865
[6/7] ASoC: mchp-i2s-mcc: Add FIFOs support
      commit: cb43e3692731401d4303c378f530c43bd283716e

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
