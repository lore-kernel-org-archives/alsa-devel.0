Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B947606A31C
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=HVogYEkG
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19B8760200;
	Tue, 10 Nov 2026 06:50:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19B8760200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794289834;
	bh=DlpskJK760CFPDbnNgDSl4C8lfXCLCoviGeQhbDPRiw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=HVogYEkGXfpdWIduGo+zhKiOX4G9kRdjtErbnt5nl0KM4rMBlUaKoKbp7m9vx1R0j
	 t9dhE/kvtarK8WjSvxUfjsES1xaiT6FElxsorBnguronDbayU/SV106VqZIXuruQfb
	 X++zDlRmck6/6MjniHjn8GAHCKRX3vbnaHfX7csc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1EC73F805FF; Tue, 10 Nov 2026 06:49:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5EE45F805F1;
	Tue, 10 Nov 2026 06:49:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48834F80525; Tue, 10 Nov 2026 06:49:52 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794289790;
	b=lfCw/JTLpVfYPH913a/vqYFijT9Vf1J6F1EVMfEi8i3BJcTVV86agfhvE1VCVOcLuDBs
	 hNvEzjiiGXB64yb7lbW6TmI23bI+Na0SNBlLKneOrNpjF2TXOLLZjyWzD1lmg9WjHoy2I
	 PEdLbHAl7Uh4Hiu2s2vpYjVGmRDiG8z5lPAJwnnciNyJz1ZgMB2/9m6MlKbDUXpddUS4K
	 f4tVQ2/H+uUYKs+IpgwmWaWo0tqbJdTLqbJls7SNr9wivp7CPwshQf9zt6siW1PzRcfaH
	 nFjomMxly9HCz5hAwgja3++yk85dPw7Ph5tdBEZkPUvgcnXPelg/9+cYYnUWhYcByoQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794289790;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=DlpskJK760CFPDbnNgDSl4C8lfXCLCoviGeQhbDPRiw=;
	b=RvadFKy6pJlWpzh0ubzdRFAjKtsaBvTGJDbg6IEKLGBpmHXobLweOfp3b+KLRHhrQag5
	 +jdWw6i1c/n6nrkOZ5YH6o/4j1GmeXcnqe873OLl/uWhrmZgPXuhM9R2D0Y0z2lHHdTqd
	 qbJnQZi4yaTksgEe4FdDw6ORPCDIBo7N5xEebe3S4aFhmkDuf+Kvg9xAHwstNKog0g2cO
	 C0mE9k+ohtzYoF64m0rUTFB7NR54YL8wQZ2os0R2Bp9CIZZGN5In45/2gNSfLGzJHhnCh
	 RqvFTIIDTXX7cSrIw+WsERUNxpyS2GtB5kY14+NXZNaa2WF15wpT+D2/snvhEEzRcrQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C49DF8025F
	for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2026 06:49:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C49DF8025F
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e6990e6318f700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/905@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/905@alsa-project.org>
Subject: ucm2: Qualcomm: shikra: add UCM support for IQS LT9611UXD HDMI
 overlay
Date: Tue, 10 Nov 2026 06:49:52 +0100 (CET)
Message-ID-Hash: T5DVMA74L4WFQQPWDMKLJPPEP7NLSCTH
X-Message-ID-Hash: T5DVMA74L4WFQQPWDMKLJPPEP7NLSCTH
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T5DVMA74L4WFQQPWDMKLJPPEP7NLSCTH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #905 was opened from ks5-dev:

Add UCM configuration for the shikra-iqs-lt9611uxd-evk overlay, which routes audio over HDMI via the LT9611UXD HDMI bridge chip instead of the onboard max98091 audio interfaces.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/905
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/905.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
