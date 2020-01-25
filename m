Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73518C2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:14:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC89214D8
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QqpzC1rt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vO1eRh0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC89214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BD9B14E;
	Mon, 27 Jan 2020 17:13:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BD9B14E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580141655;
	bh=Or72xMR37GQspRQqu46EYexFmCxEjLBebE3OxtoMuBQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QqpzC1rt74kRAzv2ZEa0CaOqspxbgOafiQnMYh27iCU+cRNSYXL3lJmVlCFLgFIRk
	 sIXzPu+WUkksocEubgm3r0eZEJo6njxXG+YFGHsHWFmUEVefC8eMiWuwPKCWlrCzyL
	 V7XLz9o5oTL3OF3g8RJ+ojSPsCqyvX4KT4pSxJWE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91B4EF80218;
	Mon, 27 Jan 2020 17:13:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 228EDF801EC; Sat, 25 Jan 2020 23:30:26 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2F71F800F5
 for <alsa-devel@alsa-project.org>; Sat, 25 Jan 2020 23:30:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2F71F800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="vO1eRh0Z"
Received: by mail-wr1-x435.google.com with SMTP id g17so6477217wro.2
 for <alsa-devel@alsa-project.org>; Sat, 25 Jan 2020 14:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kdeGZfjzOnp+Rivb5GV5oGjn21guFI9NAcOcGv3+FBQ=;
 b=vO1eRh0ZiTdSTWGY3WzjGGri5SuiCxWFD2nf/ZvQnInMohVTNbmmeY14ahzxbeQBOF
 m/DZTQ/pBei4PWUimr4ITVEhLPWamxM9pw5/sBmovlCHaPBgZwGXnGuK8IU3B1u3dwtZ
 9WWBiI/3tqJZN57qGW3fy3BtCVTmgs3nDUSF5jUhWtedB19juMv53hw46tuae2AXhk7h
 PG6yzsBUGJhGC7cVO3ZNmi2JE8GCYoUpC3RqMLh4IYaCQdvxrMS8rEA/B4sA9hyjsL66
 wO9JO7Bc36FsnrHIbYuBu93s5tfvKihXQtpbelHAowTn3u0h10JaGBhf5UH6dYz8sc4L
 e0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kdeGZfjzOnp+Rivb5GV5oGjn21guFI9NAcOcGv3+FBQ=;
 b=I8sBDOkiFigiBjFwFS/1KG72IB6AaIVSjdtslbIUqHjXf8w3Eln48gNKb90auxMB5m
 pfNj7jftwCmpjJy8Zw5cfBuy2H3IYyIxKx6STX7DYsXeR+EgMCrXJHc6GrRShdGg7DgN
 NUZsxRGCxOPUq0iVs9g50q2kDw9q96+EM7cV8cJMPMRoXlMupm3vHTDmsF8kdnyv1BB3
 gWzxsVKRM8ok1vMX56W+Vey8pnQTxsM4DwGwOM2JoHZBAHhuaSJoM8ZXLGz1oYGVwaGe
 oLKgLmje41GrJOA6lofyAiZemcVl49+bNLvV8kUBPew59Pre2XapXPe8FoPfPhf/nG7i
 4SJQ==
X-Gm-Message-State: APjAAAWvNBDcdnQY/2PpCprRrYn3hQigDjvYbDMnsqAkdET98m6rltJv
 6H+7KFtim6+Fq4lSMfTP7uhOFqdzS4w=
X-Google-Smtp-Source: APXvYqzncD4CIBJ+OAE+TNePraIPQjePt+5kRODu2inpQAd66Nspsf4xfYYuvl8gvP0IWAqpbUj3og==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr12814142wrv.302.1579991421221; 
 Sat, 25 Jan 2020 14:30:21 -0800 (PST)
Received: from schmakbook.localnet (static-213-235-187-91.ktkadan.cz.
 [213.235.187.91])
 by smtp.gmail.com with ESMTPSA id g18sm11926082wmh.48.2020.01.25.14.30.20
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2020 14:30:20 -0800 (PST)
From: Roman =?utf-8?B?xaBtYWthbA==?= <schmakerisko@gmail.com>
To: alsa-devel@alsa-project.org
Date: Sat, 25 Jan 2020 23:30:32 +0100
Message-ID: <2520086.mvXUDI8C0e@schmakbook>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 27 Jan 2020 17:13:22 +0100
Subject: [alsa-devel] [CX2075] No sound after suspend/resume from front
	speaker
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

this still seem to be an issue. After startup everything works well until the 
laptop goes to suspend.

Tried pretty much everything basic user can do (unmutes, rmmods and so on), 
still no way to wake the output. ALSA seems to be thinking, that output is 
active, you can set volume and stuff, but nothing happens.

ALSA info:
http://alsa-project.org/db/?f=9d1ee81fe037acb53ca381f2de27be420f83a373

Related links:
https://www.reddit.com/r/archlinux/comments/4nwzua/
no_sound_after_suspend_killing_or_restarting/
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1612916
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=851404

Regards

Roman


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
