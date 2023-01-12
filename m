Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3EEC63797
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Jan 2023 18:24:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3BE7F98B1;
	Thu, 12 Jan 2023 19:23:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3BE7F98B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673547887;
	bh=3imop1nfFEnzeDa06BtYeQWlSuMolSQ7BMbFpqXcv+g=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Vy6Q4rmjfoBu48w2NFk6H0lQVeC5Dnrc4CfZvIgc6J+AKcl5pHKk19OjEhzdK0Eu7
	 1tIG5AXs8NYYdFPa7ESMxrQf2u6FjfB2wKd++ScIiuL92owf2KHPKspwKVY1tG0TmO
	 UCx3NpQlbr6gOfRL4ii+MvD73KNLPfIEAhaYOCOc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE85DF804BD;
	Thu, 12 Jan 2023 19:23:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6FB1F804CA; Thu, 12 Jan 2023 19:23:55 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18465F8013D
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2023 19:23:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18465F8013D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bTRUbuns
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 6BAE6CE1DF1;
 Thu, 12 Jan 2023 18:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33347C433D2;
 Thu, 12 Jan 2023 18:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673547825;
 bh=3imop1nfFEnzeDa06BtYeQWlSuMolSQ7BMbFpqXcv+g=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=bTRUbuns7Dj7Sr+RfeJbnOAnkV+eqjwJpDpA4wkpyIlHZBAcwdRpm/VjKDtWDFVfJ
 DaMzyaH+eeC0h0XLkDUPsea51EpuQqlCUCR9RlOC5+xWbZltiHlRbjeMnaY/vE5D78
 HLVGEYizweadjUhnKJ5BWTIobJ5NWItVA/3vq9glwzffYU3q7lSl4RDhZMnfXjJtXV
 5sqHKHVniZLtTCgghPQTb7EJrIW2VuEhxLKWfQ7ywD6SMat5KRsIwzQXIPxnsIhnZ9
 DBgDs7qp12dyWDmSMrxQR+PtwleZG3r52FkRiTunWrDesy4uE9qlJJxAOvUNDa4yFY
 MjIqDWpPA3Hzw==
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112112852.67714-1-andriy.shevchenko@linux.intel.com>
References: <20230112112852.67714-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/5] ASoC: Intel: Balance ACPI device refcount
Message-Id: <167354782291.2217680.16107261306458603255.b4-ty@kernel.org>
Date: Thu, 12 Jan 2023 18:23:42 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 12 Jan 2023 13:28:47 +0200, Andy Shevchenko wrote:
> While looking for the open coded put_device(&adev->dev) cases, where
> adev stands for ACPI device, I noticed that in a few ASoC Intel driver,
> among others, the refcount is not balanced properly in some cases.
> 
> This series fixes that issue and converts to use acpi_dev_put().
> 
> Changelog v2:
> - split Intel drivers out from others (Pierre)
> - sent with cover letter (Mark)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: Intel: bytcht_es8316: Drop reference count of ACPI device after use
      commit: 6b1c0bd6fdefbf3c3d75680c2708f5423ef72e46
[2/5] ASoC: Intel: bytcr_rt5651: Drop reference count of ACPI device after use
      commit: 721858823d7cdc8f2a897579b040e935989f6f02
[3/5] ASoC: Intel: bytcr_rt5640: Drop reference count of ACPI device after use
      commit: cbf87bcf46e399e9a5288430d940efbad3551c68
[4/5] ASoC: Intel: bytcr_wm5102: Drop reference count of ACPI device after use
      commit: c8aa49abdeda2ab587aadb083e670f6aa0236f93
[5/5] ASoC: Intel: sof_es8336: Drop reference count of ACPI device after use
      commit: 64e57b2195725c1ae2246a8a2ce224abb60620ac

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
