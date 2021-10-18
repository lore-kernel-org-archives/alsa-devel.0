Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19639C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 10:34:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A73610A3
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 10:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90A73610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AE7D1787;
	Mon, 18 Oct 2021 12:33:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AE7D1787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634553270;
	bh=Nd6zckoDq3RmG7Di8ZKnpzcjsMl5pEGgrugW2hhoj5c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dYpRPil/qyrEFRZb5baCSqd+D4LZHIh+bc9xGP4harJhRm1Mpp9/vMKI2/IBrde+H
	 SyWDDNMPykYYgz2XlfdKgh6cAlTBAmEDVTyEMAyEIE/6l+3ZlT1Qdk+ejB5srGfFSH
	 2GA0V4Ui9un5jpOlxPTePltMA1CE0P0jB6mDeyC4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C280FF80217;
	Mon, 18 Oct 2021 12:33:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 964D8F80224; Mon, 18 Oct 2021 12:33:37 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD24AF80159
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 12:33:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD24AF80159
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="SGbLdHaC"
Received: by mail-wr1-x434.google.com with SMTP id r10so40370656wra.12
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=moJQ78F9oXsWwcjsOjRc3VK50C8FMLYVsh1+aqFOWVI=;
 b=SGbLdHaCHPafWnkcsKJrt8C7uSJJKjuE1s0WSZxitXueyV10vheKPI1GlKLjamhR/h
 mzJe7a7FXuugyTVhDzqGFD5GuQghM67V3ISQDyrU8nPg/cQiSrXe3J66oFyhkHih/NF0
 BdCrNdo5R+hFb42+dri9MqiCvzR/dhNPv8Q+J4EMAb8qm7RRslzt4ax60VC8rcXsi9ge
 MC/DGjcXXBt3mjSLfYrF2HDt9weYL8Rh2SeZVHeczTZ9PyR4Si7FmCJgZGUwxVUGCVe9
 nyiMg/NnHmrPgQSEx1pL2fXo2x/kqd4BbGTYkSfhDE3Sx5hBcAx/dLpadpjASFYPGjp8
 Ku5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=moJQ78F9oXsWwcjsOjRc3VK50C8FMLYVsh1+aqFOWVI=;
 b=2Xjr6qBWF2tifB6Zkv8Ijn2jnnMIBLVW7X4EpIQR8LzSJ3iCqNR6wzIrjNLMjE6H6j
 phCtih0DKXUfkEkxwTEaMHD1d0NwzuDGt5AD7kpYXp1dI97bQGvlfAwzY3GQxxz2s6rJ
 sJDqXOj0Bv4RCivbx5Dsq9DYVje6liAvL5pc1qYRyKmIG8EuDBgvLIfWjWvqtsEwOwEk
 cm3MpqXFHDJ3LtOqeypjFop9f3/ryAV3tLSrpd1+eP8dtAMwNVGeVu/G9L0dwL4xT+cB
 RFh0qlTGDvFIlqGN4EDXC1dbZDPNFJ+jS40+r1GZrJrLPqrOJx+FMI0wfAWZJb+klEIs
 JK6A==
X-Gm-Message-State: AOAM532wXFl4g+miSQ3ofXVMoXK61iwX9TQkNrlytA4/DR14kiZzPzsu
 Aqk7ZS5AwIqqUMHxnDiioRQ=
X-Google-Smtp-Source: ABdhPJx+JeHhyFTrMDRiVtMFDM8Kd4upVKRwte0zT1MHPBh7pH9grloOuAgxFRGNtd41Is/2nY1F8g==
X-Received: by 2002:a5d:6888:: with SMTP id h8mr16880082wru.395.1634553212482; 
 Mon, 18 Oct 2021 03:33:32 -0700 (PDT)
Received: from localhost.localdomain ([195.245.16.219])
 by smtp.gmail.com with ESMTPSA id o8sm19062252wme.38.2021.10.18.03.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Oct 2021 03:33:31 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
List-Id: <soc.lore.kernel.org>
To: soc@kernel.org
Subject: [PATCH v3 0/2] arm: ep93xx: CCF conversion
Date: Mon, 18 Oct 2021 12:31:03 +0200
Message-Id: <20211018103105.146380-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Nikita Shubin <nikita.shubin@maquefel.me>,
 Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Hartley Sweeten <hsweeten@visionengravers.com>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

This series series of patches converts ep93xx to Common Clock Framework.

It consists of preparation patches to use clk_prepare_enable where it is
needed, instead of clk_enable used in ep93xx drivers prior to CCF and
a patch converting mach-ep93xx/clock.c to CCF.

Link: https://lore.kernel.org/patchwork/cover/1445563/
Link: https://lore.kernel.org/patchwork/patch/1435884/

v2->v3:
Rebased the series onto v5.15-rc5
v1->v2:
- added SoB

Alexander Sverdlin (1):
  ASoC: cirrus: i2s: Prepare clock before using it

Nikita Shubin (1):
  ep93xx: clock: convert in-place to COMMON_CLK

 arch/arm/Kconfig              |   2 +-
 arch/arm/mach-ep93xx/clock.c  | 975 +++++++++++++++++++---------------
 arch/arm/mach-ep93xx/core.c   |   2 +-
 arch/arm/mach-ep93xx/soc.h    |  42 +-
 sound/soc/cirrus/ep93xx-i2s.c |  12 +-
 5 files changed, 587 insertions(+), 446 deletions(-)

-- 
2.33.0

