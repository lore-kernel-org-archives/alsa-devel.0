Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784BEC5518E
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:38:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3001C60181;
	Mon,  3 Aug 2026 11:38:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3001C60181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785749913;
	bh=wsTyerXQKKH595wjN4AfWlrw4QbYyJHpSCxkUzWwOBQ=;
	h=Subject:From:To:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mi5ClP9j7rMLfuvfxNYlTGvqfCA/1U0xbKi4TniFpfU/5hNxKD+5AKXlpqT0jnuSt
	 bfXSJ7PiE++0UrRf9gkhdd29Mzi+jSSDvY4gauKtbpaKx97laQaLMUSSj6wyY6HkRl
	 jPl3tPXG3/yDpRnhmOA8OudJtd+Bo9pw236uQEUU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A34F3F805FE; Mon,  3 Aug 2026 11:37:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EF8C8F805F5;
	Mon,  3 Aug 2026 11:37:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8AFF2F804F3; Sun,  2 Aug 2026 16:59:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=84.116.50.35
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785682770;
	b=W73iJPMw0D02WWYwLinREMFhYSV6DeB7YOIsJRdNORgCxN+0aXhquoWhyJQdNo9Wi5n8
	 Ic2XmNrZrpUK3a1EZGNEoC+qlWK45DGDjq6BFQiEVXEIj2OLDCg95wAmgqJx+HEJHbkAX
	 rzPG4+CkN2mNRVPLY68hFDUZguGf0coiuBqgVF9tBophRi4hZ9OiGtV8PcBen3XPd9CFQ
	 TaeQ6FoLNmzo6NsCegkFOZ0hxtgU3tepiX75PsbpMGJMurwh5hGFMz64YPrwN0K+YeZfP
	 4iwI6Prk9XB5mvKu9K26ohLa9JwcDBhFFuuY2SmME0d8TNnWXU4m/EwsCvCqlFLrL1Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785682770;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Date:
	 MIME-Version;
	bh=wsTyerXQKKH595wjN4AfWlrw4QbYyJHpSCxkUzWwOBQ=;
	b=VDvDo5iw9CYOY7zJlEotmE8YaZbDA44yLMYjSI1mViHED8ivTIJLeeGiaEIyxmr8DwP9
	 ASJ2UIT5ksQhN7liRGDFdZXkoNQBXpXFbrMNaobEI/uQdFqEwKx6nWrEnt49ILOArI5vo
	 3wdDBNs/haiHT2wsMlUFNPnKQu82kMl3XA9KZZlHo17/b2g8q2qih4aHi+WT8bL3XNdQt
	 PQS5qp1JqyOXNcPJrTS4XQyNK/StYZVSSqaHVL8PxghM0lOVHhfdz5ZUpGSCXCnLKErdI
	 BzMy2rTtzzUmK/tAFVDWlrvTy+iBejiCegxmDu2VL5zZXjO2fMlEKHC6n4UbljBJRXw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=vmo-authrelay.edge.unified.services
 header.i=@vmo-authrelay.edge.unified.services header.a=rsa-sha256
 header.s=dkim1 header.b="eHSzd/n+";
	dkim=pass header.d=ntlworld.com header.i=@ntlworld.com header.a=rsa-sha256
 header.s=meg.feb2017 header.b=0SL7ijAk;
	arc=none smtp.remote-ip=84.116.50.35
Received: from csmtpq1-prd-nl1-vmo.edge.unified.services
 (csmtpq1-prd-nl1-vmo.edge.unified.services [84.116.50.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C2B69F80027
	for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2026 16:59:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2B69F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=vmo-authrelay.edge.unified.services
 header.i=@vmo-authrelay.edge.unified.services header.a=rsa-sha256
 header.s=dkim1 header.b=eHSzd/n+;
	dkim=pass (2048-bit key,
 unprotected) header.d=ntlworld.com header.i=@ntlworld.com header.a=rsa-sha256
 header.s=meg.feb2017 header.b=0SL7ijAk
Received: from csmtp5-prd-nl1-vmo.nl1.unified.services ([100.107.82.93]
 helo=csmtp5-prd-nl1-vmo.edge.unified.services)
	by csmtpq1-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <smf.forum1@ntlworld.com>)
	id 1wqXey-00B0Cy-PJ
	for alsa-devel@alsa-project.org;
	Sun, 02 Aug 2026 16:59:28 +0200
Received: from Moira ([86.29.246.46])
	by csmtp5-prd-nl1-vmo.edge.unified.services with SMTPA
	id qXeyw7FQcdeDPqXeywHl8e; Sun, 02 Aug 2026 16:59:28 +0200
X-SourceIP: 86.29.246.46
X-Authenticated-Sender: smf.forum1@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=Y6XIdBeN c=1 sm=1 tr=0 ts=6a6f5b50 cx=a_exe
 a=uenGcx7EbP21/Fpy8b1huA==:117 a=uenGcx7EbP21/Fpy8b1huA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=DNSa10gR-IWSA5Dr9FsA:9
 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=vmo-authrelay.edge.unified.services; s=dkim1; t=1785682768;
	bh=wsTyerXQKKH595wjN4AfWlrw4QbYyJHpSCxkUzWwOBQ=;
	h=Subject:From:To:Date;
	b=eHSzd/n+ugschjsuh+n7tPXQCaR740E+/AXGf68ZWLGRqxNzGtop8Fx7JDf0M2y8d
	 HfUaP6oEJvxU2lU7bCLokNtlzbLLlGnqbtCYx9zrPjH557QKtupjTrNvZGJtTchA3Q
	 hUmeH4ndeBsHr8uO/u+5wRsuKD5AWNW9y5FY73yvPG+XbNwcazC9nhbaedS369FTdo
	 hubi+wrKgKhxiICf3vU1p/K4EyD2d7NLDYzbxMffzfM18r9W57MRCundFVF0bzGxr+
	 gP7PXz/y0ijptkBN1/+00VQ5mxNOJIpytqHrQJkzuYQe/Ny1aoj58N68YWLpOhj+pg
	 3OnKVcMtxBzeA==
Feedback-ID: 20260802-??:csmtp-prd-nl-vmo:Authrelay:??
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
	s=meg.feb2017; t=1785682768;
	bh=wsTyerXQKKH595wjN4AfWlrw4QbYyJHpSCxkUzWwOBQ=;
	h=Subject:From:To:Date;
	b=0SL7ijAkFpzrqVZzuNSfZehpe70x16yCkyTsIB+3jagfO9s1Si2MKbKIYBojTXCkK
	 3dPxRM57I8H4dtTI4Y/whjSh4wZuYH5x9r30mxLB4kDfq8OwhkaZG/2HwALowHqUj9
	 gsTnMWE+Ha2Fi8StOMPCVdATdAa0mZqvAGZkAYUabg49AIYI4ae4iyyfDFz9lqrcWS
	 HGwQ/AAN27oTjrysYc9LGxZnFqS6DSiRsNyfOWByRaxZG4bXqLNFbWAEDQf+6HnPNC
	 nyQYlbrRJCANeRAf8gGoCVL2/FRBKif60KUkByUbV9pG10ClMTutzubhe90NRAiUHx
	 e3r69v4z5a1uA==
Message-ID: <3d2380eb04ab90a9a42eb0fa8247ab8f0238bba9.camel@ntlworld.com>
Subject: ASoC: amd: acp70: Request for DMI quirk support for ASUS Vivobook
 M1607GA
From: SMF Forum 1 <smf.forum1@ntlworld.com>
To: alsa-devel@alsa-project.org
Date: Sun, 02 Aug 2026 15:59:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-CMAE-Envelope: 
 MS4xfCy9Y3UMQQAbIi8Z0sUBlSQ6rtdhI18hTr/H7ris9a9jZDy0/9Vd4oRaiECEhurUlQVdcNNpNLu/8R0YaDnoLb330Jm+9r1P5XSoxZ+EGaKCc04UDtsr
 4vKS4WVpncg3kZKNgrwOwCV7xoDLGejgoYNsC77mnqSvKZvUJz54l0P+yzM7jTGlgNVBFyoITMqBnA==
X-MailFrom: smf.forum1@ntlworld.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 6AS4NQCH6C4NTZW6ZCKB7Q4PFBXIKQ4B
X-Message-ID-Hash: 6AS4NQCH6C4NTZW6ZCKB7Q4PFBXIKQ4B
X-Mailman-Approved-At: Mon, 03 Aug 2026 09:37:18 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6AS4NQCH6C4NTZW6ZCKB7Q4PFBXIKQ4B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi

I recently submitted the following request for support for the Vivobook
16 M1607GA. However I may have been a little premature in that on
further investigation I have found that though much of the framework
looks to be in place the firmware in particular may not yet be
available:

ie sof-acp_7_0.ri and sof-acp_7_0.tplg

Am I correct in this, and if so, when (and if) are they likely to
become available?
Since my original request I have written a patch that adds some of the
missing software hooks, but I cannot see if what I have written is of
any use without the firmware. This is a learning exercise for me, as I
have not written any device driver code for many years.

"I am testing the linux 7.2-rc5 kernel on an AMD Strix Point laptop and
I have found the internal Kraken/SoundWire audio configuration is not
registering any sound cards.

The core 'snd_pci_acp7x' module binds successfully to the hardware, but
the machine driver fails to map because this motherboard variant is
missing from 'sound/soc/amd/acp/acp70-acpi-match.c'.=20

Please consider adding a DMI matching quirk entry for this retail
hardware platform.
Assuming it is not already in the pipeline to be done.

My system metrics are included below:

--- DMI Identification ---
System Manufacturer: ASUS
System Product Name: Vivobook 16 M1607GA
Baseboard Product Name: M1607GA

--- PCI Audio Subsystem Code ---
03:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] Audio
Coprocessor [1022:15e2] (rev 72)
=C2=A0=C2=A0=C2=A0 Subsystem: ASUSTeK Computer Inc. Device [1043:3461]
=C2=A0=C2=A0=C2=A0 Kernel modules: snd_pci_acp7x

Please let me know if you need any further information, clarification
or assistance regarding this request."

Many thanks

Stuart Foster



