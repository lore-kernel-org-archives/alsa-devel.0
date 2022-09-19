Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CC6C6FA8B
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 23:14:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB4F0868;
	Tue, 20 Sep 2022 01:14:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB4F0868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663629297;
	bh=GshXFgeMW/2zt5t38VJzTxJHeH945F+ScDpdYH+BRDY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gja7vatMNWZBq/3dfH4MgCzSNJGUy69wctz3LG7Sq3S9njthLjGi7RPYaUv89Sl0J
	 Q2fHl7bCJ+x0iUzZbgC8nFsm20YOK4cUWtCe09YyYXo73NZYJmucxA6dd2KJoBHu2c
	 MwUR7CU+jr6iWRKbkp15b2DmMOSdTzPWlSpSh52A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 49D27F805C5;
	Tue, 20 Sep 2022 01:10:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 146DAF805BF; Tue, 20 Sep 2022 01:10:37 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D314F805BF
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 01:10:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D314F805BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aYkkgK9Y"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A4CACB821D2;
 Mon, 19 Sep 2022 23:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2335EC433B5;
 Mon, 19 Sep 2022 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663629032;
 bh=GshXFgeMW/2zt5t38VJzTxJHeH945F+ScDpdYH+BRDY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=aYkkgK9YppGFDAqQOqzMbBGG46VzhJjvmQR996a4+8ntMbfZvH9MA9RXnCd0jvA8W
 qIlSebBw8Mh2D0IjOeB+gwj6TGVWZltHoReBsnxmN06R+Q5VmY7sO2gazQ+OiCYFj9
 R1tOMkf0ONNeCqWy2qzKT6mQ9MnfTpU59IutsWdampAgyhENykQ12L/su2/MXzEQvl
 4OePM3w0XeLC/EbFCdQIij7j6/TwObhd2vtf/y3rpGJ/vi6b+FtX58NGYXt264qWF6
 7xjwg4YknJ4qjY0IZwAKabezsJ3K7FJfSnNQaT8/z8AJiT2BCAFbebVBdykhsctPjA
 wAD7Rf8eaIdQA==
From: Mark Brown <broonie@kernel.org>
To: Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Robert Rosengren <robert.rosengren@axis.com>
In-Reply-To: <20220912105407.3157868-1-robert.rosengren@axis.com>
References: <20220912105407.3157868-1-robert.rosengren@axis.com>
Subject: Re: [PATCH v2] ASoC: fsl_spdif: add ALSA event on dpll locked
Message-Id: <166362902985.3419825.2712061696428572817.b4-ty@kernel.org>
Date: Tue, 20 Sep 2022 00:10:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 alsa-devel@alsa-project.org, kernel@axis.com
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

On Mon, 12 Sep 2022 12:54:07 +0200, Robert Rosengren wrote:
> Add an ALSA event on the RX Sample Rate controller upon the dpll locked
> interrupt, making it possible for audio applications to monitor changes
> in the hardware.
> 
> 

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: add ALSA event on dpll locked
      commit: e31a4a9320f1ccf75a690fe7f759896f285bb62e

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
