Return-Path: <SRS0=ENK7=IO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EFCC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 18:04:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922656512E
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 18:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922656512E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CAC1191F;
	Tue, 16 Mar 2021 19:03:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CAC1191F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615917877;
	bh=vEN+n6wSNIMzSQVJ9ow4rLqCKS/jGQtHjjEQ442dKRo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lvQQmSUhHRbSC1bczAzB4nyqzpEidYRbzMoFdkaRO1tMcKnMTJJujWcMQbPyHIyhB
	 j4aV465cJhv7pIdyPY/T920CaBmbbeZIfceqf74GGDDKf5fy7a5tus8c9xzF2UmiUF
	 sRr5WnERIas7eGSmOQ5nm01CJ3dK81UAOnkKEsVw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4989DF804E1;
	Tue, 16 Mar 2021 19:00:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D17F4F804AE; Tue, 16 Mar 2021 19:00:30 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C66B7F804AA
 for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2021 19:00:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C66B7F804AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kjd190MG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8FB8650D9;
 Tue, 16 Mar 2021 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615917626;
 bh=vEN+n6wSNIMzSQVJ9ow4rLqCKS/jGQtHjjEQ442dKRo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kjd190MGd0iDbGrlYcL7jzgzen+5+KXcNDCkf9zRw3esEPWuEc0WfBxGnqddZcAKu
 2V/ph8vRx+Q/RdfRfl+tqzvdqA6wZy3NjSfb9ZJsyi4ZC4loOvplI4St5natUQyKE3
 ebN/+YixtYSkF3WbhyNcdbG0H6HYo292vAUkWMSpBrdVmv7+Nl347sXzqgyWdwuUkS
 q3/bOt3BC36E7nWmtdOmh15MvmdA4hEXtuUsgbi0FhlouZBuh5t45l0nbJ69m/vKsq
 z+FsspVWkaW8lgtd5DIMUQCo50lxE+qVgL9XmQcuKbYXGDwWexkUkmhR+54WMMSspL
 Lb83ZNNGdNtdA==
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>,
	tiwai@suse.de
Subject: Re: [PATCH] ASoC: rt711: add snd_soc_component remove callback
Date: Tue, 16 Mar 2021 17:59:50 +0000
Message-Id: <161591744696.13544.9041827641759467856.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210316005254.29699-1-yung-chuan.liao@linux.intel.com>
References: <20210316005254.29699-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: vkoul@kernel.org, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org, bard.liao@intel.com,
 pierre-louis.bossart@linux.intel.com
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

On Tue, 16 Mar 2021 08:52:54 +0800, Bard Liao wrote:
> We do some IO operations in the snd_soc_component_set_jack callback
> function and snd_soc_component_set_jack() will be called when soc
> component is removed. However, we should not access SoundWire registers
> when the bus is suspended.
> So set regcache_cache_only(regmap, true) to avoid accessing in the
> soc component removal process.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt711: add snd_soc_component remove callback
      commit: 899b12542b0897f92de9ba30944937c39ebb246d

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
