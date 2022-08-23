Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA67C32789
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Aug 2022 15:22:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E956916A2;
	Tue, 23 Aug 2022 17:21:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E956916A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661268146;
	bh=d9e8tVoifQ7GaeXefRpR3cOVTXLtya7HeNbAsuHXZEM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tQ4UFpDEHEux2ivRLbl6wU34JblS004cOIPRK3g4nPUp6kzOcLscFx2H2m8BxSDpI
	 IM1wQz+R5p3zxTXF6e96MWmY6dC8Hdn6lsf3nC9F/CHyCQ2E4yoWnn01D6QliB8Lkk
	 CjWDnql1J8BIbQ55HsAnzTRNf4j5UpLDMuwQdb6I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6AD55F80152;
	Tue, 23 Aug 2022 17:21:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 68FFAF8020D; Tue, 23 Aug 2022 17:21:34 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F3A1F8014E
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2022 17:21:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F3A1F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ufjf5RMz"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2698CB81E07;
 Tue, 23 Aug 2022 15:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352D5C433D6;
 Tue, 23 Aug 2022 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661268083;
 bh=d9e8tVoifQ7GaeXefRpR3cOVTXLtya7HeNbAsuHXZEM=;
 h=From:To:Cc:Subject:Date:From;
 b=Ufjf5RMzDjXQxSoiSj0waZ14yrHv3F1SyHQq5i6E3xBrhcUfCg2Nk8ZoA1P7evjbn
 8AA3yhgGjGrhhLyiwV1qMESJA/SjAkg3GAn2lmh0FY+8xfYwEpYrBnhy+WvsImQowr
 cP2+wzU0UK0V0wChQtCtLlWwhxXcQ9IybZ+LP5NFdRqKCew/Cb2X0Mf/s1bNsaNOeA
 qmDyDxSqXbrU6O/h25ErMzoLpSfGQJ12gqh3QvZaGVwRHLteJLyrIpqIEP90WJpJ6X
 kEl8aQZfWCKpBnudiznNQ/h+s+uOyN38giitazXl1t7LLZDrqKKo98mrnpv/6M6yud
 8P0M8EOU56/5g==
From: Nathan Chancellor <nathan@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Matt Flax <flatmax@flatmax.com>
Subject: [PATCH v2] ASoC: codes: src4xxx: Avoid clang
 -Wsometimes-uninitialized in src4xxx_hw_params()
Date: Tue, 23 Aug 2022 08:19:40 -0700
Message-Id: <20220823151939.2493697-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
 Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
 "Sudip Mukherjee \(Codethink\)" <sudipm.mukherjee@gmail.com>
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

Clang warns:

  sound/soc/codecs/src4xxx.c:280:3: error: variable 'd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
                  default:
                  ^~~~~~~
  sound/soc/codecs/src4xxx.c:298:59: note: uninitialized use occurs here
                  ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_11, d);
                                                                          ^
  sound/soc/codecs/src4xxx.c:223:20: note: initialize the variable 'd' to silence this warning
          int val, pj, jd, d;
                            ^
                            = 0
  sound/soc/codecs/src4xxx.c:280:3: error: variable 'jd' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
                  default:
                  ^~~~~~~
  sound/soc/codecs/src4xxx.c:293:59: note: uninitialized use occurs here
                  ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_10, jd);
                                                                          ^~
  sound/soc/codecs/src4xxx.c:223:17: note: initialize the variable 'jd' to silence this warning
          int val, pj, jd, d;
                        ^
                          = 0
  sound/soc/codecs/src4xxx.c:280:3: error: variable 'pj' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
                  default:
                  ^~~~~~~
  sound/soc/codecs/src4xxx.c:288:59: note: uninitialized use occurs here
                  ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_0F, pj);
                                                                          ^~
  sound/soc/codecs/src4xxx.c:223:13: note: initialize the variable 'pj' to silence this warning
          int val, pj, jd, d;
                    ^
                      = 0
  3 errors generated.

The datasheet does not have any default values for these regmap values
so pick some arbitrary values and print to the user that this is the
case to silence the warnings.

Link: https://github.com/ClangBuiltLinux/linux/issues/1691
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Suggested-by: Matt Flax <flatmax@flatmax.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2: https://lore.kernel.org/20220822183101.1115095-1-nathan@kernel.org/

* Don't return early, just initialize the values to some arbitrary
  numbers and try to hobble along, as other parts of the chip may be
  functional.

* Add message and comment to describe this situation.

 sound/soc/codecs/src4xxx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/src4xxx.c b/sound/soc/codecs/src4xxx.c
index a8f143057b41..db4e280dd055 100644
--- a/sound/soc/codecs/src4xxx.c
+++ b/sound/soc/codecs/src4xxx.c
@@ -280,9 +280,14 @@ static int src4xxx_hw_params(struct snd_pcm_substream *substream,
 		default:
 			/* don't error out here,
 			 * other parts of the chip are still functional
+			 * Dummy initialize variables to avoid
+			 * -Wsometimes-uninitialized from clang.
 			 */
 			dev_info(component->dev,
-				"Couldn't set the RCV PLL as this master clock rate is unknown\n");
+				"Couldn't set the RCV PLL as this master clock rate is unknown. Chosen regmap values may not match real world values.\n");
+			pj = 0x0;
+			jd = 0xff;
+			d = 0xff;
 			break;
 		}
 		ret = regmap_write(src4xxx->regmap, SRC4XXX_RCV_PLL_0F, pj);

base-commit: 94f072748337424c9cf92cd018532a34db3a5516
-- 
2.37.2

