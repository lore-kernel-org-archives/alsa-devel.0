Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F36C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Jan 2022 23:50:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07AE2175B;
	Sat, 29 Jan 2022 00:49:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07AE2175B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643413824;
	bh=5uoeE9QX7/h/QHvmNYA3KQvjtSiQ30QgsdGB51e8dfA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H3O9PBQBnlmxs98tAsTloNm2SIYrj3lYAuJnuOfah2HeG3FtE2UDoUhrCydnS1p1o
	 j6+xVKPfu2PwWZPY/ba7g3jNm7QQWJZlQRyTlYbxoQGNtUGBUt7R7n/Gr0ud9+gvUS
	 /jnNWOtZprWvWIWmv4QyzlcMK5GsIQ/C29dm2+hY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEDBEF80536;
	Sat, 29 Jan 2022 00:47:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB40FF80534; Sat, 29 Jan 2022 00:47:13 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64F13F80527
 for <alsa-devel@alsa-project.org>; Sat, 29 Jan 2022 00:47:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64F13F80527
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IERKzBUC"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id A3E6DCE27E0;
 Fri, 28 Jan 2022 23:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEDFC340EB;
 Fri, 28 Jan 2022 23:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643413623;
 bh=5uoeE9QX7/h/QHvmNYA3KQvjtSiQ30QgsdGB51e8dfA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=IERKzBUCeJKd50KssHydZi0VdfrBSq50ZrhqBtQ4R2y1z0Pqvm85v97YHeYl/VTnV
 d+DVXzISZfSQXmsBAyii6bhUX6OqWr3ZADYw0XKPkKwHRA/ZWSv2LFfIdSQ58zYcCe
 I+iVNkJoHCu1LnXSWktKlUJcjvnb+pabB3QYEPVhpRUspk8OBoBZxBHQ5YERIulAOJ
 pUjdfivS1LiEdm+ZRRDlidIJnTX91v3LraVPpU1m7rXcYaYAx+l3kq0kkQVyO40sII
 LVmM3ahQhoWZ7cCJP9jZ2xUsL+el4uclIKU7j/vSycB2WKgTgALjIL3h2jSksbu8bh
 QZsIhatQCkkjA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20220128133620.9411-1-peter.ujfalusi@linux.intel.com>
References: <20220128133620.9411-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/3] SoC: SOF: ipc: Optimizations for tx message
Message-Id: <164341362091.694709.8014500727183175893.b4-ty@kernel.org>
Date: Fri, 28 Jan 2022 23:47:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, rander.wang@intel.com,
 yung-chuan.liao@linux.intel.com
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

On Fri, 28 Jan 2022 15:36:17 +0200, Peter Ujfalusi wrote:
> The series will drop the internal use of 'header' parameter which is always
> set to hdr->cmd.
> 
> The other simplification is to use the provided message directly as it is
> guarantied to be valid throughout the message sending and we can save memory
> by not allocating a temporary buffer, also saving on needles memcpy()
> operations.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: SOF: Intel: cnl: Use pm_gate->hdr.cmd in cnl_compact_ipc_compress()
      commit: 5b6988fe844a298263821beef5fcc41286a048dc
[2/3] ASoC: SOF: ipc: Drop header parameter from sof_ipc_tx_message_unlocked()
      commit: 73a548bd1fa3cbe5d18026230a34c1f058257536
[3/3] ASoC: SOF: ipc: Do not allocate buffer for msg_data
      commit: 2acfab7101140e93928a61ca48d7e442aa538dd7

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
