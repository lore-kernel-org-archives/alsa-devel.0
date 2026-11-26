Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9F606A31C
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=C0AgyhbT
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2D61601F5;
	Thu, 26 Nov 2026 18:09:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2D61601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795712995;
	bh=/oFMzzHI7Yk1IMyonus7zhXGbJQHD+YkgZCJU/F/l4Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=C0AgyhbToQiw/qOGmqpDTFdx7hqz+yiBBOzy5TE3kkNpv+aoz0WIzOjdT+C05K30z
	 FHa27lg5NL8wbS4u385X/5pJxPm8uceOjRRSEws+zF2bFzmrZ5v19rDJjemLaJ6m3b
	 EY8//Xn+0BwlvWqbsI3b0h7fX7UOXvRvckEjZdxY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A30BF805F8; Thu, 26 Nov 2026 18:09:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3673F805F5;
	Thu, 26 Nov 2026 18:09:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8030DF8051E; Thu, 26 Nov 2026 18:09:13 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795712952;
	b=Xy/q1wiVCKGDjXLkpR/IajkM2enTh97ushOguRpqJplq5I+2l17kGdsEm21HIjQvBG7S
	 2PgVCWIZBDx4LA5iD40a/Mj3RD/+TKZRhFPElyg8e33p+wbDw1h90bjqjWO5WWyo8yOGw
	 T+jPtsMobXeHxJy9aEGSfvnm41DVrKh4yS4qaXXKTVch7+CRv7JVeol5K5lpR6+OEIqRl
	 OoEBbXSsvxGJikk3HclU5n3s9w+JWIUUP3ILYO9cgGW5DQy6bHEmexJy3rH4ICEgUtNAP
	 LK77/bhnq4+VMcQ14n6T2YrrCSnUe/45Sb5X7f2k8wOjtyT3X/hNTUdhx4wDMGI8Mog==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795712952;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=/oFMzzHI7Yk1IMyonus7zhXGbJQHD+YkgZCJU/F/l4Y=;
	b=neliCrp2fdHHYNLjRlnHovhjmF6vAzWIbF7jPRcCM8oZT+7x6Fgyy7ImMk09xtqxcPFs
	 WsoxypA2nGDLYv63HlaQIgyaqU1xo6hH8vAp4s/Ayf6c3hUiYtC95hnEcCcJrQvORpoTE
	 zRyCa0QMDrG9BaUfGcIXxJ3iO/kzTd29PqXEczC1JUG/dnw7lrGoifjm5vziCC6bI6Zxj
	 nQauJQz/nd+UFfh+YztMVkmKfFjXjU47mOyLk7Mp1UXR6O/cyyb+6d9CNFWLrEzNtjc+Y
	 vFiZLy8vCciqtTnvDXw/LwThe9yuN70zsDEI7UpD04BiuLbKQgLs6D6SJCWSTJdDQVw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 113CAF80100
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2026 18:09:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 113CAF80100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18eba769ec430000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/929@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/929@alsa-project.org>
Subject: ucm2: Qualcomm: add Motorola Signature (vantage)
Date: Thu, 26 Nov 2026 18:09:13 +0100 (CET)
Message-ID-Hash: LIFFJUFOJTWLA43EQNMWF54XF5MTCGR5
X-Message-ID-Hash: LIFFJUFOJTWLA43EQNMWF54XF5MTCGR5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LIFFJUFOJTWLA43EQNMWF54XF5MTCGR5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #929 was opened from Venkat3620:

Add the use case configuration for the Motorola Signature phone (Qualcomm SM8845, "molokai").

Speaker and earpiece are two TFA9865 amplifiers on the senary MI2S port, selected with the Speaker Amp Switch and Earpiece Amp Switch controls. The built-in digital microphones are captured through the VA macro.

- Topology: linux-msm/audioreach-topology#86 (merged)
- Kernel: the molokai sound card and the TFA9865 driver are in linux-next

Tested on the device with PipeWire: speaker, earpiece and microphones. alsa-info.sh output attached for the UCM validator.

[alsa-info-vantage.txt](https://github.com/user-attachments/files/35475418/alsa-info-vantage.txt)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/929
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/929.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
