Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88593C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 14:20:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D82D123102
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 14:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82D123102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C8541871;
	Mon, 25 Jan 2021 15:20:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C8541871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611584451;
	bh=u/+n6nnkvGvxt7zRdHaBLolJlN1oNzH+JqV1Ev9ooqk=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZNOO8Dj2Y/0FwCyxDQlEPaNbFeOgeXxp82HqWa7fCIeHRbEKShM0C6EgtoLUugjv1
	 Ue9t1OMx5N7//dQBhIA+YQYACR8fhEErF0OFFGg3peInfxeRiSJ85drMNq144go6GP
	 kVZsYhNDLc64P3DF6CC/P6041kn5OFDuGSbGp9PA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EFC9F804D6;
	Mon, 25 Jan 2021 15:18:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1691F804D8; Mon, 25 Jan 2021 15:18:29 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0F5CF804CB
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 15:18:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0F5CF804CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AR9v1e0+"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 338772145D;
 Mon, 25 Jan 2021 14:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611584304;
 bh=u/+n6nnkvGvxt7zRdHaBLolJlN1oNzH+JqV1Ev9ooqk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=AR9v1e0+/x8PY265K5Zk2IYqptFl+CHwFaw7Ycrl03Q8kI2o0C8tFdng21D5FjRPh
 MLWk0LMZ8Rg/CsiuJ3VxyqY4va6nMGJReezkw7MSYNLAi2NFBG+JBfzNW3H+zamJjK
 NWT7A05vvCARiXMe+GAOWp1ReJjuHrK47ekxLaHKrBib0duGrTlFy7u7urn9EaxGGP
 uN6c27M2lTjBWpy5O0s+46QMC0Jed1kPQs93PuWwFnpxdlyHQk9RpLsQrLpVWnYRTQ
 Hu/avjl5P4ePl2o+2txWZYw3uQOI63SZFbHDhkuqCehklzI0ZWNpP8DsR4h13SwLuG
 wDJcjzpvIdg1w==
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20210125061453.1056535-1-tzungbi@google.com>
References: <20210125061453.1056535-1-tzungbi@google.com>
Subject: Re: [PATCH v2] ASoC: mediatek: mt8192-mt6359: add format constraints
 for RT5682
Message-Id: <161158424213.32959.10480375557812092532.b4-ty@kernel.org>
Date: Mon, 25 Jan 2021 14:17:22 +0000
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

On Mon, 25 Jan 2021 14:14:53 +0800, Tzung-Bi Shih wrote:
> MT8192 determines the I2S clock rates according to the sampling rates.
> 
> There is only 1 set of I2S in between MT8192 and RT5682.  If playing and
> capturing via RT5682 in different sampling rates, the I2S data will be
> corrupted.
> 
> Adds format constraints to the corresponding DAI links to make sure the
> sampling rates are symmetric.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8192-mt6359: add format constraints for RT5682
      commit: 339f6c73d5abe85550a0c962edc8a5df1f2b4273

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
