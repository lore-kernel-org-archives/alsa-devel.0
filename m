Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7F7CAC598
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Sep 2025 12:11:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28F77601F6;
	Tue, 16 Sep 2025 14:11:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28F77601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1758024675;
	bh=vMvpD33/YLHO9mP+Yy3drQPm01ooJcuPvq35U+2+2gE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RIztpRztiAt++LcM3v3bOlXkE0G/EQeg9zkwrT4Jbi42jPqgvfYkamORqRdOJzQZI
	 Hv4hc3iukh/AeJqXr5CHbMT0zLbKHQe0EB94Ko0ohXDii05nmUZBPFrKUAjldXEg4N
	 DiZkBj3T4MXAmT3I9FXbnhTT+Xb97hiY85soXH2c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0821F805EE; Tue, 16 Sep 2025 14:10:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B6D5F805F2;
	Tue, 16 Sep 2025 14:10:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F416BF80495; Tue, 16 Sep 2025 14:09:26 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A640AF80086
	for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2025 14:08:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A640AF80086
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=o0HtcqrN
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4304C601A3;
	Tue, 16 Sep 2025 12:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8E2C4CEF0;
	Tue, 16 Sep 2025 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758024527;
	bh=vMvpD33/YLHO9mP+Yy3drQPm01ooJcuPvq35U+2+2gE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o0HtcqrNBAApCEOpmaZ+//hHcVjvJzF83whiX6m1n1OCE39gbk1J+kWX3otVFgKE+
	 eB7Lr7UNP1WJn2tmRREDTM2C0JYPZWH48iyO0KzAn03KismETEkwu/pBv+KauTuhu1
	 ZJzduduftjNG66A4aUbK7s16qUP6RU2dzm1ptdwKHV1FiVMtx6MrQs3CAkbjxLphdj
	 8S/RcJAj0Lj5V29/dra1KCV9/LVFUdjQDEkpYw7XUPVM/CcVdRedJFks4P7it0W14p
	 kY1AeOeShpCjWpPCTC74LAzOpP+VZp/lsifGtGw2cKcqAOR1qCNX+E0x37IfumIc+Z
	 cI7dJdmb7yx8g==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Greg KH <gregkh@linuxfoundation.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20250910171419.3682468-1-venkataprasad.potturu@amd.com>
References: <20250910171419.3682468-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH v2] ASoC: amd: acp: Fix incorrect retrival of
 acp_chip_info
Message-Id: <175802452498.111062.8715620650477854915.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 13:08:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183
Message-ID-Hash: 46TIUKVSDF7XHYQX3GNMPBYO7CWW76AX
X-Message-ID-Hash: 46TIUKVSDF7XHYQX3GNMPBYO7CWW76AX
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/46TIUKVSDF7XHYQX3GNMPBYO7CWW76AX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 10 Sep 2025 22:43:59 +0530, Venkata Prasad Potturu wrote:
> Use dev_get_drvdata(dev->parent) instead of dev_get_platdata(dev)
> to correctly obtain acp_chip_info members in the acp I2S driver.
> Previously, some members were not updated properly due to incorrect
> data access, which could potentially lead to null pointer
> dereferences.
> 
> This issue was missed in the earlier commit
> ("ASoC: amd: acp: Fix NULL pointer deref in acp_i2s_set_tdm_slot"),
> which only addressed set_tdm_slot(). This change ensures that all
> relevant functions correctly retrieve acp_chip_info, preventing
> further null pointer dereference issues.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Fix incorrect retrival of acp_chip_info
      commit: d7871f400cad1da376f1d7724209a1c49226c456

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

