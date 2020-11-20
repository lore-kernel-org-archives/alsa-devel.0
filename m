Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94287C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 21:32:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26952237B
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 21:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XunqURqL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1RsfB+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26952237B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59C1A179A;
	Fri, 20 Nov 2020 22:31:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59C1A179A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605907925;
	bh=DNqlnOB4Ey8fGXAXwO9vIS874v3tbID5Y4FbmlzZtQI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XunqURqLD8Wk23MF0hM1VFJtmC+IxzfHDGNEzkyShnYikaGM1HV8hvax5/7ERqc+C
	 rL0c77qwQKCWxmqtQ+IqMERCeZipnPTAE5iOhng1J49gh9nretH1F6cGhOTsKH+kYx
	 ZIuaugpkJWw8h02YwlW3xmF7q1s0V/r0N5Wo6zeY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EBDBF804CB;
	Fri, 20 Nov 2020 22:29:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3773F804CC; Fri, 20 Nov 2020 22:29:43 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57138F804C2
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 22:29:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57138F804C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="W1RsfB+P"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 123832245D;
 Fri, 20 Nov 2020 21:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605907778;
 bh=DNqlnOB4Ey8fGXAXwO9vIS874v3tbID5Y4FbmlzZtQI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=W1RsfB+PeO0TH/+cFSJ+w6eG7wEvPHpPE03CCt+M8opmIZiEyy0VHF+N3m8xZj/gi
 qTIH0DfaxyfhBzk4FPCYv9Hz3Y/S/qAhB2k080kAX0XakAOe9fzelyMuha+TawUKX/
 eoUn+hYZocTaibUDTdK9pw1LuEKmkQQe/eIs2kvE=
Date: Fri, 20 Nov 2020 21:29:17 +0000
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
References: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/14] ASoC: Intel/SOF: extend run-time driver selection
 to ACPI devices
Message-Id: <160590773742.47461.7146163250784184342.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Hans de Goede <hdegoede@redhat.com>
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

On Thu, 12 Nov 2020 16:38:11 -0600, Pierre-Louis Bossart wrote:
> The module snd-intel-dspcfg, suggested by Jaroslav last year,
> currently provide the means to select a PCI driver at run-time, based
> on quirks, recommendations or user selection via a kernel
> parameter. This capability removed a lot of confusions in
> distributions and removed the need for recompilations to select legacy
> HDaudio, SST or SOF drivers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/14] ASoC: Intel: broadwell: add missing pm_ops
        commit: 7998c168a94de9c593ab07455924e827ad5f1bd7
[02/14] ASoC: Intel: bdw-rt5677: add missing pm_ops
        commit: cf7f4a5320cda6fc533ae96601b4ce767d1af0f8
[03/14] ALSA: hda: intel-dsp-config: add helper for ACPI DSP driver selection
        commit: b5682305297db24b456e55ba209574cb8f9318f9
[04/14] ASoC: soc-acpi: add helper to identify parent driver.
        commit: 644eebdbbf1154c995d6319c133d7d5b898c5ed2
[05/14] ASoC: Intel: boards: byt/cht: set card and driver name at run time
        commit: 41656c3dc2acfe2aef3d7c4e1cd2b92f49b6e3a7
[06/14] ASoC: Intel: byt/cht: set pm ops dynamically
        commit: 05ff312badb6079f18c0b05d89e21733a9dafe32
[07/14] ASoC: SOF: acpi: add dynamic selection of DSP driver
        commit: f7313f9fc28781ad0801d8b9c692222445e664ca
[08/14] ASoC: Intel: Atom: add dynamic selection of DSP driver
        commit: df5f5edaef4b653fa731dcf3753e71766f95c2cd
[09/14] ASoC: SOF: Intel: allow for coexistence between SOF and Atom/SST drivers
        commit: b405b4318c77db061fdf1c8c4b9329ea30e807ee
[10/14] ALSA: hda: intel-dsp-config: add Broadwell ACPI DSP driver selection
        commit: 803e591337e6f7953350e0f56284ebbabb600808
[11/14] ASoC: Intel: broadwell: set card and driver name dynamically
        commit: 8643e85aab878fe0d8031ae4622b40cfb78d4172
[12/14] ASoC: Intel: catpt: add dynamic selection of DSP driver
        commit: ec8a15d3a7c7d6e9acd2e0637d2020ac17fb7820
[13/14] ASoC: SOF: Intel: allow for coexistence between SOF and catpt drivers
        commit: d512ef22d77b0779e9b0e9a91a63b291357079f9
[14/14] ALSA: hda: intel-dsp-config: ignore dsp_driver parameter for PCI legacy devices
        commit: 0e5cc22162e55c19255f4e25dadf9fda76eac11c

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
