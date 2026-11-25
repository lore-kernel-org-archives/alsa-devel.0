Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA14606A31E
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=aVMcpb1h
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F38DD60211;
	Wed, 25 Nov 2026 23:11:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F38DD60211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795644677;
	bh=uiSRlBIIljPjvbGhlrwctC7xBkdkZk4lhvwbB0e8XYs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=aVMcpb1haW8KFZlNrEzjdhhzKxNd+zfbG3jt+eqzBXzmlzdl9fRJRqY0AC/6b06Yb
	 9OM8yon0XFNcbAj+pyWsBXDDH+ZQNHUYVF0BrCszfvBpYLNHyo1ivlGI2e6tScp56V
	 i6KvTYd7slgrZiwRYbe1bDDVG7ldWQ0KaZzdPZh4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 271EAF80602; Wed, 25 Nov 2026 23:10:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 77509F805FE;
	Wed, 25 Nov 2026 23:10:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 02E13F80568; Wed, 25 Nov 2026 23:10:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795644634;
	b=GH7u32KLT4qL5cBG2zqFNCZrOo2bX2ACDpCk3RHNprwiyN8vDsZm29wE1WaPrDC/eJLF
	 ZDUwk4ZmqQ4lq3nSyplpxG9Z63i3BBOBbGEncTlnRJhVaoaBt4OviVxhOF4+kDdbRLfnG
	 22Qqn6kDGmXloD7YnPdKBRowaF0sUaCMKoKwHFl+kRptvuGbbN3YnzBxZ0KV6xDAhvWVT
	 77roO5xRzPuFPxpSyyov9YmJVCYgKPa10aLbqEhkHmkXRLWBmkDFeCB1PfvrQ2lbqIaQm
	 xeuPgmtDg8QEhewReu4+x17DF6Q1613uYFL18wZ1Lkj9bwPzzF5BtFgl+OUz+olwpiw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795644634;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=uiSRlBIIljPjvbGhlrwctC7xBkdkZk4lhvwbB0e8XYs=;
	b=OQU+yptBHpS9f5KL0xzpmJgv4sfGXPQ/6FPMSx7F3oo4pP9Yjgo10YpqevLwFHL+ptC+
	 AOndFkC8WAQHBxwbAvaX9vS2Mkjw91X9cG4/Gm1CXWKlYQ8Odse5vGyjQuQj7fNh9QFTH
	 VfadRZriuWqqKQFr0D2zT7bJAoCFfamCHxojExk9WyNQucsqk+6QDJE+Mr+F0opukqgpi
	 XOCi6OxKhTvAEalCpmIiV9/Y+p+dQV16OcllusZnDVOSPRuuQijo8Kn+H6hZAB9D9zZGE
	 PfT4ahAFQUA83o2/EOnbgbo2tyAjzccAugBSQr2wTgLsG/cOjGVzZaU/XjIyL15/JTA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CEE1F8012B
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2026 23:10:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CEE1F8012B
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18eb69477d7ccc00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/928@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/928@alsa-project.org>
Subject: ucm2: Qualcomm: glymur: Zenbook A16: add HDMI/DisplayPort playback
 device
Date: Wed, 25 Nov 2026 23:10:35 +0100 (CET)
Message-ID-Hash: NLSNNING3UBUYSPJGZVIVCNAYKDMOWY2
X-Message-ID-Hash: NLSNNING3UBUYSPJGZVIVCNAYKDMOWY2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NLSNNING3UBUYSPJGZVIVCNAYKDMOWY2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #928 was opened from romanstingler:

The A16 sound node exposes MultiMedia2 (hw:<card>,1) as the DisplayPort backend once the device tree wires the DISPLAY_PORT_RX DAI links. Add an HDMI SectionDevice that routes MultiMedia2 to DP0 (the first USB-C port). Only one DISPLAY_PORT_RX backend may be routed at a time, because the ADSP rejects the media format of a DP whose jack is off, so the other two are disabled.

Requires a board topology with the DISPLAY_PORT_RX backends; the current A16 topology is the CRD copy and has none. Tested on hardware with a USB-C to HDMI adapter (tone plays through the display).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/928
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/928.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
