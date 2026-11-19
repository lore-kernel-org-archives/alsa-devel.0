Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E4606A324
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Nfa6MSGR
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB2D46018E;
	Thu, 19 Nov 2026 19:10:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB2D46018E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795111845;
	bh=lN15meqA4J4NXGZZcPPMJJVhSgrrkcPEdUFZdPTQvT4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Nfa6MSGR7QkQmPfgYj0sReBGyg8ytgew/ziYnnRnsUQk3OgTRN5ddFVIY2l6XnuNf
	 TtzEymS9w0hD+kgzAecpkrXwQ0TOnYouton4QOjIM/iAtDCW8tsIcQeSB4su5jW5eo
	 ZCVVJgVknCiFRjX81z9CILY0O+l36PqnHCXL76gk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B66EF805DA; Thu, 19 Nov 2026 19:10:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4601EF805F8;
	Thu, 19 Nov 2026 19:10:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DDABAF805C5; Thu, 19 Nov 2026 19:10:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795111802;
	b=ZyJRrwulzQtKU63iryeFT+DrJX0BlzJDJEkHDQMgClhC7nRgDYtiVzAvcVoz6BaJv+VD
	 Lz3Kvmjp8XwpdsXJ1FmytlgTrBINTTb5GFxkMNkvzYIxXK0zsQkfSBBtQjxqskQGlBpFs
	 sy03jz/TuZlVJM44JkXid9ZssxD9FuRcovGzpvNG1/mO8/pf6865basWxcJP+LGP5abbg
	 8V5fywssl0v+IUuJDygFMIp8tcsHc1Xo3449Cl4Ue7P4AnDeeVFeLPFkmcrPQ5Pn371fs
	 ObsvTdAW7LYM7UGphVVCL/FQRs5l+u3yE/5rcASDleGkyHz1Psf5lcuDoK7KmGWucfQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795111802;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=lN15meqA4J4NXGZZcPPMJJVhSgrrkcPEdUFZdPTQvT4=;
	b=HRYUrVENR1g5rJprv5cCOe7LC+kZz1KMdNl7eXIbewJcSVD9dhzmmMzX5nkslQTD2Zvf
	 Otpq/3bSfMJoSsR7Zb6KaEIfwfvOUtlvrORbfORuGg6gHeiGuaj7FVKma3IH1qodqU/9i
	 +9eEnZG0PKlmrailYHBHNSKc0vmQQcrgV49CEKYym5nYXv56pcZSdzXgDeZqZMIeboeOi
	 9PBIgZv5RiCc5n7l31j6AClDtxjcu0/RZx8XDkFenmrLS7kNccXXQA4mZAjKAD1bczuvh
	 L6wrqusFMJCFYLoUVxPojH15AYTIOIlPplHkZ6vWMulY/ZfoaJz8v3KDNjaIrAbjoqw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D954FF80152
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2026 19:10:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D954FF80152
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e984abe8240500-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/919@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/919@alsa-project.org>
Subject: USB-Audio: ALC4080: add MSI MEG X870E ACE MAX support (0db0:eb76)
Date: Thu, 19 Nov 2026 19:10:04 +0100 (CET)
Message-ID-Hash: J7QAYSYTA4KQXGGW2IJYQJIM5QNCNHBC
X-Message-ID-Hash: J7QAYSYTA4KQXGGW2IJYQJIM5QNCNHBC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J7QAYSYTA4KQXGGW2IJYQJIM5QNCNHBC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #919 was opened from Kurobac:

[alsa-info.txt](https://github.com/user-attachments/files/35101101/alsa-info.txt)
Add support for MSI MEG X870E ACE MAX (MS-7E85) 0db0:eb76.
Tested rear line-in/out and front headphone/mic. SPDIF is not tested because I don't have any hardware.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/919
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/919.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
