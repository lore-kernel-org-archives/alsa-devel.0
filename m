Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4C7C27C4F
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Jun 2024 16:07:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEAD81908;
	Thu, 13 Jun 2024 18:07:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEAD81908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718294848;
	bh=C9QZlpACMYy1Zfnu2NImSG8I/J6FWYhPgPQBtPiN+aM=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=fHFnIXcPeaMdioWWRoxVXNUHRdJ6gZ5CjttMRbF2l5DEGKjX5jWk4+v0TzITYUeQO
	 RqxsTvjY3IC41nW1ED/lMe1wpzIhJ9OzsH/K6lp7IV9CAKxoZxWQg7DJyOqn+4qyQc
	 sd0p7dsZSjeiW1VLCeuB+3lo1bJXdL6na7XP0Cug=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43AE5F89716; Thu, 13 Jun 2024 18:02:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74955F89716;
	Thu, 13 Jun 2024 18:02:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A9E3F802DB; Tue,  4 Jun 2024 12:11:42 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 643FFF800FA
	for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2024 12:11:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 643FFF800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=IRJoZmGN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717495895; x=1749031895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C9QZlpACMYy1Zfnu2NImSG8I/J6FWYhPgPQBtPiN+aM=;
  b=IRJoZmGNv79ZenRbl8Pk51n3T6AwQqFIkChMlV8NbUreMZ+KmJpP6ezJ
   B3Mb2fP/gZk+CxJlKKwD87iMF3xCZTjM2tAiq07KlmZwnFIBSQZZfVBRh
   t7I610STFxB//ZCEEzwHfeK2ba2yusz6OctH+Jm8RX+lpseJX0Wau94+d
   jZHGM84U1sF4DpMFcDccJhahiyzJ0cBEwG38pfrQFG+D3MmaaG9DPMps1
   uE0LNCuZtVkC0MNCe227YafGo9XYVMfbqMPMKFu8sSjMv32jKeUG/Fa5j
   4B/F7UWltTGFW3Aa8VKsFxDEpTpEYXvhwHOFh5KtuIm3ZC5BUTe5sU2Zo
   g==;
X-CSE-ConnectionGUID: wEzRrHHTQXqTSqyPNngmpw==
X-CSE-MsgGUID: VmTWgr6UT6GmI5MeZ9Sbbw==
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000";
   d="scan'208";a="257789211"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Jun 2024 03:11:30 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Jun 2024 03:10:49 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 4 Jun 2024 03:10:47 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <kuninori.morimoto.gx@renesas.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH] ASoC: atmel: atmel-classd: Re-add dai_link->platform to fix
 card init
Date: Tue, 4 Jun 2024 13:10:30 +0300
Message-ID: <20240604101030.237792-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MailFrom: prvs=87800a655=Andrei.Simion@microchip.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 6Z32CGYEUUDEOPWTMAR5JNMW5GRY2BTJ
X-Message-ID-Hash: 6Z32CGYEUUDEOPWTMAR5JNMW5GRY2BTJ
X-Mailman-Approved-At: Thu, 13 Jun 2024 16:02:20 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6Z32CGYEUUDEOPWTMAR5JNMW5GRY2BTJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The removed dai_link->platform component cause a fail which
is exposed at runtime. (ex: when a sound tool is used)
This patch re-adds the dai_link->platform component to have
a full card registered.

Before this patch:
:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: CLASSD [CLASSD], device 0: CLASSD PCM snd-soc-dummy-dai-0 []
    Subdevices: 1/1
    Subdevice #0: subdevice #0

:~$ speaker-test -t sine
speaker-test 1.2.6
Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Playback open error: -22,Invalid argument

After this patch which restores the platform component:
:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: CLASSD [CLASSD], device 0: CLASSD PCM snd-soc-dummy-dai-0
						[CLASSD PCM snd-soc-dummy-dai-0]
    Subdevices: 1/1
    Subdevice #0: subdevice #0
-> Resolve the playback error.

Fixes: 2f650f87c03c ("ASoC: atmel: remove unnecessary dai_link->platform")
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 sound/soc/atmel/atmel-classd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 6aed1ee443b4..ba314b279919 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -473,19 +473,22 @@ static int atmel_classd_asoc_card_init(struct device *dev,
 	if (!dai_link)
 		return -ENOMEM;
 
-	comp = devm_kzalloc(dev, sizeof(*comp), GFP_KERNEL);
+	comp = devm_kzalloc(dev, 2 * sizeof(*comp), GFP_KERNEL);
 	if (!comp)
 		return -ENOMEM;
 
-	dai_link->cpus		= comp;
+	dai_link->cpus		= &comp[0];
 	dai_link->codecs	= &snd_soc_dummy_dlc;
+	dai_link->platforms	= &comp[1];
 
 	dai_link->num_cpus	= 1;
 	dai_link->num_codecs	= 1;
+	dai_link->num_platforms = 1;
 
 	dai_link->name			= "CLASSD";
 	dai_link->stream_name		= "CLASSD PCM";
 	dai_link->cpus->dai_name	= dev_name(dev);
+	dai_link->platforms->name	= dev_name(dev);
 
 	card->dai_link	= dai_link;
 	card->num_links	= 1;
-- 
2.34.1

