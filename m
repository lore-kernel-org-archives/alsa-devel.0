Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46D7C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Apr 2022 20:09:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31FEC18E6;
	Tue, 19 Apr 2022 22:08:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31FEC18E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650398983;
	bh=hizN9YHSOxDKeuvnQmX2H/BfHirBjFToHdzGV5YL3AA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cp659RtbMm9apFo6hc6yJDDPISvkEM8v/XFSAeftmtGbPFevdsAstn86V/7Fsg49U
	 4T4YFft2Z8Gjzo9qxghc9jKCGVwLMz/s1mk2BT/X0RRZ6lHRxpH6Ptai35peOTI5bo
	 GZe7Jm1UbcEz0KkTIXTwh7EGUrUpCIHC560L9IDw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB420F80237;
	Tue, 19 Apr 2022 22:08:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 330DBF8025D; Tue, 19 Apr 2022 22:08:51 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B132BF800C1
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2022 22:08:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B132BF800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1650398927295574903-webhooks-bot@alsa-project.org>
References: <1650398927295574903-webhooks-bot@alsa-project.org>
Subject: cplay.c:153: bad expression ?
Message-Id: <20220419200851.330DBF8025D@alsa1.perex.cz>
Date: Tue, 19 Apr 2022 22:08:51 +0200 (CEST)
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

alsa-project/tinycompress issue #13 was opened from dcb314:

I just tried to compile tinycompress with the new C compiler clang-14.
It said:

cplay.c:153:34: warning: & has lower precedence than !=; != will be evaluated first [-Wparentheses]

Source code is

   if ((buf[0] != 0xff) || (buf[1] & 0xf0 != 0xf0))

Suggest new code:

   if ((buf[0] != 0xff) || ((buf[1] & 0xf0) != 0xf0))

Issue URL     : https://github.com/alsa-project/tinycompress/issues/13
Repository URL: https://github.com/alsa-project/tinycompress
