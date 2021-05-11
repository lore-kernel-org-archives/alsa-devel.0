Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B74C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:28:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E6761948
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E6761948
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBD0C1759;
	Tue, 11 May 2021 10:27:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBD0C1759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620721682;
	bh=m9zlLDv90RfQ+x96u3VrEpC2hqe/Kaz9L9sKJE/1ISU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vLjoWb/qDBPnraf4Fios96N4E1Qk69z/EmnvV3HEBoU/CjMv2lkB1KVG3HxT1bgcC
	 b2OnXgrwYZf9hjdrHnU/ICjZhMv3aWdte8Pv1u2QYOHHgsMtqXA2yDXlXtW9z17oEW
	 ekq2RACt61y5zqsBZ9CPKBLKypmxMBSZBeDf6NLg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48C5BF8013A;
	Tue, 11 May 2021 10:27:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25EACF80163; Tue, 11 May 2021 10:27:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32348F800E9
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 10:27:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32348F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tAs7NGzy"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B11E613C3;
 Tue, 11 May 2021 08:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620721620;
 bh=m9zlLDv90RfQ+x96u3VrEpC2hqe/Kaz9L9sKJE/1ISU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tAs7NGzyCiNRSXZNAa2ZQpj3Vji726uUIafVdSKJw9qj8It92cE2sRWrtrcs0fSGK
 0lxfh++CxJB37Fjold1O0ToZk7nYhlQUmIMYunFNqTWJZGiCxYGC94TymUG33UUhfC
 deubdBhRdBU6/mXPub7IjtKhgCB6qDQAEJhUeCZ/0zFCSfdpo11uhOGr7Y4zEbpKlM
 TmBUZ6b91U4u6l9s75AqAZLXvCGeaiX2xZjJF0Rs8Bxrj2Nz0VaxVLtIzZ69hEZ9yJ
 X6Dz9B8CIYGL2fgYo4hHqardQMxOBhAVQ373yUdNYdhB2QqWuf0diIN/WpONUWeASU
 yzX0QLt+2TxJw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
Date: Tue, 11 May 2021 09:25:35 +0100
Message-Id: <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
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

On Fri, 23 Apr 2021 21:24:27 +0300, Andy Shevchenko wrote:
> Set of cleanups here and there related to the SPI PXA2xx driver.
> On top of them, adding the special type for Intel Merrifield.
> 
> In v2:
> - cover letter (Mark)
> - drop moving the header in patch 5 (Mark)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/14] spi: pxa2xx: Use one point of return when ->probe() fails
        commit: f2eed8caa336e31d672804a8725dadba0415f19d
[02/14] spi: pxa2xx: Utilize MMIO and physical base from struct ssp_device
        commit: 9e43c9a8d5de4810ea9688519d55b5e46784d84a
[03/14] spi: pxa2xx: Utilize struct device from struct ssp_device
        commit: c3dce24c40cc7cd07deca5b81b763eae66f30856
[04/14] spi: pxa2xx: Replace header inclusions by forward declarations
        commit: 0e4768713e71dd224633fd7e00ad358bc48f433a
[05/14] spi: pxa2xx: Unify ifdeffery used in the headers
        commit: 5edc24901f4d469f8fc943004f73655933e89dbf
[06/14] spi: pxa2xx: Group Intel Quark specific definitions
        commit: 1beb37b0e3f98708bfb37778049764b4500756da
[07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
        (no commit info)
[08/14] spi: pxa2xx: Reuse int_error_stop() in pxa2xx_spi_slave_abort()
        (no commit info)
[09/14] spi: pxa2xx: Use pxa_ssp_enable()/pxa_ssp_disable() in the driver
        (no commit info)
[10/14] spi: pxa2xx: Extract pxa2xx_spi_update() helper
        (no commit info)
[11/14] spi: pxa2xx: Extract clear_SSCR1_bits() helper
        (no commit info)
[12/14] spi: pxa2xx: Extract read_SSSR_bits() helper
        (no commit info)
[13/14] spi: pxa2xx: Constify struct driver_data parameter
        (no commit info)
[14/14] spi: pxa2xx: Introduce special type for Merrifield SPIs
        (no commit info)

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
