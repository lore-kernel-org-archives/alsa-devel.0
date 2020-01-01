Return-Path: <SRS0=lBDT=2W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CEBC2D0DC
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jan 2020 16:00:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD1E20842
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jan 2020 16:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qzU3CyZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD1E20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B854C16EF;
	Wed,  1 Jan 2020 16:59:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B854C16EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577894447;
	bh=HwWz/FXW/vcWgLNfyrJnCqBrpsM1bDw109ijsoWogOU=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qzU3CyZ9l7OMJ0z/4mL/rhW0LpCcFwQhF4qh4pToD2XBZj7YqK5cQ5qKXmgcfQ07+
	 OiHQb2jixOkPlm69NRD/ikV2epEXqyLY2J5jJulIKZN+ZfwEyicexX14yMkk/Fr6sN
	 CD1JjUzV0lnHdklaE82QDPrYOOvHmCtwTV+xxVws=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E3D5F8026A;
	Wed,  1 Jan 2020 16:58:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07852F8015F; Wed,  1 Jan 2020 09:20:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1361FF8015C
 for <alsa-devel@alsa-project.org>; Wed,  1 Jan 2020 09:20:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1361FF8015C
X-IronPort-AV: E=Sophos;i="5.69,382,1571695200"; d="scan'208";a="429578748"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256;
 01 Jan 2020 09:20:08 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Date: Wed,  1 Jan 2020 08:43:18 +0100
Message-Id: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
X-Mailman-Approved-At: Wed, 01 Jan 2020 16:58:14 +0100
Cc: linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
 Jonas Karlman <jonas@kwiboo.se>, linux-arm-msm@vger.kernel.org,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-gpio@vger.kernel.org,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-nfs@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: [alsa-devel] [PATCH 00/16] constify copied structure
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Make const static structures that are just copied into other structures.

The semantic patch that detects the opportunity for this change is as
follows: (http://coccinelle.lip6.fr/)

<smpl>
@r disable optional_qualifier@
identifier i,j;
position p;
@@
static struct i j@p = { ... };

@upd@
position p1;
identifier r.j;
expression e;
@@
e = j@p1

@ref@
position p2 != {r.p,upd.p1};
identifier r.j;
@@
j@p2

@script:ocaml depends on upd && !ref@
i << r.i;
j << r.j;
p << r.p;
@@
if j = (List.hd p).current_element
then Coccilib.print_main i p
</smpl>

---

 arch/powerpc/sysdev/mpic.c                          |    4 ++--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c |    2 +-
 drivers/media/i2c/mt9v111.c                         |    2 +-
 drivers/media/platform/davinci/isif.c               |    2 +-
 drivers/media/usb/cx231xx/cx231xx-dvb.c             |    2 +-
 drivers/media/usb/dvb-usb-v2/anysee.c               |    4 ++--
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c           |    2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c            |    2 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c             |    2 +-
 drivers/ptp/ptp_clockmatrix.c                       |    2 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c             |    2 +-
 drivers/video/fbdev/sa1100fb.c                      |    2 +-
 net/sunrpc/xdr.c                                    |    2 +-
 sound/isa/ad1816a/ad1816a_lib.c                     |    2 +-
 sound/pci/hda/hda_controller.c                      |    2 +-
 sound/soc/qcom/qdsp6/q6asm-dai.c                    |    2 +-
 16 files changed, 18 insertions(+), 18 deletions(-)
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
