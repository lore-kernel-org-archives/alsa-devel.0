Return-Path: <SRS0=kfZ2=6Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C44C3A5A9
	for <alsa-devel@archiver.kernel.org>; Sat,  2 May 2020 19:34:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDD32071C
	for <alsa-devel@archiver.kernel.org>; Sat,  2 May 2020 19:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LOHuHVUH";
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASvk0P7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDD32071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77E0816A2;
	Sat,  2 May 2020 21:34:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77E0816A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588448094;
	bh=PpsN8tdSqqhhshK11VdrusLVzcHPVOnMSjw0sMJyzdo=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LOHuHVUHvfXI9j40i2XreC4j4PDEzTcsfOYhbxZoWTaYnCAnDRLU3UAWQJCzHtHBG
	 nMae5x/2wAAbYquJdoTX3GLi1IwS+PsG51Sk0faypAG+hQfArdVRbwlCH88rCVu6h4
	 NemQfYGaXcCppLKU3dgxrE31L3eQIgW+lcIWSkiY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15A5EF80290;
	Sat,  2 May 2020 21:33:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C506BF80291; Sat,  2 May 2020 21:33:31 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50CBFF801F7
 for <alsa-devel@alsa-project.org>; Sat,  2 May 2020 21:33:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50CBFF801F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ASvk0P7U"
Received: by mail-wr1-x436.google.com with SMTP id d15so16016378wrx.3
 for <alsa-devel@alsa-project.org>; Sat, 02 May 2020 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=RqPjJqg5XXAuzSwCC7dMIjWDW9y7al4LtNMzbGoOIIg=;
 b=ASvk0P7U/PEK45DEam3Vf8z9Q/aMeWnAwFc+T+KVby37VEGKSFaExKJiSsI5X3v8fP
 ohBS+MkuP9sUQ9K2GD+fY48I+xGnehf9FBxdGF3d2EYtR7B5SJXWaPM2H7gu3co5ikKF
 9aJEX+R9H3YuKahj5a1RQszc0mRDwcszSz6S8dOQGpu18z1ivrmgc6ctvS8Tyl4v6gOb
 ALBSVF4thLr/Na9K0RXMZTq9kZjiv6+C61gH37Tc5BIlS3oQgdNFopSMYi+dGhRJsBVL
 /kKjPoiLFjf9ain2qYAJp/lBYvSHAuFEZHP3o2ercavj7ZOSs1Rfy8b/fWkpO5WQLJUY
 Lk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=RqPjJqg5XXAuzSwCC7dMIjWDW9y7al4LtNMzbGoOIIg=;
 b=EAtafy5EIWBwAUgGcqwm4Xt3hK5ekWG1vbtLiw9fatplSNwCrM6fGmYi74BTWnG9jh
 OtulPLRhHr58vIL013XgDKAFJ1Kud5HPCdo222wGpcYFsOnwhELb+JRf3Bn11acAcaho
 l3Ol1SDceUfV9KI8z6Y7HQWGrKFvyy8E2v2S46u4ginX5EvjAropH4Heo8N7t/vk0fQV
 l2PC1ajScxhO2IJT7etbJvOLm9mtV2FtwRH80m2IC6bJbEmL5SWIvrfKDCSXZWW+A5Mc
 /Rh2TXilXpJkeLdhpxDiIxWUF7ju2S19PTk8wRzOwc5a1cMcYqgTO1HjNeKsVBiWBetH
 JAew==
X-Gm-Message-State: AGi0PuZbU4k0K4WD4TgwwLUT48vIZC6qWXgQiQvSnwFFJdQfrKtoudLW
 cFPLu6PezqdzHJME8oA/MAY/bKfZ
X-Google-Smtp-Source: APiQypI38/WiwHIqlimZx0Oj19v4vV0l3vhc06+KCN/H3GJnKuHncMReK+GPMb4ipDcbVwE4LT8Hxg==
X-Received: by 2002:adf:efcb:: with SMTP id i11mr10037083wrp.278.1588448004038; 
 Sat, 02 May 2020 12:33:24 -0700 (PDT)
Received: from localhost (108.78.124.78.rev.sfr.net. [78.124.78.108])
 by smtp.gmail.com with ESMTPSA id i1sm10298718wrx.22.2020.05.02.12.33.23
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 12:33:23 -0700 (PDT)
Date: Sat, 2 May 2020 19:33:11 +0000
From: sylvain.bertrand@gmail.com
To: alsa-devel@alsa-project.org
Subject: [PATCH] fix snd_pcm_drain() excluding SETUP state from valid states
Message-ID: <20200502193311.GA19340@freedom>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/ (2018-04-13)
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

once draining is done, the pcm enters the SETUP state, which ought to
be valid for snd_pcm_drain()

signed-off-by: Sylvain BERTRAND <sylvain.bertrand@legeek.net>
---

I missed this one in my previous patch because exiting with or without
an error once draining is done was producing the same result.

--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -1329,7 +1329,7 @@ int snd_pcm_drain(snd_pcm_t *pcm)
 		SNDMSG("PCM not set up");
 		return -EIO;
 	}
-	err = bad_pcm_state(pcm, P_STATE_RUNNABLE);
+	err = bad_pcm_state(pcm, P_STATE_RUNNABLE | P_STATE(SETUP));
 	if (err < 0)
 		return err;
 	/* lock handled in the callback */
