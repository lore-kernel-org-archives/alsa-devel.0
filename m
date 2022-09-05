Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C19ECAAD5
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Sep 2022 15:51:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E021F950;
	Mon,  5 Sep 2022 17:50:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E021F950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662393067;
	bh=qLG+gfl6NXOiN1sJRiTTTnudslb/lpCs8P99I2VG72E=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W/ALv/2yeJkyYQgo2KDFq+GpTlf482muzwajr7Orh4y5jtdffQfzY/BJ+YVwFDsQm
	 b/Dpt7MX8wtwbMJtN2GgULHZ1xOCvaGbPHturAFWBOjr5bH9WJmBBOOtcaCqCwkIql
	 LckiZd7+Kyb4MqntQKDyCcBKFfhfTdA7nLxOxRTg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B661F80165;
	Mon,  5 Sep 2022 17:50:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1945DF80238; Mon,  5 Sep 2022 17:50:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 857E7F800E8
 for <alsa-devel@alsa-project.org>; Mon,  5 Sep 2022 17:50:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 857E7F800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UAnRCd0O"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 073A561329;
 Mon,  5 Sep 2022 15:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3695CC433D6;
 Mon,  5 Sep 2022 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662393011;
 bh=qLG+gfl6NXOiN1sJRiTTTnudslb/lpCs8P99I2VG72E=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=UAnRCd0Ouphg1HatAZN2aLqLIxt84vYh1H5kpFF30njCC69n22BclB7oaliWbWB8V
 GNdNXUOvCrDPFRUk8nUie3N14Eaa0KpdHbgUiGlgdvGYkyEkXXn0z+F8gXBo1PlDUH
 bJhFN+uTJ8Zn+pUYEoiaXcKIyiQX9L69w/KMVDo+g2ej2nlsNLMYNby9Op9YRMmaRJ
 0KSzH14F2FFXRRS1J/P82ungI+y57iw0tlI9of6axXGyL2HITafdgD/oXHnuO2S230
 X38INZF+INO73jSxbEcdTRY0dr/KwBH1J33BxvZsFItM0d8nVisc37Pzg1M/6o6n5l
 bVb7KoF4bJ1Vg==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20220904102840.862395-1-cezary.rojewski@intel.com>
References: <20220904102840.862395-1-cezary.rojewski@intel.com>
Subject: Re: [PATCH v6 0/2] lib/string_helpers: Introduce
 parse_int_array_user()
Message-Id: <166239300589.745322.7930709481816524867.b4-ty@kernel.org>
Date: Mon, 05 Sep 2022 16:50:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: andy@kernel.org, pierre-louis.bossart@linux.intel.com,
 intel-poland@eclists.intel.com, kai.vehmanen@linux.intel.com,
 lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com, tiwai@suse.com,
 linux-kernel@vger.kernel.org, willy@infradead.org, hdegoede@redhat.com,
 andy.shevchenko@gmail.com, ranjani.sridharan@linux.intel.com,
 amadeuszx.slawinski@linux.intel.com, yung-chuan.liao@linux.intel.com
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

On Sun, 4 Sep 2022 12:28:38 +0200, Cezary Rojewski wrote:
> Continuation of recent upstream discussion [1] regarding user string
> tokenization.
> 
> First, parse_int_array_user() is introduced to allow for splitting
> specified user string into a sequence of integers. Makes use of
> get_options() internally so the parsing logic is not duplicated.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] lib/string_helpers: Introduce parse_int_array_user()
      commit: d2a411f810a0db055f02cc18e5cfa833bb2c9ccc
[2/2] ASoC: SOF: Remove strsplit_u32() and tokenize_input()
      commit: b9163e9b5f14d690752010ee843b2d788c3536f1

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
