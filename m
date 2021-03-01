Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7899FC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 23:45:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20AC601FE
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 23:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20AC601FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DB6616BE;
	Tue,  2 Mar 2021 00:44:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DB6616BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614642298;
	bh=+tX0CEM2dt1cnBnkzDBN7Y0MAPWYGlKqjmeXqsFyQzQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GslPxq6w9lPjOeNz1kWzuA6IZlxQJ75easxagLf4yCBuvqg7+MFfXE0T0EbY4SQfZ
	 ++h+zw9eftx/DXAGftLdjebgZmapd1mx3GFkZarwZ/k/fOS6A6VEhyzW6PVFwZvFO7
	 8Ccq21EuclloSbvbYGFfhFyRpNOI33n5IbPn62S0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FD72F80535;
	Tue,  2 Mar 2021 00:37:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B562F80536; Tue,  2 Mar 2021 00:37:40 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7C7DF80535
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 00:37:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7C7DF80535
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bmRsFBFc"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBA2661601;
 Mon,  1 Mar 2021 23:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614641856;
 bh=+tX0CEM2dt1cnBnkzDBN7Y0MAPWYGlKqjmeXqsFyQzQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=bmRsFBFcrH1Qy6jz5/j1NfUMFKJbJPYvnzPtoW0kPMgtLeA8VOWxRrnI4kJINPnEc
 vXNdUVI8xRLq6BNJ7oWo4j0wjvV9u6AD2itBi7BJcpExS2YwbPBG2Bb4y7jkJHz0ID
 i4n/6hHB2D7lyqojnbvzibmvKqof0Whlt51WpFkL9M3IaflpaXHWt5zeqG8GwP3S0z
 JW1Y9Pfw+vcMjm6+p+IlTM7fiMaqsjhHrWyB3s8uxVFCoRf61Y0cmXTZsVBbCyPx/h
 3klK+AWjfXyNWN32zkILYOsyPqfaNkflCbK44B/oebEFsLZbcgirPLz2jBWDYV2puX
 E4ZlZ2K/Q+e9g==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20210228160441.241110-1-hdegoede@redhat.com>
References: <20210228160441.241110-1-hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: es8316: Simplify adc_pga_gain_tlv table
Message-Id: <161464168097.31144.8953559363657689950.b4-ty@kernel.org>
Date: Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Sun, 28 Feb 2021 17:04:41 +0100, Hans de Goede wrote:
> Most steps in this table are steps of 3dB (300 centi-dB), so we can
> simplify the table.
> 
> This not only reduces the amount of space it takes inside the kernel,
> this also makes alsa-lib's mixer code actually accept the table, where
> as before this change alsa-lib saw the "ADC PGA Gain" control as a
> control without a dB scale.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: es8316: Simplify adc_pga_gain_tlv table
      commit: 4d4e677a68e770b84c87d1438d9f4e161658536a

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
