Return-Path: <SRS0=Z0V9=LX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07427C11F67
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Jun 2021 19:50:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2828961D9A
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Jun 2021 19:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2828961D9A
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00F1A1671;
	Tue, 29 Jun 2021 21:49:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00F1A1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624996213;
	bh=hrNhFLADgl4eppCdbVOqKBM0/stVQhsWzlRD8vKOmv8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tO8fV8mxEKGi39t9VWLvvdLB5mu6NxWdnlmzj6PrUMzzNaPPKXs/HtpOCLICIBRz0
	 r0wytYDqnrjBymMfv8K/5s8HIau/4iZ2p7nxHiRSUPhJW3ZCmCOnXzo1JlwkAfUlc2
	 j3thloTnpR6rxQv2OaM3zm1dwHoBt/StoU166DEs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 909FAF80240;
	Tue, 29 Jun 2021 21:49:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB722F80259; Tue, 29 Jun 2021 21:49:21 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CF30CF80156
 for <alsa-devel@alsa-project.org>; Tue, 29 Jun 2021 21:49:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF30CF80156
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1624996154686913013-webhooks-bot@alsa-project.org>
References: <1624996154686913013-webhooks-bot@alsa-project.org>
Subject: Warnings while building alsa-gobject
Message-Id: <20210629194921.AB722F80259@alsa1.perex.cz>
Date: Tue, 29 Jun 2021 21:49:21 +0200 (CEST)
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

alsa-project/alsa-gobject issue #60 was opened from playaspec:

```
spec@spec-OBSPro:/opt/alsa-gobject-0.2.0/build$ ninja
[1/80] Generating alsactl-sigs-marshal_c with a custom command
INFO: Reading ../src/ctl/alsactl-sigs-marshal.list...
[2/80] Generating alsactl-sigs-marshal_h with a custom command
INFO: Reading ../src/ctl/alsactl-sigs-marshal.list...
[71/80] Generating ALSACtl-0.0.gir with a custom command
g-ir-scanner: link: x86_64-linux-gnu-gcc -pthread -o /opt/alsa-gobject-0.2.0/build/tmp-introspectwlgw8uso/ALSACtl-0.0 /opt/alsa-gobject-0.2.0/build/tmp-introspectwlgw8uso/ALSACtl-0.0.o -L. -Wl,-rpath,. -Wl,--no-as-needed -L/opt/alsa-gobject-0.2.0/build/src/ctl -Wl,-rpath,/opt/alsa-gobject-0.2.0/build/src/ctl -lalsactl -lgobject-2.0 -lglib-2.0 -ludev -lgirepository-1.0 -lgio-2.0 -lgobject-2.0 -Wl,--export-dynamic -lgmodule-2.0 -pthread -lglib-2.0
[73/80] Generating ALSATimer-0.0.gir with a custom command
g-ir-scanner: link: x86_64-linux-gnu-gcc -pthread -o /opt/alsa-gobject-0.2.0/build/tmp-introspecth2cag8su/ALSATimer-0.0 /opt/alsa-gobject-0.2.0/build/tmp-introspecth2cag8su/ALSATimer-0.0.o -L. -Wl,-rpath,. -Wl,--no-as-needed -L/opt/alsa-gobject-0.2.0/build/src/timer -Wl,-rpath,/opt/alsa-gobject-0.2.0/build/src/timer -lalsatimer -lgobject-2.0 -lglib-2.0 -ludev -lgirepository-1.0 -lgio-2.0 -lgobject-2.0 -Wl,--export-dynamic -lgmodule-2.0 -pthread -lglib-2.0
[75/80] Generating ALSARawmidi-0.0.gir with a custom command
g-ir-scanner: link: x86_64-linux-gnu-gcc -pthread -o /opt/alsa-gobject-0.2.0/build/tmp-introspectirtcfspf/ALSARawmidi-0.0 /opt/alsa-gobject-0.2.0/build/tmp-introspectirtcfspf/ALSARawmidi-0.0.o -L. -Wl,-rpath,. -Wl,--no-as-needed -L/opt/alsa-gobject-0.2.0/build/src/rawmidi -Wl,-rpath,/opt/alsa-gobject-0.2.0/build/src/rawmidi -lalsarawmidi -lgobject-2.0 -lglib-2.0 -ludev -lgirepository-1.0 -lgio-2.0 -lgobject-2.0 -Wl,--export-dynamic -lgmodule-2.0 -pthread -lglib-2.0
[76/80] Generating ALSAHwdep-0.0.gir with a custom command
g-ir-scanner: link: x86_64-linux-gnu-gcc -pthread -o /opt/alsa-gobject-0.2.0/build/tmp-introspectbm236ozt/ALSAHwdep-0.0 /opt/alsa-gobject-0.2.0/build/tmp-introspectbm236ozt/ALSAHwdep-0.0.o -L. -Wl,-rpath,. -Wl,--no-as-needed -L/opt/alsa-gobject-0.2.0/build/src/hwdep -Wl,-rpath,/opt/alsa-gobject-0.2.0/build/src/hwdep -lalsahwdep -lgobject-2.0 -lglib-2.0 -ludev -lgirepository-1.0 -lgio-2.0 -lgobject-2.0 -Wl,--export-dynamic -lgmodule-2.0 -pthread -lglib-2.0
../src/hwdep/alsahwdep-enum-types.h:10: Warning: ALSAHwdep: symbol='SNDRV_HWDEP_IFACE_LINE6': Unknown namespace for symbol 'SNDRV_HWDEP_IFACE_LINE6'
../src/hwdep/alsahwdep-enum-types.h:16: Warning: ALSAHwdep: symbol='SNDRV_HWDEP_IFACE_FW_MOTU': Unknown namespace for symbol 'SNDRV_HWDEP_IFACE_FW_MOTU'
../src/hwdep/alsahwdep-enum-types.h:17: Warning: ALSAHwdep: symbol='SNDRV_HWDEP_IFACE_FW_FIREFACE': Unknown namespace for symbol 'SNDRV_HWDEP_IFACE_FW_FIREFACE'
[79/80] Generating ALSASeq-0.0.gir with a custom command
g-ir-scanner: link: x86_64-linux-gnu-gcc -pthread -o /opt/alsa-gobject-0.2.0/build/tmp-introspectn1rw21o7/ALSASeq-0.0 /opt/alsa-gobject-0.2.0/build/tmp-introspectn1rw21o7/ALSASeq-0.0.o -L. -Wl,-rpath,. -Wl,--no-as-needed -L/opt/alsa-gobject-0.2.0/build/src/timer -Wl,-rpath,/opt/alsa-gobject-0.2.0/build/src/timer -L/opt/alsa-gobject-0.2.0/build/src/seq -Wl,-rpath,/opt/alsa-gobject-0.2.0/build/src/seq -L/opt/alsa-gobject-0.2.0/build/src/timer -Wl,-rpath,/opt/alsa-gobject-0.2.0/build/src/timer -lalsaseq -lalsatimer -lgobject-2.0 -lglib-2.0 -ludev -lgirepository-1.0 -lgio-2.0 -lgobject-2.0 -Wl,--export-dynamic -lgmodule-2.0 -pthread -lglib-2.0
[80/80] Generating ALSASeq-0.0.typelib with a custom command

```

Tried both git version and the 0.2.0 tar file. System is Ubuntu Studio 20.04.02 Kernel 5.8.0-59-lowlatency. ALSA: alsa-base 1.0.25+dfsg-0ubuntu5, Pulseaudio 1:13.99.1-1ubuntu3.11, pipewire 0.3.31-3~ubuntu20.04, jack2 1.9.14-0ubuntu2

Running on a Mac Pro 4,1, using a MOTU 828mkII.

Perhaps these warnings are inconsequential, but I figured I'd report them since it may affect my hardware. Happy to provide more info and testing.

Issue URL     : https://github.com/alsa-project/alsa-gobject/issues/60
Repository URL: https://github.com/alsa-project/alsa-gobject
