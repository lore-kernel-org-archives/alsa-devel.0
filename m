Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B3FC47258
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Jan 2024 10:14:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01017828;
	Sat, 20 Jan 2024 11:14:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01017828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705745673;
	bh=/krV6aWWI3FCp6xnjnF72P0DTiI1NILo+yN8/M/gXIY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CEoUw3mYBXiXYPgUIr0qgFhoVyE86Yqdzsgv+XlpMBWYvl8Uil1e12nhxzpDjBkyk
	 jLLE2oYksdj/CSNBVSu+j9QrS2hbG/gDGZwPevlaA+z0UrixNZRB+cYoncEAU7Nwzj
	 PZ4F98usYTdjKWshNhDZ7AwJ7UDh4bjj0gLS/YBg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BDDFF8057A; Sat, 20 Jan 2024 11:14:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 629B4F8028D;
	Sat, 20 Jan 2024 11:13:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44670F80236; Sat, 20 Jan 2024 11:12:57 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 751C7F80074
	for <alsa-devel@alsa-project.org>; Sat, 20 Jan 2024 11:12:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 751C7F80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=DenN433m
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7bf5829c697so58748739f.1
        for <alsa-devel@alsa-project.org>;
 Sat, 20 Jan 2024 02:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705745567; x=1706350367;
 darn=alsa-project.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsRPvPfkSHmNHXxX0AefxialhUR4N9X5SSRuo9S1y70=;
        b=DenN433mgi3JPTlInB+8U2jsF2az0TKLt70RbKBIlRunDXAtPLdTK8C5XB9pu5WwXn
         GxdrE4vG09U/2fvK2NiTUTZI7RU8yylPMuOV1HxnQUNaFEi8HpEAxkM6To6D3U1vM49X
         /2gfgbckw57ORzymdsAEGoVsC3P1zW7YUiqR+W01FdJYKYbxiYQAWA+RuRMoc3KsYl2s
         /5rnAuQ2BrL+cKZkBrhmr1cLqytziqNH0LPXXb8vYXC95UdP8UjtbLxMkZXV80rM+qX/
         ow4hrQwCi4q6wBcdkM9BnXBSrWAYhz1dcku+WrzfQ5Q6ERhso5F6hhlkNTdmWTzeafh1
         6i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705745567; x=1706350367;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsRPvPfkSHmNHXxX0AefxialhUR4N9X5SSRuo9S1y70=;
        b=XptwmpJKlzbS236Vcja56qykj9Y/7kwWS7VrSgeFqW980o7CDGiivcBleMtEi6hSCs
         k52o30IpX8Exa5h5NDkFGu6T/VJ7XKYkjL69cmG8XRMCrVB7GxLQyayKnJyyqfNvp8W+
         d8MIY9jgMu5O3YmmO8dNVIhiCJ/9JleZbmJmbzvjcyOiW2oXHSKyO6raTrFoIHAyT8pX
         xa11mAJXJXZxNDgtjP+2tqWV4PGjJWPEwX0M10oVC0q4VppwJTmprUf5EN572kGFolj4
         aHjKl9NHILHDdh8jJIg4ntWcaDppOAu502EcvYBvaVUS2h6WKM7TYkqpjNddO5SBgDJa
         4XFw==
X-Gm-Message-State: AOJu0Yy2VuIi+/C/YTQe6HKB7uJbejmT9C8ndxd/GLdHEZs1iywrZZp5
	UvNdq58F/v+qacI3iEZ01cibg4Sg0bGp2GDerGmzK72cvAjBCqsfdUkXe20tA+n/rA==
X-Google-Smtp-Source: 
 AGHT+IEEywrUgGmOcfKRVdmj1de63o9VoHetIf7skVFVf36WaXMx5iyPxaDEmuTczabiT6Du6KBVow==
X-Received: by 2002:a92:4a09:0:b0:361:a9dc:675 with SMTP id
 m9-20020a924a09000000b00361a9dc0675mr1493417ilf.60.1705745566733;
        Sat, 20 Jan 2024 02:12:46 -0800 (PST)
Received: from zy-virtual-machine.localdomain ([222.70.13.170])
        by smtp.gmail.com with ESMTPSA id
 jc17-20020a17090325d100b001d72cf69508sm967365plb.23.2024.01.20.02.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 02:12:46 -0800 (PST)
From: Zhu Ning <zhuning0077@gmail.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com,
	zhangyi@everest-semi.com,
	Zhu Ning <zhuning0077@gmail.com>
Subject: [PATCH v1 0/5] ASoC: codecs: fix ES8326 performance and pop noise
Date: Sat, 20 Jan 2024 18:12:35 +0800
Message-Id: <20240120101240.12496-1-zhuning0077@gmail.com>
X-Mailer: git-send-email 2.17.1
Message-ID-Hash: 33CO76KDS46ZNCXMOXNEU4YSYGLB45UD
X-Message-ID-Hash: 33CO76KDS46ZNCXMOXNEU4YSYGLB45UD
X-MailFrom: zhuning0077@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/33CO76KDS46ZNCXMOXNEU4YSYGLB45UD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi ,

    5 patches here for the es8326 driver...
    
    We get some issues regarding crosstalk, THD+N performance and pop 
    noise from customer's project.
    Five patches are used to fix these issues. We did tests with the new 
    driver. The test results form test department met our expectations.
    We fixed the AUTO BUILD TEST ERROR and modified the kcontrol for HP_VOL
    in the new version of the same patch. 

    Thanks,
    Michael.

Zhu Ning (5):
  ASoC: codecs: ES8326: improving crosstalk performance
  ASoC: codecs: ES8326: Improving the THD+N performance
  ASoC: codecs: ES8326: Adding new volume kcontrols
  ASoC: codecs: ES8326: Minimize the pop noise on headphone
  ASoC: codecs: ES8326: fix the capture noise issue

 sound/soc/codecs/es8326.c | 274 +++++++++++++++++++++++++++++++-------
 sound/soc/codecs/es8326.h |   8 +-
 2 files changed, 232 insertions(+), 50 deletions(-)

-- 
2.17.1

