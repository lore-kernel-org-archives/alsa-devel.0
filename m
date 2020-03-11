Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F729C10F27
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:38:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A872146E
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G4iRTOSY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="epXS8b68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A872146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 010F21662;
	Wed, 11 Mar 2020 12:37:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 010F21662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583926689;
	bh=1gFdenCqKi3mV1I7eiCFkSxnBKntOe4an5aiMcIWKRE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G4iRTOSY9P3zBSdEMqNy12nubf9Avf8iCe6Ad1ULJ47hx5zxjKuvFzySwHmLi+9iV
	 WgDHguR5STlrQ9BRyAi746VIB0X5K5GtTwXcWlJat/fyoMKE5vTNQF7G5U9K1H3swh
	 UQIfdPceHs0lezLyb6eqSHWn9rx9oTMBaFwKFJJk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE038F801F7;
	Wed, 11 Mar 2020 12:36:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2D86F800B5; Wed, 11 Mar 2020 12:36:24 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8744F800B5
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 12:36:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8744F800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="epXS8b68"
Received: by mail-wr1-x441.google.com with SMTP id z15so2174074wrl.1
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a3pvk8YM9KciTsoi8ZTo0J1S/sSYGSlU0IpIN/JdgKY=;
 b=epXS8b68jSfacixPIe996/Issuty7JuLN8tDTKxPy/9fL8ZoneFpxLQoKp55s/Xqrb
 yomyWspUaaoN7PPbyg3+1+dn1USNiC4R2gN3GrIlwzilyKRWugjvBFAVkFtSiLgU6c7L
 yJ2kz9qKA3wpwVLGa7ja7+b5uymfx2YuauBf/dmyNpbqkG9PhfaBYCY73QWPyuGggLKf
 VeziX3p8ojj9CZveIkORRR8MGnOfWObshMianlG0flWNvIcet9GPAkEOVnX0gdr/RSAn
 4s2g2ROl0Jdl5Bez/LDwwa1GgbUCDtDn/GoLHXic4DSOo9MSPaScEcnrEgzdTKNJhET6
 gGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a3pvk8YM9KciTsoi8ZTo0J1S/sSYGSlU0IpIN/JdgKY=;
 b=mzEGz5VVeRRc47sEtSKIyWNJ5j5rM+gNm+14BDj9siiqRYQfNlUtFniHQKy71K+IWB
 PRi2oXJs2+DdHjznUNx+DjjeTVw90YWk0JNqAFmEhkPnIBdZXtMLGhFduLY+8xn7PrAW
 kf6yWwhV5/414arVFXcxnE/K53jdDSD+0qPoqWgPwZMZqHonnjEoBVBphoYCXRFo/a95
 j8fsbYmUPnHBUF+0+SOBhN7fZNM5+tyTe2wTPqAxpHXEs50jonI+/+o9T9Hf2gbzMKrZ
 h264T2Phg87gpta6+pPliTIGMufjjsBowSA9y34oY+bkfb0O3xneCEAiea0GBH0eldkn
 JyPg==
X-Gm-Message-State: ANhLgQ2lp8mJHrwIp1+jxuEQDPj1I3SA6ir1OpG96+R+Vrcn8jWk7zB2
 BYjnzLbSSIlRG0veW0ho+XLfPQ==
X-Google-Smtp-Source: ADFU+vvu2foe5tilScyQakEbJFDrry3CKe/s1NISiVxUkngdoUCD9DWM8A/xs/ohy3NDrj2Prqhzxg==
X-Received: by 2002:a5d:6591:: with SMTP id q17mr3933045wru.22.1583926578262; 
 Wed, 11 Mar 2020 04:36:18 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id c8sm61650537wru.7.2020.03.11.04.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 04:36:17 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org,
	vkoul@kernel.org
Subject: [PATCH 0/2] soundwire: add read_only_wordlength flag
Date: Wed, 11 Mar 2020 11:35:43 +0000
Message-Id: <20200311113545.23773-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org
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

According to SoundWire Specification Version 1.2.
"A Data Port number X (in the range 0-14) which supports only one
value of WordLength may implement the WordLength field in the
DPX_BlockCtrl1 Register as Read-Only, returning the fixed value of
WordLength in response to reads."

As WSA881x interfaces in PDM mode making the only field "WordLength"
in DPX_BlockCtrl1" fixed and read-only. Behaviour of writing to this
register on WSA881x soundwire slave with Qualcomm Soundwire Controller
is throwing up an error. Not sure how other controllers deal with
writing to readonly registers, but this patch provides a way to avoid
writes to DPN_BlockCtrl1 register by providing a read_only_wordlength
flag in struct sdw_dpn_prop


Srinivas Kandagatla (2):
  soundwire: stream: Add read_only_wordlength flag to port properties
  ASoC: wsa881x: mark read_only_wordlength flag

 drivers/soundwire/stream.c    | 16 +++++++++-------
 include/linux/soundwire/sdw.h |  2 ++
 sound/soc/codecs/wsa881x.c    |  4 ++++
 3 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.21.0

