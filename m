Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86971C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 15:24:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09CC60F5B
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 15:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D09CC60F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 520341841;
	Wed, 15 Sep 2021 17:23:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 520341841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631719466;
	bh=XWxiO2KlemLDS/JBHi+KKV0/3h/x2DPr6xTOQUt2t9k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dH3/Zsd0kqvVZAs+PtKRWEcSNGAGWpjuKqpnQuUP0ns62/U7v+XASX9F3puWiAe2v
	 fmujr+wIRm7QV3rf+VeV7GCUSN85stxgNixdoZiqFgYHHsQDhh6akaT+hKEhUclAuk
	 v5lUptQ1gLarLK4b6vAdsmYHcFNt4aryaJg8I1bQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC4DAF804E2;
	Wed, 15 Sep 2021 17:22:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE3CEF800EF; Wed, 15 Sep 2021 17:22:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87157F800EF
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 17:22:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87157F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BCNXa/hJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCACE61186;
 Wed, 15 Sep 2021 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631719354;
 bh=XWxiO2KlemLDS/JBHi+KKV0/3h/x2DPr6xTOQUt2t9k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BCNXa/hJkU0FXK1LD1GDQxtjT4tgxlIflXNOMzETmmGzxhheyf8Sy/fnsssTXE8uv
 mNXv9kmG8MSFmdm6PCil6NaTQAXaXpPzmUEYX3AwN1xNjvXe55laEqkC/4AVw4L3Wz
 wMi2NYwd/BGHyEluR9+4lehkZ+MgxdrCg2jo+6/jkgsbUEWpaYtha22f8ssozZN88I
 ThOKRpX0VsrhVKsEsXU29EQ1siiy/DzSMWG4dmFJF+L9ovaVJ2Fx/WBN6Q6/6nt5hf
 bjWS3XbFiWXerLHqfkusx1rfD8J3CijiziLILbgj6QLAyZ4pugpWJ2EgT2JlYZWOo7
 l3Gg88QYASSUg==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: SOF: Fix DSP oops stack dump output contents
Date: Wed, 15 Sep 2021 16:21:42 +0100
Message-Id: <163171901943.9674.14447227045564759721.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210915063230.29711-1-peter.ujfalusi@linux.intel.com>
References: <20210915063230.29711-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, daniel.baluta@gmail.com,
 Mark Brown <broonie@kernel.org>, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

On Wed, 15 Sep 2021 09:32:30 +0300, Peter Ujfalusi wrote:
> From: Yong Zhi <yong.zhi@intel.com>
> 
> Fix @buf arg given to hex_dump_to_buffer() and stack address used
> in dump error output.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Fix DSP oops stack dump output contents
      commit: ac4dfccb96571ca03af7cac64b7a0b2952c97f3a

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
