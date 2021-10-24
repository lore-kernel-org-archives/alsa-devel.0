Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5690DC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 06:16:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F4B60FD7
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 06:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90F4B60FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1EAE16D8;
	Tue, 26 Oct 2021 08:15:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1EAE16D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635228980;
	bh=zN2i22Fd/S5qDtfAls137mCszCkZmYo9i1kF6YMHLJA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SLr47YKFtcXV+H4PbJ/ABNOCoQ+DReBsW2515rg5T5HBQEmz1OoCvOsT0wO5EoQ17
	 ySXZ+uj534KjS5JTXEK0DFpw7DMlGnxBUZnPPoLrF75+m+CQZ54ray/IHGCk9BUM9s
	 TzZKoSZZ3fYJbdnVDnU/AuWj9k1/fiM0Q5MMYtMM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53447F804D8;
	Tue, 26 Oct 2021 08:14:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3943EF802C8; Sun, 24 Oct 2021 11:43:39 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09E4EF80086
 for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2021 11:43:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09E4EF80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="D+IxJfDT"
Received: by mail-pj1-x1041.google.com with SMTP id
 nn3-20020a17090b38c300b001a03bb6c4ebso6166023pjb.1
 for <alsa-devel@alsa-project.org>; Sun, 24 Oct 2021 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MrbROqXyWzGGo891/8i0TiDfYYNlRGnvVXjh5R350kQ=;
 b=D+IxJfDTlaPFHKaGSkioy3KtuQXAKXoegBDkVlSbcllXOwIHRRyMIa7Zv91I43dZql
 hBWdUqkXVcEeSHZhqwr+VnbHMAPUZCCtH+X9mV6xoARE+uK7jrSWxRYJUp/69/+5owS5
 /q7mlV1/vb9e0OgQiW8CJnfTEjyLksgQR6MpmvloVH2v59MAR1Z4ddBCXhEMAg1f5U/x
 Ywn0ghtXOFckGFtYY4z083bAW6e5jBo2kfaFzxgCe0Vahyop2rw58fXv5B3dAdL2lN4k
 Lhut7Shn7L1WDXQrgJq2XYc/t2f9OmbaABEM57Zighlw6THGixL70aFORR1gIrVaXcUc
 xXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MrbROqXyWzGGo891/8i0TiDfYYNlRGnvVXjh5R350kQ=;
 b=vI//2yhyiJPu/uOhP3mkOWZhhcVr3yWqYrAX1aSVd8fR2CXlnB09ha71mSjd97C6EI
 ZEvRVPIZsXMMQJ6goc6cc2Gna4sZYLlUx9qhAu3bEz46pgzK3KyRkue7D+hq/X7NJNbl
 v/2f6WA1NM2WHLgCx1rsqEBBl7ojsa4ZQMZcB7NnDfCgOnOg4/hfjr0r6X3Em/hLhU7W
 XhbgkBJo/DROHXSmGTmgZOuXaVBV36q7Kf9bd8IOgSfO9xOM9pTByxF3OGiMWQ34vUX6
 +wkKlw3jXd1Med9Q8KEnlM8q9zGULYl+BKtsi/90RzePsyBhOf1O3XmHRt5GEcKP3DY4
 xGpw==
X-Gm-Message-State: AOAM530RrvCXwtgRzW4OShlJbN8m7nFywdJqMO/XlsEQ3DK8s8N0W5Xr
 2xYO6NXOp05aWDnHgSYwUd8=
X-Google-Smtp-Source: ABdhPJwFuPHuB7BVXh0QqTHXKQUbZjDsXO1xJtOvODqb+NmKn6K070jcwnL7BE4xtB1oGrrJapxgZA==
X-Received: by 2002:a17:90a:34b:: with SMTP id
 11mr12652753pjf.188.1635068609645; 
 Sun, 24 Oct 2021 02:43:29 -0700 (PDT)
Received: from lxb-server.lan ([2403:18c0:2:7e::1926:817])
 by smtp.gmail.com with ESMTPSA id p16sm17636619pfh.97.2021.10.24.02.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Oct 2021 02:43:29 -0700 (PDT)
From: Yunhao Tian <t123yh.xyz@gmail.com>
X-Google-Original-From: Yunhao Tian <t123yh@outlook.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] Rockchip S/PDIF Reciever Driver
Date: Sun, 24 Oct 2021 17:43:14 +0800
Message-Id: <20211024094317.1641949-1-t123yh@outlook.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 Oct 2021 08:14:36 +0200
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Yunhao Tian <t123yh.xyz@gmail.com>, linux-arm-kernel@lists.infradead.org
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

From: Yunhao Tian <t123yh.xyz@gmail.com>

Hello,

This patch series adds support for S/PDIF receiver found
on RK3308.

The code is based on Rockchip Kernel 4.4. Several ALSA
controls such as synchronization status, sample rate and
channel status bits are added. Also some basic error handling
such as parity error or BMC decode error are performed. The 
implementation took stm32-spdifrx and mchp-spdifrx as reference.

The driver is tested to be working on my custom board based
on Firefly CORE-3308Y, with a TOSLINK receiver.

This is my first time submitting a new driver to kernel, so
I'll appreciate it if I can be corrected for anything wrong.

Yunhao Tian (3):
  ASoC: rockchip: add support for spdifrx receiver
  ASoC: dt-bindings: rockchip: add spdifrx bindings
  arm64: dts: rockchip: add spdifrx support to rk3308.dtsi

 .../bindings/sound/rockchip-spdifrx.yaml      |  80 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      |  16 +
 sound/soc/rockchip/Kconfig                    |   8 +
 sound/soc/rockchip/Makefile                   |   2 +
 sound/soc/rockchip/rockchip_spdifrx.c         | 660 ++++++++++++++++++
 sound/soc/rockchip/rockchip_spdifrx.h         |  90 +++
 7 files changed, 863 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-spdifrx.yaml
 create mode 100644 sound/soc/rockchip/rockchip_spdifrx.c
 create mode 100644 sound/soc/rockchip/rockchip_spdifrx.h

-- 
2.25.1

