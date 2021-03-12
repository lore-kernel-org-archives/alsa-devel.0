Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB7C433E9
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 20:26:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA85C64F84
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 20:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA85C64F84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DE6D1878;
	Fri, 12 Mar 2021 21:25:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DE6D1878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615580762;
	bh=L5UCKkPePMWB188VqNKtdXugQ7SL7KSmHQlv2sa1uJk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HjY3tVJqJszb6pcrmYupqIhVC7fqI7hvw+g9T8JntOLT/nYxDB7umLCe4KwnQI2kQ
	 GvMyVlvrDQITsK+JITcerF80MTLG9e0KYlL9nDIpE5V+kjhagfuz9Z9Q2TZ14rDtw1
	 rK7/gNT/azaFUPo5PZ+D5wKw0kvhUAhrsBPcVnTc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C6A6F801D8;
	Fri, 12 Mar 2021 21:25:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F724F801D8; Fri, 12 Mar 2021 21:25:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B86EBF8012A
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 21:25:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B86EBF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tQknCmXG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A360E64F77;
 Fri, 12 Mar 2021 20:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615580703;
 bh=L5UCKkPePMWB188VqNKtdXugQ7SL7KSmHQlv2sa1uJk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=tQknCmXGwmrmpmtrf9SfgIuij2w1N0+5Gn6M74bC6hS9BYaOkiD9L9VARMUi96thV
 BesRg1FTAoilT0VYMuG3+n3DYczddMBZWmWFSnek7LQUf7VUUAZ9lSpvtYjj/tV33N
 oAT//7uxw6G3Vk/0okxQh++PrrI1hwD4YyA31HoPMaMNBZaCAICQesiuSMK9bEcGUi
 r66XA/Ta9xxWo+vhAJfMZOTKlaCUIQxN0fcekYytR6wEonDPkX4xiQmxE5TlKEkzQF
 50wQkenBbi7JRLxHKK7ymmrChOntRaKa7YXcO1ipi/yDXmnzhZM03SOww//NdANgOY
 wMYpmkdpux4JQ==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>
In-Reply-To: <20210312114850.13832-1-hdegoede@redhat.com>
References: <20210312114850.13832-1-hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Enable jack-detect support on
 Asus T100TAF
Message-Id: <161558062957.11113.14165487041258847634.b4-ty@kernel.org>
Date: Fri, 12 Mar 2021 20:23:49 +0000
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

On Fri, 12 Mar 2021 12:48:50 +0100, Hans de Goede wrote:
> The Asus T100TAF uses the same jack-detect settings as the T100TA,
> this has been confirmed on actual hardware.
> 
> Add these settings to the T100TAF quirks to enable jack-detect support
> on the T100TAF.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: bytcr_rt5640: Enable jack-detect support on Asus T100TAF
      commit: b7c7203a1f751348f35fc4bcb157572d303f7573

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
