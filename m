Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90A1C636D4
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Feb 2023 01:09:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C64CC82E;
	Thu, 16 Feb 2023 02:08:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C64CC82E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676509776;
	bh=VzkuGBenM2ZbuWtV2wWe5AFHTEefw4I6oPYGAPjwBHo=;
	h=Date:From:To:Subject:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Cuk1NxYHwzilz5/VcBk38yYaBZ/axtDTy5ERMQN+WTDcZqMA9J+EgHkTj64DWSwMz
	 qRO+UJc/kruIF9Q5vhYbwdo6ZKescyYGC0pw0ygEI8k0ZL+RNl5fZK6mQuVTPYcV71
	 n1jLoGoLjnibuC/2a3UUgWp6qe9pWsndSVyh8gPw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 259ADF80171;
	Thu, 16 Feb 2023 02:08:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 97A52F80171; Thu, 16 Feb 2023 02:08:18 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BE2C7F800E3
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2023 02:08:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE2C7F800E3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=HfP3JDL3
Received: by mail-ej1-x629.google.com with SMTP id he33so1383167ejc.11
        for <alsa-devel@alsa-project.org>;
 Wed, 15 Feb 2023 17:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dpuTSv6lGJhmoxF+pMAKZTefirNRzuGsDlz8YcNTEQo=;
        b=HfP3JDL3SQ+gEasoZWi1fUtvDegW8xjV6i7oha9uvRtULaT4hjuzvATJ9WBILQHPTC
         bfUV6skkaMj5D1/M3YmgmtNRb4VOZ+gDBdtpNGMFX6L0Pjr1xH90rO83RkvVSpncOJlM
         d6M8kgsRadnrsnCFdlksx/DhiTQRwNgHg303Ny6en8aSMK7jbAGgE/pVRBlFeCRS+U32
         qmLzd2Kxy4RMsPW8TDHhpb+6kNwFo3DDT3FkRKczIPkLqxquAUK2V1o6LlzXtLftr+GX
         WMdbmVpt1cRkrfTNs6taFrfKevZP3BgVEWdtuMU8aITPB3teuTFZkVyr2igCeB+ZnJ66
         McgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpuTSv6lGJhmoxF+pMAKZTefirNRzuGsDlz8YcNTEQo=;
        b=A24vHfJ8LPkMDGiO7ZoKmqq82RokrXj9ip6bKMTAniek5B5KbQuiu5x5lWqYoBTfNq
         FQ3fmQO54UK9Z0Sjdrx83e2ClqW7dmlX3tcnfbgDv0dDywZFTodF/DTff4Md8me+9Dg0
         T4inZAkaetQx+zDGyfg1VQfL7B4VMC7TbqBIH1hmTvBTwghloDjODlTtvOA7zVaNu7ej
         qgw3UEXOO24pezpaRUNDEy+AqDLhzv2DgPiRUK/XUSry4mUUM1SoH7cedHa9OPXhH9iS
         VYF6Ps1dKzGYqnENC85Dl5b0NdE64UzdM26xq3jwEWWJQn/b0nD47p9Juz0adIg8wn3f
         +rvA==
X-Gm-Message-State: AO0yUKWBrb03Ne/yCSvqBkhZypTXvcG0VU1JCrSp0I9uY/H5vrdqmqP2
	PdHXvx/1zGhRYmq8hD0bIeN/Z1rRbkcdZuC9
X-Google-Smtp-Source: 
 AK7set88eMzGkiWFPjTHSXW2Cs8F0hUlY50a7KiBEH3A0/zwerUlHh2Rc7WM1l1XcYKtkQabWz/vTA==
X-Received: by 2002:a17:906:6807:b0:8af:4684:91cf with SMTP id
 k7-20020a170906680700b008af468491cfmr4306444ejr.32.1676509693514;
        Wed, 15 Feb 2023 17:08:13 -0800 (PST)
Received: from smurf (80.71.142.58.ipv4.parknet.dk. [80.71.142.58])
        by smtp.gmail.com with ESMTPSA id
 t6-20020a1709066bc600b008b159612b2dsm84098ejs.106.2023.02.15.17.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 17:08:13 -0800 (PST)
Date: Thu, 16 Feb 2023 02:07:51 +0100 (CET)
From: Jesper Juhl <jesperjuhl76@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [Patch] [cs42l42] Remove unneeded version.h include pointed out by
 'make versioncheck'
Message-ID: <83e0ba99-6be6-ede5-08ce-b37aae1fd9c9@gmail.com>
User-Agent: Alpine 2.26 (LNX 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Message-ID-Hash: ENUL37BQTS65C2JDBQYK2BTPYAGLAAH5
X-Message-ID-Hash: ENUL37BQTS65C2JDBQYK2BTPYAGLAAH5
X-MailFrom: jesperjuhl76@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Lucas Tanure <tanureal@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ENUL37BQTS65C2JDBQYK2BTPYAGLAAH5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

>From 80dd7af06ef675c183bc7faedc474e5cdda295cb Mon 
Sep 17 00:00:00 2001
From: Jesper Juhl <jesperjuhl76@gmail.com>
Date: Mon, 13 Feb 2023 02:54:45 +0100
Subject: [PATCH 08/12] [cs42l42] Remove unneeded version.h include pointed out
  by 'make versioncheck'

Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
---
  sound/soc/codecs/cs42l42.c | 1 -
  1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2fefbcf7bd13..ba8c81b6ac87 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -11,7 +11,6 @@

  #include <linux/module.h>
  #include <linux/moduleparam.h>
-#include <linux/version.h>
  #include <linux/types.h>
  #include <linux/init.h>
  #include <linux/delay.h>
-- 
2.39.2

