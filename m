Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645C8EB64D9
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Jul 2023 11:44:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D85A83B;
	Thu,  6 Jul 2023 13:43:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D85A83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688643840;
	bh=FZEy4QEqs7ZTgzOhLGi8W3eRpNShzOtd25VIVvaZyMA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=GPdjrPK2sfjspapKRntQmHM8dXyHncVsia0pSBGC/5YjE3halElXiSVRLLB/ssqmo
	 hsoiSUioljYByT9JdStjO54Tmmes+h8SZN80B9r5PMsLJ076k7YEf6MwkEbeGE0Xak
	 QTHAt4Wt9pCKuidNjFVP+dA1AZ1NJq67kRdXumMA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1F57F80563; Thu,  6 Jul 2023 13:42:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AB0FF80552;
	Thu,  6 Jul 2023 13:42:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C6D8F80153; Thu,  6 Jul 2023 13:42:18 +0200 (CEST)
Received: from michel.telenet-ops.be (michel.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 19FB4F80125
	for <alsa-devel@alsa-project.org>; Thu,  6 Jul 2023 13:42:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19FB4F80125
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5979:7b6f:39a:b9cb])
	by michel.telenet-ops.be with bizsmtp
	id Hni62A00245Xpxs06ni621; Thu, 06 Jul 2023 13:42:08 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1qHNN3-000far-HA;
	Thu, 06 Jul 2023 13:42:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1qHNN7-000QkC-Qh;
	Thu, 06 Jul 2023 13:42:05 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] regmap: Fix REGMAP selections
Date: Thu,  6 Jul 2023 13:42:01 +0200
Message-Id: <cover.1688643442.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MNHEGUCLFTG5D2TBOLDAWWMCQPIQBY2G
X-Message-ID-Hash: MNHEGUCLFTG5D2TBOLDAWWMCQPIQBY2G
X-MailFrom: geert@linux-m68k.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MNHEGUCLFTG5D2TBOLDAWWMCQPIQBY2G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

	Hi all,

This patch series fixes several missing selects related to REGMAP.

The first patch fixes a serious thinko I made when making the regmap
KUnit test depend on REGMAP.

The last two patches fix missing selects I discovered when diving deeper
into the REGMAP_* => REGMAP logic.

Thanks for your comments!

Geert Uytterhoeven (3):
  regmap: Replace "default y if" by select
  regmap: REGMAP_SLIMBUS should select REGMAP
  ASoC: codecs: SND_SOC_WCD934X should select REGMAP_IRQ

 drivers/base/regmap/Kconfig | 16 +++++++++++++++-
 drivers/mfd/Kconfig         |  1 -
 sound/soc/codecs/Kconfig    |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
