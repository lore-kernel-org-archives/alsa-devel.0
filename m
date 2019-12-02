Return-Path: <SRS0=OACP=ZY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C36C432C0
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:49:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A550F20665
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XMExz576";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Qa0+r9Xi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Qa0+r9Xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A550F20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFD22886;
	Mon,  2 Dec 2019 18:48:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFD22886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575308978;
	bh=6TvHwaOUiq2steXep3JyWNF5+MeNuSyPkBEBmtvkmeE=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XMExz57686TjlXvN7kM2nvGzA1a+Y2jUgSs6ckROy5wBkTwfRWN904QafGecEljgi
	 AQ6478N9W5FQB+mu4fviJZLDfDPHBjZegGPcMX5RrpDijLKUZsEfDH8/YYoQNI8C28
	 XMGMHI1Nit5yFD6odjhl+XZT7+srCF91IqP0FDFQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DC29F80214;
	Mon,  2 Dec 2019 18:48:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A26BBF80216; Mon,  2 Dec 2019 18:48:45 +0100 (CET)
Received: from node.akkea.ca (node.akkea.ca [192.155.83.177])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA2E9F800B4
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2019 18:48:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA2E9F800B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca
 header.b="Qa0+r9Xi"; 
 dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca
 header.b="Qa0+r9Xi"
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id D24274E200E;
 Mon,  2 Dec 2019 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1575308920; bh=qfKdNZ1HBtViTTD5XHaCa9z4hvXMR4eI/MrZct97QqY=;
 h=From:To:Cc:Subject:Date;
 b=Qa0+r9XiQhfbN0jBdjUEoNVNnhYSz41LKL/xNHwYfsxcZHN7V4F5B3vsUAacwh+ns
 nADerYPHg1nVDYeHK8NLSEVFX/H4TDgEtEYWQUpqXIxxQrCRxmwki0NlCRTVZvjzVy
 sOjekbkH75Cp9Ge7px6MdRYZg+ozDIJftgaFfPG8=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JuvcBJccax_v; Mon,  2 Dec 2019 17:48:40 +0000 (UTC)
Received: from thinkpad-tablet.cg.shawcable.net
 (S0106905851b613e9.cg.shawcable.net [70.77.244.40])
 by node.akkea.ca (Postfix) with ESMTPSA id 825844E2003;
 Mon,  2 Dec 2019 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1575308920; bh=qfKdNZ1HBtViTTD5XHaCa9z4hvXMR4eI/MrZct97QqY=;
 h=From:To:Cc:Subject:Date;
 b=Qa0+r9XiQhfbN0jBdjUEoNVNnhYSz41LKL/xNHwYfsxcZHN7V4F5B3vsUAacwh+ns
 nADerYPHg1nVDYeHK8NLSEVFX/H4TDgEtEYWQUpqXIxxQrCRxmwki0NlCRTVZvjzVy
 sOjekbkH75Cp9Ge7px6MdRYZg+ozDIJftgaFfPG8=
From: "Angus Ainslie (Purism)" <angus@akkea.ca>
To: kernel@puri.sm
Date: Mon,  2 Dec 2019 10:48:29 -0700
Message-Id: <20191202174831.13638-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Angus Ainslie \(Purism\)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Enrico Weigelt <info@metux.net>, Allison Randal <allison@lohutok.net>
Subject: [alsa-devel] [PATCH 0/2] Add the broadmobi BM818
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

The broadmobi uses slightly different parameters from the option modems
so add the paramters and document them.

Angus Ainslie (Purism) (2):
  sound: codecs: gtm601: add Broadmobi bm818 sound profile
  ASoC: gtm601: add the broadmobi interface

 .../devicetree/bindings/sound/gtm601.txt      | 10 +++++--
 sound/soc/codecs/gtm601.c                     | 29 +++++++++++++++++--
 2 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
