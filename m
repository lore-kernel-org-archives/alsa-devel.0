Return-Path: <SRS0=OWbI=IH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E919EC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 19:11:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D476522D
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 19:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D476522D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BE861878;
	Tue,  9 Mar 2021 20:10:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BE861878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615317068;
	bh=LZvTkv/SxO6tIjypoyqW+hKOj/pXA793+m3se61bT78=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AYvTW6F/PeTofx/DI/sVtQq3gWT2fN8BiXvnrZVjYHYV7utVFa4DfHrhZSUe73N9R
	 pTj/VeF2kOAxY30F0TwaTzfGcCNMhPc1FIqB3J7Q10fk/HdcRPKL/6iwVINB8WyJVr
	 SmLEZcUcZ7QumuyccvHCy4UUJN1pafv8cfP9asu4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B008F804AB;
	Tue,  9 Mar 2021 20:08:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 528CAF804AC; Tue,  9 Mar 2021 20:08:14 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A319EF80482
 for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2021 20:08:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A319EF80482
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DBF/6vXQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DAF06523B;
 Tue,  9 Mar 2021 19:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615316889;
 bh=LZvTkv/SxO6tIjypoyqW+hKOj/pXA793+m3se61bT78=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=DBF/6vXQ29ht7dJmSDFQpToZ3s2KjnJwDxTvz+VCYDOv0T19+yxttQEJVBkwyHNJ6
 AlbJxHv6tLcRQ+iDQEiDr7h9Us8r4WEB3cI7SsxQoIwBORRGq+hVMPWJPwp+5Ihcp9
 ZuOtpuaMO17FcNnI9rD4W32i43AftxSx/C/xg62oOkW6dmf0EN+WYfCZBK7bXlZJ1Z
 AV9BcNnxvFI71kZMOAHPy+hy3jvCJvmRnHaFyC6wRrctvb3H8/jguEaJxn5NSolvxT
 detSqsU4w84EzsKtUSbbvSx/8y3VRArKIozVIXBsOzoJW9Se4kOywCNQcvIgBSxhcO
 r1HBHyzoWWycg==
From: Mark Brown <broonie@kernel.org>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org
In-Reply-To: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
References: <20210301170905.835091-1-codrin.ciubotariu@microchip.com>
Subject: Re: (subset) [PATCH v2 0/7] Add I2S-MCC support for Microchip's
 SAMA7G5
Message-Id: <161531678410.49117.15323877762928879476.b4-ty@kernel.org>
Date: Tue, 09 Mar 2021 19:06:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com,
 lgirdwood@gmail.com, tiwai@suse.com, ludovic.desroches@microchip.com,
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

[7/7] ASoC: convert Microchip I2SMCC binding to yaml
      commit: 2a29ad9ffc2a11827695b7b4fb32b486c604db3d

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
