Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBE1C43458
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Jul 2026 12:49:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61DC1601EB;
	Sun, 12 Jul 2026 14:49:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61DC1601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783860582;
	bh=oAfv25o4zzszQDeEdGbiOctSFuoN913/ON/GMJp7mTg=;
	h=Subject:From:To:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=WAjC9lvdjNYVqEkAZoMCzilK1a8C3EbSebuy/qe0+7a3/KBV5tuSRRkHbBiMlfE03
	 2TG0qkan+XsuMBBev684rXL8UyXje9PksUJUxrSjq8Qhv/bRV4g9aOpcUHumo2pYw/
	 xo79dXDEMTCM7Wup2bPKgkpnooZN0ZV71v0MGD+k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 01F6EF805FD; Sun, 12 Jul 2026 14:49:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B3CDDF805F2;
	Sun, 12 Jul 2026 14:49:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8FC42F804B2; Sun, 12 Jul 2026 14:49:00 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=217.70.183.200
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783860540;
	b=cgyl630SQyvDa/bljdXd3b9QgpJ3Hpyr5zVM03g0aMmrYUA/pFarLyWtDn3T8JssMgYa
	 P1pRN0udHvVvvj0HZ/SvKqAC/wMsMeqrexzE/lHhHdZngbQ6/gsaQCkv+7vXo9wfCjksY
	 TA+RKtg5GaZRQQzt66aYd1OxtrTcC5FrH1au7tl8lMiOFC73cd2uGZGj1sWLs5hEoLcsD
	 sMdh1yEc/RQoSwmTvYOUNCy4OeOzCMQzHWQQjduyqQgfPhGB01jBGWY5nQc0TgDY1KnsY
	 Bki3KCll57bPRxRTp6cpLEKa7QWHW9BN2d5J5QgvsYIroNCLgn3zgqYWzSEHoa7kppQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783860540;
	h=DKIM-Signature:Message-ID:Subject:From:To:Date:MIME-Version;
	bh=oAfv25o4zzszQDeEdGbiOctSFuoN913/ON/GMJp7mTg=;
	b=LxcqqLObM/UwSWGZwU/bDcBNyys3OxBXAcx30ka9auDHjHsoJnTGhk3SpuSPEZeELQY4
	 1dTsJK4JCiDyNlDSLgMGxVfugXl9Qh/GQqkkCnCQkN3OCoC8SYLiAENSqD2fAROpkCakN
	 it5xqXP0HerzuoDpnl3q4zUDwih1xNZO85nX5PJaKfOW7+GA2/aR1bJzGYwXD8/LEEACH
	 JtcoXNn+BM6VvWGp2qrYp/xBp6gzu6MUoBJTRaLy7ATYrxB+SkrhSCEEXtJQTgbWSe5kU
	 dERgAa9VLOWq2l5p7pP61eEgvtJ2VOEhKCuFX0ipDTYoNi9HlMn7q7rtLiW/aUX3LAg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=patrick.pouget.name header.i=@patrick.pouget.name
 header.a=rsa-sha256 header.s=gm1 header.b=ezR5kljh;
	arc=none smtp.remote-ip=217.70.183.200
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0303CF80152
	for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2026 14:48:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0303CF80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=patrick.pouget.name header.i=@patrick.pouget.name
 header.a=rsa-sha256 header.s=gm1 header.b=ezR5kljh
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0BEBC3EC5B
	for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2026 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=patrick.pouget.name;
	s=gm1; t=1783860538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oAfv25o4zzszQDeEdGbiOctSFuoN913/ON/GMJp7mTg=;
	b=ezR5kljhUQSkZUUOolqTxay16u3bi3+4G39/T7Ogjb0zKgZ69zqoTq9HzFjxhcojqQcMio
	d/lNWy3bdxwzXwkcCoK+VzuqeQg4Iq3kzVDXEc7B4O81KT0USDR5H3flhEYbTLBGOkgxbD
	CG/l/wi9+09H72tYM0i1AWfMZagCrKYDXkr6L8Y0tu/v9a3zA4+56dKiRa0Via5tW1Rf9F
	5GFLnn02Kr9E/Aym69OqQoYT/Oxy9SaC9d6JGJVlG9V8mVJ8KNBgwb4tM6XrTEjzNaCmDR
	dEBVviwmsZQowe/vG59GlSLV+nZCOFT+QYgd9+3dAYiA6T4KPZcyRZddxKOx7Q==
Message-ID: 
 <d8ea49b2705c3a3cf7ee8ab752665c619e4d9735.camel@patrick.pouget.name>
Subject: Direct TOSlink access
From: Patrick <forums.info@patrick.pouget.name>
To: alsa-devel@alsa-project.org
Date: Sun, 12 Jul 2026 14:48:57 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-GND-Sasl: intendance@patrick.pouget.name
X-GND-Cause: 
 dmFkZTFLmGMm/fspEGf9b9luOaIuh9kbHjru5dgbx9WtzisII+kYjsQAqQsv6u0hCB4nZ/75n+uBN/Z9og28i27hy+MLaE7V6O+lKV6ZktFzxfJn/7iA7Vp8QOj1whTHDCzYPANMx17EjVhJq9i4M8bmp9UxTfAx4fZ+9k618vhYelR8JBOYUsW1NS+coixu6ylIkpqni6PasbP28v53L4U5HLJQvyvgZ55JNSb1nMhtJPhPvmbcMpePBEyFCLHxfTTLB4EDn5s69vVbfdLHsx5zwKtNOc8RcOyt+ib1r1hc3N7SDZf1joTkF8uHLphw+BaigsoB1kmAN/lBA1aNQR/VrZGJcxgDUo6Q6Cd9iwqjuTbQ0nMhRYsWD/1bEz9VatmFLM5ZZwlhCypNuRRm9RK+2iWwUr5XVf01Gxcu6vwXjRo3FBPeltgW5jzpqIW8VP6W3hc1tpq7WTj+6tRWFsC+J/d+YWm02L+ZveduH4tCiU56Ua3qBOkv0kavrtKZayaS8hO+tXqX36yVOigSS79pMFE+crjKtCNwgdTINieabZ4py2Mpp27iWEuOcXPjheQSJ7z0Cgqf/TSBmEpetYjnhRnspyqJdG9uX+E+tpjrHWjVffX00f8ObZ2jRb0G/HKEe0adXXiIyF9WMxGGnS0q8uJHYpPUarJL9Qf1kAQAjzUWPw
X-GND-State: clean
X-GND-Score: 0
Message-ID-Hash: Y4TFBQAKIZCZF7XQ366EPHV3STTXEJDL
X-Message-ID-Hash: Y4TFBQAKIZCZF7XQ366EPHV3STTXEJDL
X-MailFrom: forums.info@patrick.pouget.name
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Y4TFBQAKIZCZF7XQ366EPHV3STTXEJDL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi All

Is it possible to send data directly to the TOS-link connection?

I mean without passing through the mixer.

The goal is to design some electronic board and to receive data from
the computer via an inexpensive link without too many cables
restrictions.

Does the alsa tools easy to modify to handle that?


