Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D8606A325
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2026 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=BZVRXCwa
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68995601EB;
	Thu, 19 Nov 2026 07:46:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68995601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795070773;
	bh=X5RmhTiUlSYotPua0f4t9jd9znbW1pFAUZv01UXshcQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=BZVRXCwadW+hhMCZlylBPZtsXU8XkAiaNJqVkLsbYmLxL6qAheM+pP58A08WFV2Jm
	 0e/ycors11UsMhry5Qlnfw2KJb+vEEu0fbgLOTl86VJ9nomj17gn6rTMFvdFzeor/B
	 hQ9xJj9i6GliHzs4XqI1gI32FAhFp5YvC/yQf880=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 92860F805C7; Thu, 19 Nov 2026 07:45:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 16FAEF805F5;
	Thu, 19 Nov 2026 07:45:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7ED6DF805C5; Thu, 19 Nov 2026 07:45:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795070732;
	b=PednGDLjtqlcwyLJmuOxgBVRQrPXPSyZU5xhaTOn60xygdz8fhqS+zCov3P9M8rFNN5d
	 1GXtTS+AW3eNP7JrmZakT7zRKf+jstqtzqdDJ4yMh0P7VP+nnMLAeOWxXJpznkaDgwXuW
	 Rsscg2QQM2SJvWKN0tFr/FhWD8IzXM5jGwjVo/7zzzxwmxwjUSSDyWBvhBshG8yMAHSrC
	 evNKh1UKQRRrdkB32JaTzir3LX7m6pvdxZN1UhgIl07E6HNDPT9JKZRcasFulM7NmS+9h
	 sKid3Rdt2nskBmBPpMbSPPMcqGqJ37lWksTbdM9lrDL6gbkYOY2zwA+2fdNWmzESGLg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795070732;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=X5RmhTiUlSYotPua0f4t9jd9znbW1pFAUZv01UXshcQ=;
	b=KQnKH/SAHMdXPbG0RLAYHTqhsRsLhryKZPgAKKP0qqlbi9DaWEa6GX2G+glI8CMOd1kr
	 a5owp8xbnGBxWHSJMG19o4LUrgMEMdkzRYbYoLGodHkyhTAe4VNNR7zU2Tu9CDyeSAEvr
	 pEnf/DJydtBPw2yS1gv/F/TVX47CM+X4BTipO050xNAvJHnIW/UoNUxOP1xuG6rYFWTO0
	 gduDufeQ6T3aYJosgRFyMisRpcnyGUBSt5+ufBO6tjpW+XV804otMct+B0BdZRmKwMJSI
	 ZLlHbNhVkZ8VlQb/mUI5yz6F94bc6SFpwozZRhrmxyddT1DZK4je3/2h+cPrn7u1KNA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id AB59FF80152
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2026 07:45:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB59FF80152
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e95f51bb345100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/918@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/918@alsa-project.org>
Subject: ucm2: Qualcomm: add Eliza CQS EVK support
Date: Thu, 19 Nov 2026 07:45:33 +0100 (CET)
Message-ID-Hash: T62MCKZU2J4MKQQTQOMOXEN4BILMYDUD
X-Message-ID-Hash: T62MCKZU2J4MKQQTQOMOXEN4BILMYDUD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T62MCKZU2J4MKQQTQOMOXEN4BILMYDUD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #918 was opened from RaviHothi:

The Eliza CQS EVK exposes a WSA884x two-speaker playback path and VA DMIC capture.
Add a HiFi profile covering speaker playback and internal microphones.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/918
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/918.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
