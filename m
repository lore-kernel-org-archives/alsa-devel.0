Return-Path: <SRS0=30sX=ZH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E944C432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:11:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC96820672
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AFFBGLod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC96820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 223EC166A;
	Fri, 15 Nov 2019 17:11:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 223EC166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573834314;
	bh=nKs/jZMT8HBLVS35+CKEFpq143ZMT8JM82aiYgxcBI4=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AFFBGLod1BRDLk3iosxBEp7zjPi981aO3zDcGrfPJc9/ZWUgTkMqbFw5nWRRy1jC8
	 nA7lMQgG2K8tXY8xvgXScjDfchroo5vxL2vDg6lxioHRJKl3ABF6IZi6ozzsW88NLI
	 X/2PG2ir5YfRY1wHrrsfIssGbtr2RTTYS0xno9tk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC15FF80122;
	Fri, 15 Nov 2019 17:08:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00651F80106; Fri, 15 Nov 2019 17:08:33 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D31A1F800CC
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 17:08:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D31A1F800CC
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28]
 helo=dude02.lab.pengutronix.de)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mfe@pengutronix.de>)
 id 1iVe90-0002S4-MD; Fri, 15 Nov 2019 17:08:22 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
 (envelope-from <mfe@pengutronix.de>)
 id 1iVe8y-00047B-5i; Fri, 15 Nov 2019 17:08:20 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: robh+dt@kernel.org, KCHSU0@nuvoton.com, broonie@kernel.org,
 thomas.fehrenbacher@siedle.de
Date: Fri, 15 Nov 2019 17:08:16 +0100
Message-Id: <20191115160819.15557-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kernel@pengutronix.de
Subject: [alsa-devel] [PATCH 0/3] Add NAU8812 support
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

this small series adds the documentation and support for the nau8812
devices. The exisiting nau8810 driver can handle both devices so we only
need to add the dt-bindings and inform the user by adapting the Kconfig
entry.

Futhermore the series adds the support for the aux-port control.

@John Hsu
Please can you verify that register accesses to the aux-port control
bits don't affect the nau8810 devices? I don't have such a device but
the documentations says that those register fields are just '0'ed. So I
assume the nau8810 devices ignore such writes.

Marco Felsch (2):
  dt-bindings: ASoC: add nau8812 documentation
  ASoC: nau8810: add support for nau8812

Thomas Fehrenbacher (1):
  ASoC: nau8810: add aux input control, available on NAU8812

 Documentation/devicetree/bindings/sound/nau8810.txt | 2 +-
 sound/soc/codecs/Kconfig                            | 2 +-
 sound/soc/codecs/nau8810.c                          | 9 +++++++++
 sound/soc/codecs/nau8810.h                          | 2 ++
 4 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
