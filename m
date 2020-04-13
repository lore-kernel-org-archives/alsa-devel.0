Return-Path: <SRS0=SID+=55=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A4C2BA19
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 13:21:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85A720692
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 13:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FvyoInL2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNsluRYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85A720692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 264111683;
	Mon, 13 Apr 2020 15:20:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 264111683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586784073;
	bh=42WztIr6R30dA6F3hp6MVExZJVyltDeOz3d1QcD2UqI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FvyoInL2a6K5I/nwQ/YiOzdd4hL4+MsETrYETBF19PSh2e5pzjXLr0psqwz1qtcpN
	 bm5+/j0T9N5S7I3iBdpDes5mVz4xL1FuFK12D7uSkjCw95fot5HzHC8gITuLIotq7g
	 6RhJ4Oyg3/ex8cy6YlAm3SiGL7ZtYSMgI4fCMfnk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90FB4F80229;
	Mon, 13 Apr 2020 15:20:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49FB6F80245; Mon, 13 Apr 2020 15:20:21 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5747EF80115
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2020 15:20:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5747EF80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="fNsluRYx"
Received: by mail-pj1-x102c.google.com with SMTP id z9so3783104pjd.2
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2020 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=42WztIr6R30dA6F3hp6MVExZJVyltDeOz3d1QcD2UqI=;
 b=fNsluRYx8B/Zi7UNGpOjdk8QRaB8nrRHPUrlbE7pS1K3LknjuhEswspy5m1TTgRWUB
 rhe7WrpUucGf43pOeCAdCiWdOc/bxHNCpQ9G44KLfly6JWRiB8Wm9uSvkKSPa4ydQjye
 zRqzCm9ovRPZDq1+B59eKU0CvEMqB67H8D2ZFKaox2OY4ndA2WFVNKYaVaY3EFB5gtTV
 uqxmZwIafgyHT2IzASoiLT+OipnybimacdXWcLw8d/Iw90099DOpcwHENU9em3MqcX8n
 CyqO9eV2bs6RnVJEo/YdSZ6EQLXdnr78Ggwrl+P4Bfb5oY6BqntadITn0QvD2aXLA0DS
 w2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=42WztIr6R30dA6F3hp6MVExZJVyltDeOz3d1QcD2UqI=;
 b=DPyTdnhhkvafHa/U7N0uDTEuH7JWqjXydNzA4Kbh72Ul38PUqhWH5nHuS2Q+qGAlZN
 /KbGTZWabpqXUz41HKnssbuAL2l0RXTBN6dxs4hAfC46K7M38nlOBCw3384zLeu2GTth
 JZYFVZLN5SyKaYt1Q4Q3yf9qc5cl7GSw0WNGlbreU4eDaK7SurvpPX4xUCB3Dwx7EKXO
 rvb8Tcyd+WyXz6NtR+tF28bad8wZPKX+Si1lv5XA3p7hX2jAR+PCPRaAGKSxeRUkuhkF
 rsGLT1BjP12tTLG/DHgR5c28E0nv6JHNDS33wtSP1TjgrpIKtju/DLpBHcMXEOrbGLLX
 25jg==
X-Gm-Message-State: AGi0PuaC+wZOvsmywyAZTAEctv2nulMW4DhWW+ZvvcZmKhxcVSIfjaoA
 ku+StkIYxQMCk0xkGl6exMk=
X-Google-Smtp-Source: APiQypLq6aekSwJlMZ2ldIIhZQmGOLiqvjs3bwzPOl7QTiDZfeyQ5/loXS+xW0TuLBMRnad8iHM8qw==
X-Received: by 2002:a17:90a:aa95:: with SMTP id
 l21mr21956148pjq.4.1586784013270; 
 Mon, 13 Apr 2020 06:20:13 -0700 (PDT)
Received: from localhost.localdomain
 ([2408:821a:3c17:4dc0:450e:c0f5:953f:5e47])
 by smtp.gmail.com with ESMTPSA id g11sm8542942pfm.4.2020.04.13.06.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 06:20:12 -0700 (PDT)
From: youling257 <youling257@gmail.com>
To: hdegoede@redhat.com
Subject: Re: [4/5] chtrt5645: Remove bogus JackHWMute settings
Date: Mon, 13 Apr 2020 21:19:49 +0800
Message-Id: <20200413131949.12341-1-youling257@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200405183454.34515-4-hdegoede@redhat.com>
References: <20200405183454.34515-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, youling257 <youling257@gmail.com>
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

please also remove es8316 HeadPhones.conf JackHWMute "Speaker"
