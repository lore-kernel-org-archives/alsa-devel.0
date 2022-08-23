Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3822C32772
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Aug 2022 18:39:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0AE9168C;
	Tue, 23 Aug 2022 20:38:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0AE9168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661279943;
	bh=396LYDed7Bdsq00iE/8/5oc0iVtjh5hfvrDI/+33XAU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B+hjvLdPgSnpM+PHkdmrpI0xaBeBu3b92VRZtnXVC3I2b60ZgtFQ5Kho/fGdBR7ux
	 DHZdBAwftlpbzukHNWIrhtr/6EdxaZ4Hpyh+D+T0t2B9LQwBep3djdeAlK3+jCisG0
	 AKeoYAkQr7/VsdagS8U7LaOgnd+T1nwSb5uQFnEQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D1A2F80527;
	Tue, 23 Aug 2022 20:37:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BE5BF804E7; Tue, 23 Aug 2022 20:37:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2DE65F800A7
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2022 20:37:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DE65F800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HDrJSdF3"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E99BB61702;
 Tue, 23 Aug 2022 18:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88E0C433D7;
 Tue, 23 Aug 2022 18:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661279834;
 bh=396LYDed7Bdsq00iE/8/5oc0iVtjh5hfvrDI/+33XAU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=HDrJSdF3KGL2o6E0cfv/kXuEP2uDcu5+W3QjIGXqLNRcLQqOtCI/0FXaYYn6bc6hl
 zYrXZNn9pfmuntJ40Zbp4RMrCByHrSzWivLxBxIv3ZQkOGy6KFn0pA9+6J0nznM4KT
 FdP9PIDElP2n/xZ743wD8RBbB0bhth3EfmjO0+qdGxOKLh2LTCtjFHg7CItphc7WKu
 il0eJypbZ9xmyFT1l7s5UeJwBZA0xoXGzm1AWZejkEXy1rPRn0ELJWRB5wnyVj1bvQ
 N4TVsjPDzqFtrp76LgtIz3Fe77NcjfD30bZgVE+khJ0jhho1MbBo0DltpCMb0rJLB2
 Ke2LnRuXFwOfQ==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20220822190211.170537-1-pierre-louis.bossart@linux.intel.com>
References: <20220822190211.170537-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: fix alh_group_ida max value
Message-Id: <166127983267.711152.8470557815310392863.b4-ty@kernel.org>
Date: Tue, 23 Aug 2022 19:37:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
Cc: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>,
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Rander Wang <rander.wang@intel.com>
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

On Mon, 22 Aug 2022 21:02:11 +0200, Pierre-Louis Bossart wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> group_id is from 0 ~ ALH_MULTI_GTW_COUNT - 1, not 0 ~
> ALH_MULTI_GTW_COUNT.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc4-topology: fix alh_group_ida max value
      commit: 4ee6fc271b59e805301371ea3862f558a23d9c7b

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
