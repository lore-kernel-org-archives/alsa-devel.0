Return-Path: <SRS0=Dyxj=JK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AAFC43460
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 11:19:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0F361249
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 11:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0F361249
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AE071661;
	Tue, 13 Apr 2021 13:18:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AE071661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618312746;
	bh=Ggg5vMGda2O56aVM8b+hLFP0AcDRptk3Jnagnq4XULI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H0ysM88Did6qDU65A9b6h+ND8RZ5usEABlU05QU5yVJ8dtYXERtc62OOuPGso9BIv
	 eedwV+sG5rznnf8p62Ckv7mnVJY0T8Yj/PVWt6jgWmMaKb6+TI+C3g6HpHCDoDu3ti
	 2FocoyK3lYttN/BZvKVx26I41xAdbYep9/ap3Hy4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB3F9F8023A;
	Tue, 13 Apr 2021 13:17:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1CE0CF80254; Tue, 13 Apr 2021 13:17:51 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 72315F8022D
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 13:17:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72315F8022D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1618312664145020962-webhooks-bot@alsa-project.org>
References: <1618312664145020962-webhooks-bot@alsa-project.org>
Subject: rockchip/veyron sound level issues
Message-Id: <20210413111751.1CE0CF80254@alsa1.perex.cz>
Date: Tue, 13 Apr 2021 13:17:51 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #87 was opened from kapouer:

Hi,

setup:
> asus c201 (speedy veyron)
> linux 5.10.28 or 5.11.13
> debian bullseye: alsa 1.2.4, asa-ucm-conf (and topology) installed, pulseaudio 14.2, gnome 3.38 on wayland

what works:
- jack input/output using headset

problems:
- speaker output is somewhat low even at 100% (feels like 50%)
- microphone is so low that it cannot detect sound (smashing the mic hole with a stick is detected but barely audible)
- last time i checked hdmi was working - i need to check again though

What can i provide ?
pulseaudio -vvvvvv ?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/87
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
