Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CD5C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 18:25:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A54761264
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 18:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A54761264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D32D918C5;
	Tue, 11 May 2021 20:24:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D32D918C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620757509;
	bh=Mx695h49SLLtOn19BvyMti+Z9vBaZK5HF2OS0gg/WJs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FvgAXJbo9VgV18FYzUKWvBNL/ur0PDvmeIyRLbUiXmPk7yXm36ZtESkatx5tciV3v
	 MQe1LcJWJEFRfG9hqOUx+3WpKsd8ZHSbPlhylV4nlJtgNr1lS12li7WtJzNIkA6oMG
	 8DGcU6J5B/+Tt8EyBh4v5JtbZ5w5+BmYB8Z8T/+k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A708F804AC;
	Tue, 11 May 2021 20:22:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51F62F80475; Tue, 11 May 2021 20:22:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B68A5F8028D
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 20:22:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B68A5F8028D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="i1j62lsl"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D00B76191C;
 Tue, 11 May 2021 18:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620757353;
 bh=Mx695h49SLLtOn19BvyMti+Z9vBaZK5HF2OS0gg/WJs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i1j62lslYRGBLru41CNBWiC9Y8POmB34Q3PEzbtVYfWno8D+yDsux1YJ3mzLwT5Kt
 ONVJBKm0rV+uWtP7mwNCOx8l3fDTgOcWMjsFCjuKDdjlNOQVh0YPAKqA4Zuyp7OAai
 LQseB/dURy1/s7kH1lfJGJmNmK0qEXoD8yhE5fBGAD7azwtTI9zL4gKE44p8gMi+/e
 53pLwqI3IsgPEdCxQG90DvSmllfjoVBTHbPmJWFIh9hvCaeHghVLOaxHnWeg0nlSUb
 2PZnUj1I0EX1pGV0slyfLblOu9bXaiF8IlRyoPcVtrqJZ/B8FZsbF6olF5mjhAVyI9
 2JhfQRt15vy/w==
From: Mark Brown <broonie@kernel.org>
To: Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: bytcr_rt5640: Add quirk for the Glavey
 TM800A550L tablet
Date: Tue, 11 May 2021 19:21:30 +0100
Message-Id: <162075713910.17925.3084792483632180764.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210508150146.28403-1-hdegoede@redhat.com>
References: <20210508150146.28403-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Bard Liao <bard.liao@intel.com>
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

On Sat, 8 May 2021 17:01:45 +0200, Hans de Goede wrote:
> Add a quirk for the Glavey TM800A550L tablet, this BYTCR tablet has no CHAN
> package in its ACPI tables and uses SSP0-AIF1 rather then SSP0-AIF2 which
> is the default for BYTCR devices.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: Intel: bytcr_rt5640: Add quirk for the Glavey TM800A550L tablet
      commit: 28c268d3acdd4cbcd2ac320b85609e77f84e74a7
[2/2] ASoC: Intel: bytcr_rt5640: Add quirk for the Lenovo Miix 3-830 tablet
      commit: f0353e1f53f92f7b3da91e6669f5d58ee222ebe8

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
