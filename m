Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB31606A31C
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=O493DAFB
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94D0260204;
	Fri, 13 Nov 2026 11:30:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94D0260204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794565865;
	bh=pw7lJW0HZifbGQVumL9/7NCjAoWhY99MTPL3LOSMHa8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=O493DAFBqeaNiPeC8rAWwld8eHX00y3CF+tXRHMm0KiQdcnGOmceqim4STm19SZyH
	 qRf4JB3MXXvC1jUhPDAX3B5GbxD/5zLJ6Q8V6OSeoIuA/fyGjm0OKAN8jr25go7C+t
	 5jdLRf2AWvpBQ8KDkL9Q+FXid6U856xtckRZTNqI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A72E0F805BD; Fri, 13 Nov 2026 11:30:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 89F1BF80600;
	Fri, 13 Nov 2026 11:30:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 058BDF80552; Fri, 13 Nov 2026 11:30:25 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794565824;
	b=PQd8VZ3mJZOXHlq5seyTFeDBzRFLuqAAbpSm91OYEPt5nV6Pp06ymcfPKxVdL4eQKspm
	 N3wKMilO5RePYXqyj7elybJeYhqnnMyJNkDNzCSfJM1YqoqlhB1LtmrqAkhpKFUregUc5
	 89oPlBRhD7ylxf/dg6zTasaSfvx1079q266X9aPM1XHipNdYT+oxuQi6HQudkVgJoWp6p
	 3BlvSfBsC4Y/zIzCzE0V+bIf6IdBl3a93PFBmKqv7R2/6IsgWCT2Mk0SLC+t//IimOj88
	 XZLGoltFSeerxH/EO6HhUnlhMWGdZKWDMmeKi+Q3UvdExIZ9cRz7IFqJlQnf3h+dvfw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794565824;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=pw7lJW0HZifbGQVumL9/7NCjAoWhY99MTPL3LOSMHa8=;
	b=djQbLHLCZ6EmSoj3SKq9gP9qmNxP24C+yy1wwjmArFURdNaGr+erUU5IqGEftP/xzx4c
	 1JDhGW50Tv4A3qLW8CZQz5cpOu20dzw/koBdFkiCncuTgXIRwtrXgJB19x0GKms6PO4Jp
	 t3eqlrFbs8Tw+XcHcEp1LX8TWlbxTL2ht9L24N1tcuoN93SY7bzcW6ivdSCzkw3Jm5Yr4
	 fgN0zyeLj735X70zA0yWT+IrQfwtNFzr4xkZUFSB0m6qrGXjwh516PyWqFyXkFEdzFLiB
	 HuYmrq/bL4Dq+Na3tDxEGOTdxVwOHPGZJgDkdUHshwozFRslJjw+xJGOM1RV95V5Nwg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 142C2F80095
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2026 11:30:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 142C2F80095
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e7941b9012f500-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/tinycompress/pr/40@alsa-project.org>
References: <alsa-project/tinycompress/pr/40@alsa-project.org>
Subject: src: utils: fcplay: add M4A AAC playback support
Date: Fri, 13 Nov 2026 11:30:25 +0100 (CET)
Message-ID-Hash: KYAPGSN7DE6RW26CY6TOZ4JV5OW7O7AM
X-Message-ID-Hash: KYAPGSN7DE6RW26CY6TOZ4JV5OW7O7AM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KYAPGSN7DE6RW26CY6TOZ4JV5OW7O7AM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/tinycompress pull request #40 was opened from ujfalusi:

Recognize AAC in MOV/MP4/M4A containers as SND_AUDIOSTREAMFORMAT_RAW. Keep the FFmpeg context open for M4A AAC input and read packets from the selected audio stream, buffering packet payloads across reads. Continue to read other formats directly from the original file.

Return input parsing and open errors to the playback loop so it can clean up the current stream and compress device, including failures while opening a subsequent track.

Validated with the fcplay build, sanitizer checks, payload comparison against FFmpeg, unchanged ADTS/MP3 reads, and input open failure/reuse tests.

Note: this is conflicting with #36 , but I have already prepared local two way conflict resolution for either order of their merge

Request URL   : https://github.com/alsa-project/tinycompress/pull/40
Patch URL     : https://github.com/alsa-project/tinycompress/pull/40.patch
Repository URL: https://github.com/alsa-project/tinycompress
