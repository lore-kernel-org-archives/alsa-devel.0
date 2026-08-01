Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8CAC5518E
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:37:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FDBD601F6;
	Mon,  3 Aug 2026 11:37:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FDBD601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785749844;
	bh=9V9dGQFBtEg2HdhIM8JAiUa1GrD34KPWSDxSaskw1j8=;
	h=Subject:From:To:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CXZU+v9fp20dmNjV/oW/GgKLyv8z4slem64EJqwKOWwAlKIkIoPAdfh6CWC8vY26x
	 zQqzr7Qqf8pWJBxwLAOaEX8U0ngBsAT5p208p/Qn7or/oP0ySlgcAcjFUmq7vCGw+3
	 FLBkZMqmq2oET835c8SOi45bI/t0M+xaSJELtjqU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3808EF805FE; Mon,  3 Aug 2026 11:36:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A12E0F805BF;
	Mon,  3 Aug 2026 11:36:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37D93F804CC; Sat,  1 Aug 2026 14:59:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=84.116.50.34
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785589140;
	b=lUkYCQgIC/IrmHMfFWY8XXt/aaiFh9uWB5CHHl3VHW8UjW69qNJ8zai5c6V2jG6PZ9j+
	 9p0PZXZDbOF0sUoIF9KKiAmdAcPv7INe8SvB6o6M/uz+eqJgg/pYg1tr4GPPXDJjtyApH
	 t/MfCpEJXqWsCPMlGC5YGD+JR3yjFJxyN2KTRTiZmIoWpLoM/HySlKgccov7kjfIxuODu
	 OtHYTnPKRpcVocLy/+S7n2k8wwVu0QdG5fS0wFBUKVpPOYkj2qXYIPk7kL5v+9GfIOs20
	 u5K2I1iMpvHA25VaWCEgGN/XjF/7l+ru0AbSZ9uILt1WWOBgmJyC2nVcdyTk6AWV7hA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785589140;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Date:
	 MIME-Version;
	bh=9V9dGQFBtEg2HdhIM8JAiUa1GrD34KPWSDxSaskw1j8=;
	b=OGXQGhXhxl85ztBTYTwJn6iQLahJ1wPVJvR2v4XypRN1+rI6qSAYbW5JCbmSHQlub0Oy
	 kgOsWq96pLHS0i5OjiNZU+TJri1k0kNf9tgk9DOfzSmH6UDaD08X3K63qbOOA1EtfcfEW
	 8/d6R7J48omSEly9Zv18ZEVz77B8c0CVJe/jLpXeSG+jnBSz8Ry/SxU7+4+0q4/NEzxU8
	 epd+9myNUP8i9oADadrcmUK5RAueum3eSR/XMEevk6ZtTTNt/YHLsX7RfJfpoB/C3URUq
	 h7551LeHHk4QBX4X8z8nlgbjH7uwN7+46yVVtH+ZAw2xQNtONlpLq+04ZxEJDz7mALw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=vmo-authrelay.edge.unified.services
 header.i=@vmo-authrelay.edge.unified.services header.a=rsa-sha256
 header.s=dkim1 header.b=STdPL8Vi;
	dkim=pass header.d=ntlworld.com header.i=@ntlworld.com header.a=rsa-sha256
 header.s=meg.feb2017 header.b=2J9J+8Uv;
	arc=none smtp.remote-ip=84.116.50.34
Received: from csmtpq3-prd-nl1-vmo.edge.unified.services
 (csmtpq3-prd-nl1-vmo.edge.unified.services [84.116.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9C915F80095
	for <alsa-devel@alsa-project.org>; Sat,  1 Aug 2026 14:58:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C915F80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=vmo-authrelay.edge.unified.services
 header.i=@vmo-authrelay.edge.unified.services header.a=rsa-sha256
 header.s=dkim1 header.b=STdPL8Vi;
	dkim=pass (2048-bit key,
 unprotected) header.d=ntlworld.com header.i=@ntlworld.com header.a=rsa-sha256
 header.s=meg.feb2017 header.b=2J9J+8Uv
Received: from csmtp2-prd-nl1-vmo.nl1.unified.services ([100.107.82.184]
 helo=csmtp2-prd-nl1-vmo.edge.unified.services)
	by csmtpq3-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <smf.forum1@ntlworld.com>)
	id 1wq9Io-00ASMl-N9
	for alsa-devel@alsa-project.org;
	Sat, 01 Aug 2026 14:58:58 +0200
Received: from Moira ([86.29.246.46])
	by csmtp2-prd-nl1-vmo.edge.unified.services with SMTPA
	id q9Iow3kixrTNpq9IowhfEp; Sat, 01 Aug 2026 14:58:58 +0200
X-SourceIP: 86.29.246.46
X-Authenticated-Sender: smf.forum1@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=ef8NubEH c=1 sm=1 tr=0 ts=6a6ded92 cx=a_exe
 a=uenGcx7EbP21/Fpy8b1huA==:117 a=uenGcx7EbP21/Fpy8b1huA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=DNSa10gR-IWSA5Dr9FsA:9
 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=vmo-authrelay.edge.unified.services; s=dkim1; t=1785589138;
	bh=9V9dGQFBtEg2HdhIM8JAiUa1GrD34KPWSDxSaskw1j8=;
	h=Subject:From:To:Date;
	b=STdPL8ViOEYpstBVWumbNlZYmi928+IyVa8LMCje7JMM0P/PyDagYw21aXHV8M250
	 PewG8s2H/cfglctx9bmlxqdX2NDl7oi4uQJjKWeVhtlCrIGwl4Ovap4PECaaTwLNsm
	 P3A9A45+WXdvKMA9/4NNtmXYQ3GxC2UiGnKnRsTc3IuER5FmCOAI0VX2BkRNSdxGl4
	 z2nXs6sX9efTACwL0HZHmnM4XBSUIXnJwcL56fydmJmnTA7FR402sfhtKP4FAkuQ8s
	 J3cNCTx/fDwmuwBZOen7gL/WdO97unobrrkuzF3agjuIiD3o4I/fDhlyNv2QCFSq5e
	 f4ZZBN//r4C6A==
Feedback-ID: 20260801-??:csmtp-prd-nl-vmo:Authrelay:??
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
	s=meg.feb2017; t=1785589138;
	bh=EMsjZVzkQsDCGw05pN+mcTBgC0UBpJmY5Eo7iWnlOt0=;
	h=Subject:From:To:Date;
	b=2J9J+8Uv00/EIRh8y/KvkIHCEgdQK8csVOQHBIQ6mbxnN6KUY1+qOxeQuTwueeoId
	 54tVtT12/oNx3bddT177AbyHVgD1xYhXklCl8AKd7HEieetRTFt/iWMaZzQLV2b+h8
	 5rJbIfiw3K6IcOEcPl0uLKhcrVOeXSsr84zPBXtpvwVTh0HHFmEu1S00V6DWgmmwl/
	 n5H/xHCuQZ1Myng10GevFwjx3JTnQrsnLOAvFNLWchhr3KNdknCbLvCkBKlX/phud3
	 F+jERXq+5qLCXOs3KKsKiRjwCjr1ZgzhYBP+CW9jgRqXJb18gd7efomAvjj2Zn12ek
	 xKMaPad9cBZRw==
Message-ID: <732d893fed7ca37c278c35dab51151dd355c93b4.camel@ntlworld.com>
Subject: ASoC: amd: acp70: Request for DMI quirk support for ASUS Vivobook
 M1607GA
From: SMF Forum 1 <smf.forum1@ntlworld.com>
To: alsa-devel@alsa-project.org
Date: Sat, 01 Aug 2026 13:58:30 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-CMAE-Envelope: 
 MS4xfDmMMBJcRKBgZ4wRAlb1mjbQWA97K0yvPFqSMCKpch4rbpa4R6ulJTqdgZZKyOy/wQBgYCgwNt/pJ1NkGiobLqE21lAbPcg66H3zj2oADdzNLRKWXPOB
 04HzC1k2P+NE6VtTOBgSW48RwBm0OzcvYZ3ZX+NGvajxIZn4PHfywbe1hYTTxjWX6SO6RmGmbD/yBw==
X-MailFrom: smf.forum1@ntlworld.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: JN2GCM72HTEF37OSHDD3EBQKXMP37LDQ
X-Message-ID-Hash: JN2GCM72HTEF37OSHDD3EBQKXMP37LDQ
X-Mailman-Approved-At: Mon, 03 Aug 2026 09:36:44 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JN2GCM72HTEF37OSHDD3EBQKXMP37LDQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi

I am testing the linux 7.2-rc5 kernel on an AMD Strix Point laptop and
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
    Subsystem: ASUSTeK Computer Inc. Device [1043:3461]
    Kernel modules: snd_pci_acp7x

Please let me know if you need any further information, clarification
or assistance regarding this request.

Thanks

Stuart Foster

