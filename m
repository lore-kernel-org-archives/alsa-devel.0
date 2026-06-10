Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3300CD98C7
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:32:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDA3660207;
	Thu, 11 Jun 2026 21:31:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDA3660207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781206325;
	bh=CE1nX27oBcL6Tl6vMv7Z3wZ/+naPHmaEsSzFKbyRHkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ba2AIWO2ihezp+qKuZK8Gv8MEw301GgYv9zIqpJGfZcmGCe5ZH/K0EcI6JbeNsccQ
	 SSN4CqSVM6vodxQI6cMaBVajOHeq7T1v4om0aEPdWVRSdJN6OhCRb+p6o9SSbRGr1W
	 z9Ha5Iluw789RguIg4euk3ntEgud0T1MqjJSSSQI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B87FF80640; Thu, 11 Jun 2026 21:31:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 942A6F80649;
	Thu, 11 Jun 2026 21:31:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36AA1F8057E; Wed, 10 Jun 2026 12:06:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=202.108.3.71
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781086008;
	b=QI0ZylVVR78qAPh+mPgE93eZKln7at9Q83UynHSWiPLP/Jf0lXk9dtEMbzVULTozfVmL
	 h9AWV9cEk9h77IS84a/ufJwJIWAGzYE3TsMk/MsdDRwqHwwzYkmp4hz63tXHjd/HHNQr9
	 aqjbkJ+NtoyO/VQER7GeyqgAObwwIKqHFj8EdJJMLu5riT5w1do0bZlBsICWqTdU9VW7o
	 5qikjDpc8oP9BCQ6X8WIIcAvBs6LGeFQa6SBfLf0Xd4maAmjqPOEEzDcdVSNFpUcz58tv
	 fIZd+PzipM2vv1hr/iTuzVVzqpA2Fl5NUyc4RDzMiTLWGPnDinG9LKkDuY1hIWQhSsQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781086008;
	h=From:To:Subject:Date:Message-Id;
	bh=CE1nX27oBcL6Tl6vMv7Z3wZ/+naPHmaEsSzFKbyRHkY=;
	b=rueCUMUCBmjOKUsb4W1cPiDmxp+iR4K89MJnmgqt0EQU2ME2lsn6GMKxQ5NtYojC9Gtj
	 pG0zoYnPGuKiTenL5Yuc3ptScI+6sTonBMQjW1LHtqIdZCvjg4Kgr4DZEHZHRgxnlITdi
	 rk5yeosVg8linN5I4ZIUOVrndMObDx5eXu9dZUJ64BZmdztxiQUq/Pa12YPeQ4FLCorFO
	 cwdgZYe2XEozqOPC+VnyDBBXkzZ5cuEVFkmUuuNZRZgcRJiRoSmqM2iWZxo6bSVhRLEwb
	 CWnkQ/rvX7kOZkh7vZJZmHhjIX1IE8MLMZCiBCT+ALNGsASVWZv4BU7JFNI6LuHEheQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=202.108.3.71
Received: from r3-71.sinamail.sina.com.cn (r3-71.sinamail.sina.com.cn
 [202.108.3.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1F9FF8057E
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 12:06:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1F9FF8057E
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.94])
	by sina.net (10.54.253.39) with ESMTP
	id 6A29372F00006380; Wed, 10 Jun 2026 18:06:40 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: EE711B62DD7844089AB2C86FCA8A4203
X-SMAIL-UIID: EE711B62DD7844089AB2C86FCA8A4203-20260610-180640
From: Zhang Yi <zhangyi@everest-semi.com>
To: krzk@kernel.org
Cc: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	tiwai@suse.com,
	zhangyi@everest-semi.com
Subject: RE: [PATCH 2/7] ASoC: codecs: ES8389: Fix the issue about mclk_src
Date: Wed, 10 Jun 2026 18:06:37 +0800
Message-Id: <20260610100637.25568-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260609-visionary-truthful-viper-ceff75@quoll>
References: <20260609-visionary-truthful-viper-ceff75@quoll>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: EOBJFOUYPHO7V7KRRBECN2HNGTIBB5UX
X-Message-ID-Hash: EOBJFOUYPHO7V7KRRBECN2HNGTIBB5UX
X-Mailman-Approved-At: Thu, 11 Jun 2026 19:31:04 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EOBJFOUYPHO7V7KRRBECN2HNGTIBB5UX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> > Fix the issue with incorrect modifications to mclk_src
> 
> What issue? Your commit msgs are really poor - explain nothing. You just
> duplicated subject... and anything can be a fix.

I'm sorry I didn't explain that clearly.
When the system needs to be configured to use the MCLK from the SCLK pin,
the old code still sets the relevant registers to use the MCLK from the MCLK pin.
I will include a more detailed description in future versions.

> >  	struct es8389_private *es8389 = snd_soc_component_get_drvdata(component);
> >  
> > -	ret = device_property_read_u8(component->dev, "everest,mclk-src", &es8389->mclk_src);
> 
> Why are you changing implemented ABI?

In the old ABI, `mclk_src` was defined as `u8`, which meant that users could set `mclk_src` to any value in the DTS¡ªsuch as `0x02`,
but the code wouldn't recognize what that value represented.
The actual purpose of `mclk_src` is to indicate whether `sclk` should be used as `mclk`.
So I've changed it to bool.

