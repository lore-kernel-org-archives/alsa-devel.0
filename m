Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5F3C00140
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Aug 2022 14:36:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8FF121632;
	Fri,  5 Aug 2022 16:35:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8FF121632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659710198;
	bh=F1G4Gd5W4ivsi9cF1XytEpiwEIyFOFrQsBAYo5F5FKk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tPWljtYkGheCs/2mkVcwRKm9E3Njrg9LBkXfB4zJIs4P5rZGmuDo5ytB1OpF05wa/
	 RGtjLuTOkR8Lmq2nxXMlBZ5qj7FO7DMu81IOYAhmVcvYnNuRHEVM270ro5vbAI9wat
	 oxNeUUpOI7wdgxAxfZZS4fFbN58u8XUhVXznvulA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08BF1F80238;
	Fri,  5 Aug 2022 16:35:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 794DBF8027C; Fri,  5 Aug 2022 16:35:45 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6535FF8012F
 for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2022 16:35:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6535FF8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RmBB/+Ts"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1EB95B82887;
 Fri,  5 Aug 2022 14:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8137C433D6;
 Fri,  5 Aug 2022 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659710137;
 bh=F1G4Gd5W4ivsi9cF1XytEpiwEIyFOFrQsBAYo5F5FKk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=RmBB/+TsvDeL11yi3zFa+yW4BYoERuF1+mmV/LGb1mMA/W36mnwpy4UbpgAjRoNc4
 LRRO8jhWuFiRvYoSqCF82yR0aWr0iV6MPzuFeu0DehHB9JdjI7FNfBJtm8OL5Tk6QA
 iq684LG101KxgX6lXWCBBBr33QuGgjiP5H+DG7S52f+AO3C5sbIOE1P923XV+BCKqn
 dxjpCzWmyDJkPitbxm0GsEVsrm1aaE2I9qgiQ2M28mgt7aLYf6Qz7/MdABTStVZkzw
 YL/mcuvO3dKsDfFuSryxKf+BogFkRxAwNSfIte9tLM5qGIKhdvrJdP0dVv802t96EH
 BCi7WrnbHfQNQ==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20220801165420.25978-1-tiwai@suse.de>
References: <20220801165420.25978-1-tiwai@suse.de>
Subject: Re: [PATCH 0/3] ASoC: Fix theoretical buffer overflow by snprintf()
Message-Id: <165971013638.1087218.13446737139526551877.b4-ty@kernel.org>
Date: Fri, 05 Aug 2022 15:35:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On Mon, 1 Aug 2022 18:54:17 +0200, Takashi Iwai wrote:
> this is a patch series to paper over the theoretical buffer overflow
> that might be caused by snprintf().  snprintf() is notorious for its
> behavior and the usage of a safer version, scnprintf(), is
> recommended.
> 
> 
> Takashi
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: Intel: avs: Fix potential buffer overflow by snprintf()
      commit: ca3b7b9dc9bc1fa552f4697b7cccfa0258a44d00
[2/3] ASoC: SOF: debug: Fix potential buffer overflow by snprintf()
      commit: 1eb123ce985e6cf302ac6e3f19862d132d86fa8f
[3/3] ASoC: SOF: Intel: hda: Fix potential buffer overflow by snprintf()
      commit: 94c1ceb043c1a002de9649bb630c8e8347645982

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
