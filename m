Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABF6606A321
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=DC3VMH/h
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEE3C60214;
	Tue, 24 Nov 2026 10:15:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEE3C60214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795511744;
	bh=qCmRWFtyJND2njj88Me76PVFnwxutRq35YdB10rw+Mc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DC3VMH/h7GNd3Q/d+8uZAG/R2n6Ut4ruP7bvnUjZllaYX42WItkx3AqyxTR2TgrDr
	 Ay67YKPJAFaNctAEMjBUBeGEssqDBrYdWc6zFDQcOj9lvfku48Iv8vxgzIbe/J+Tdy
	 OSCl7KClr0nCC32AlKSJDTSoT3H4rqxOj90Bcjx0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DCC8FF805B3; Tue, 24 Nov 2026 10:15:09 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F4236F80600;
	Tue, 24 Nov 2026 10:15:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3574CF80580; Tue, 24 Nov 2026 10:14:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795511698;
	b=U2DpqVv7VA2CQEqU9zv3D7wkPQSuxCMWff/9gQvjMtoKarILFuW9SgVLhxOImWeurAOD
	 2m76B+XVeY3hWQvt9dOP8Ay6Ejw+9n5ofqSFIIwY/YNBSE/2kI6v1MKu8+6CfumfDdEtF
	 br3zS9l/ssR2Yo5u/LISugG8MIhMN6ldIIS9oaJXnQgcyRt9oPnBIPsGoQL2BnIRA3Pcq
	 CP+WF4b63Ep1fPBAiXm5Y1ATVwt6tbNzcgFjPMH0AfNw5Spk6p0TNjBfd5texLejftOZs
	 SDKtE/wITwPuaTyRPFWY+rHs0rzJgKuqcZvxzPP3r9qxImEI9K8dcjeKf9Twv+LdcdA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795511698;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=qCmRWFtyJND2njj88Me76PVFnwxutRq35YdB10rw+Mc=;
	b=AcuGa+mWQA7RTFcoZSccWJZuZiv7OFWT+clukfpmdMZlk3fQOBXuMg19WLSPfPDAa9rs
	 douBEy3oe3r437KIXCgEuVLZk0+2IiBkJEIaY9g6HWjAfXOgeUnX8RF1+CSjUfpExtemm
	 gW/NVIin/Po+MSPnHBQD8n5PcHaiWieFHpjRIDlOHsjn4VGcKzvm35qNeQdsyknvRj6c2
	 25vORDHmBQsNOQFuOL/1eSNEkti3RHevIgAQLAeaEwEmQ+ldGhFqpgVhCgyFSRmiPpVP+
	 7yQZVv1+lxrf9lA5EUFv3D0hv4LVLYLrHGs4JzmqgYd2Bi7Mn9GnLJqyCPJCj7fyZmA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 15B11F80185
	for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2026 10:14:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15B11F80185
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18eaf05fe31f8b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/927@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/927@alsa-project.org>
Subject: ucm2: Qualcomm: shikra: Add NORD RIDE and RRD HiFi conf
Date: Tue, 24 Nov 2026 10:14:59 +0100 (CET)
Message-ID-Hash: GRHLMAG66RG5RPY42SLVKQHDVC3KGPUM
X-Message-ID-Hash: GRHLMAG66RG5RPY42SLVKQHDVC3KGPUM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GRHLMAG66RG5RPY42SLVKQHDVC3KGPUM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #927 was opened from mohsRafi:

Add UCM2 configs for the NORD RIDE and RRD boards.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/927
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/927.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
