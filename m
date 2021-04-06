Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88942C43461
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 10:51:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDF5613C6
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 10:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDF5613C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aksignal.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DEC982E;
	Tue,  6 Apr 2021 12:50:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DEC982E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617706279;
	bh=Es88WWcD5Q2zE95rq3vvLPfdn+SKGzeYIko/RTCxKMk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p4lHCKyfDbmLb5HQBAPOeNZgJUqGIdMafz7Ehtv93zM1BgcS3z6gPCF9BjjoqozDm
	 R7gpEvfEzlVPd4AfceRcBJX+Qk2hJ9FSD8uBziiBd5XXrIRwqc3R2A7OyPFrtpAYQG
	 BX9K2tj+E9Pi/GXuZNxxUW6l9Hyi1w/LQGm93ppQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C70E8F80258;
	Tue,  6 Apr 2021 12:50:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32696F80259; Tue,  6 Apr 2021 12:50:27 +0200 (CEST)
Received: from router.aksignal.cz (router.aksignal.cz [62.44.4.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17CD1F800E1
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 12:50:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17CD1F800E1
Received: from localhost (localhost [127.0.0.1])
 by router.aksignal.cz (Postfix) with ESMTP id 043743FA31;
 Tue,  6 Apr 2021 12:50:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at router.aksignal.cz
Received: from router.aksignal.cz ([127.0.0.1])
 by localhost (router.aksignal.cz [127.0.0.1]) (amavisd-new, port 10026)
 with LMTP id 86KLOr3Xijov; Tue,  6 Apr 2021 12:50:22 +0200 (CEST)
Received: from pc-gameroom.prchals.tk (unknown [83.240.30.185])
 (Authenticated sender: jiri.prchal@aksignal.cz)
 by router.aksignal.cz (Postfix) with ESMTPSA id 59C4A3FA29;
 Tue,  6 Apr 2021 12:50:22 +0200 (CEST)
From: Jiri Prchal <jiri.prchal@aksignal.cz>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] SOC Codecs: TLV320AIC3X add SPI support
Date: Tue,  6 Apr 2021 12:50:13 +0200
Message-Id: <20210406105018.59463-1-jiri.prchal@aksignal.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Jiri Prchal <jiri.prchal@aksignal.cz>, Liam Girdwood <lgirdwood@gmail.com>
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

This patches add support of SPI to TLV320AIC3X codecs.

Jiri Prchal (5):
  SOC Codecs: TLV320AIC3X add SPI: move thinks to header file
  SOC Codecs: TLV320AIC3X add SPI: main source code for I2C and SPI
  SOC Codecs: TLV320AIC3X add SPI: I2C code
  SOC Codecs: TLV320AIC3X add SPI: SPI code
  SOC Codecs: TLV320AIC3X add SPI: configuration and compile

 sound/soc/codecs/Kconfig           |  11 +++
 sound/soc/codecs/Makefile          |   4 ++
 sound/soc/codecs/tlv320aic3x-i2c.c |  72 ++++++++++++++++++++
 sound/soc/codecs/tlv320aic3x-spi.c |  77 +++++++++++++++++++++
 sound/soc/codecs/tlv320aic3x.c     | 105 ++++++++---------------------
 sound/soc/codecs/tlv320aic3x.h     |  13 ++++
 6 files changed, 204 insertions(+), 78 deletions(-)
 create mode 100644 sound/soc/codecs/tlv320aic3x-i2c.c
 create mode 100644 sound/soc/codecs/tlv320aic3x-spi.c

-- 
2.25.1

