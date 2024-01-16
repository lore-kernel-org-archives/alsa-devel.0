Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA70C4706C
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jan 2024 09:42:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0DA0950;
	Tue, 16 Jan 2024 10:41:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0DA0950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705398124;
	bh=TlySBWSiIs011eAGAHEWyYI6qGjt/pk2rn1iN0irWl4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=WLr26d17rGnXCknCF0g8/FS9FV1ixj5XgFyq35BG38E8R1cNAbVT7zyk+o+jcTREw
	 zEtbUwVQl6n/X4/jfNdHUqAGtcfKkZRoYtQX2vCcYizhaKjifG7Dxg8b1V5aSx2qUS
	 uc9d3G2luPpFu2QFJD7dH3/fkimbuU/p5oza9XGg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EA5B1F8069E; Tue, 16 Jan 2024 10:40:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24AF6F806A5;
	Tue, 16 Jan 2024 10:40:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44293F805E5; Tue, 16 Jan 2024 10:39:56 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D921AF801F5
	for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2024 10:39:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D921AF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=H17B+xkE
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id EAD1BB80D7F;
	Tue, 16 Jan 2024 09:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992B4C433B2;
	Tue, 16 Jan 2024 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705397981;
	bh=TlySBWSiIs011eAGAHEWyYI6qGjt/pk2rn1iN0irWl4=;
	h=From:To:Cc:Subject:Date:From;
	b=H17B+xkEGVHEtGKliDYxogZ/iFp93RpvoeyRCC7L/U1116iXZwx/DRwOxAASDVsoC
	 8ikYJKhnMiaL8PzdFETwseq332b3/6CeIz25F9M7VXGVvQelUz7gH11CLshfUzwn5q
	 r7+3bdX9o5WKNZNajjt1eBDxVAFFxXVvffcwzYKvcCZ5bzrhWwzeiA+ynr7nwod5an
	 /lcqcTdH5ms0d658RIBUt0Sa71CDWlk45YZYzkeS0OeinrrwHwR0nq5g2OOHDxVy9S
	 /CU6JdkdYqIXmxJunhEBr03ztRv7UsO2gmYjNgBrMCp2S2Y6kOnpsAUOgnYTj9hFx+
	 aOjuqKhW0uJZA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rPfv5-00053P-1G;
	Tue, 16 Jan 2024 10:39:44 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/7] ASoC: qcom: volume fixes and codec cleanups
Date: Tue, 16 Jan 2024 10:38:56 +0100
Message-ID: <20240116093903.19403-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NTMCTDKLGLJ2H7A2I5SLA672F3C6IAGI
X-Message-ID-Hash: NTMCTDKLGLJ2H7A2I5SLA672F3C6IAGI
X-MailFrom: johan+linaro@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

To reduce the risk of speaker damage the PA gain needs to be limited on
machines like the Lenovo Thinkpad X13s until we have active speaker
protection in place.

Limit the gain to the current default setting provided by the UCM
configuration which most user have so far been been using (due to a bug
in the configuration files which prevented hardware volume control [1]).

Included is also a related fix for the LPASS WSA macro driver, which
was changing the digital gain setting behind the back of user space and
which can result in excessive (or too low) digital gain.

There are further Qualcomm codec driver that appear to manipulate
various gain settings, but on closer inspection this turned out to be
effectively dead code which can be removed.

Johan

[1] https://github.com/alsa-project/alsa-ucm-conf/pull/382


Johan Hovold (7):
  ASoC: qcom: sc8280xp: limit speaker volumes
  ASoC: codecs: lpass-wsa-macro: fix compander volume hack
  ASoC: codecs: lpass-wsa-macro: drop dead mixer-path gain hack
  ASoC: codecs: lpass-rx-macro: drop dead mixer-path gain hack
  ASoC: codecs: wcd9335: drop dead gain hacks
  ASoC: codecs: wcd934x: drop dead gain hacks
  ASoC: codecs: msm8916-wcd-digital: drop dead gain hacks

 sound/soc/codecs/lpass-rx-macro.c      |  16 +---
 sound/soc/codecs/lpass-wsa-macro.c     |  19 +---
 sound/soc/codecs/msm8916-wcd-digital.c |  26 +-----
 sound/soc/codecs/wcd9335.c             | 115 ++++---------------------
 sound/soc/codecs/wcd934x.c             | 102 +++++-----------------
 sound/soc/qcom/sc8280xp.c              |   8 +-
 6 files changed, 53 insertions(+), 233 deletions(-)

-- 
2.41.0

