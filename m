Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8EA606A324
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Wulo91TZ
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC8DB6020B;
	Tue,  3 Nov 2026 01:50:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC8DB6020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793667026;
	bh=3cpIG6HcgDyb9qm5wU4RdIZ73en9/rFO3h8mOazxcoA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Wulo91TZek45oNLjaQ2iEVmlkklb7jnxl3ilG+rssBzFvnF/hH0WVQNE/iWL7q4R3
	 li6IMJ6AJK9SlIP93pedy86iivWrLRgK8Nv26QJDupOtquaHCt1azrjsFZYOMeYhMv
	 fQV+W6xin2nmKrQPTZequGmcX/CJvw+QR+Nl4fac=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 435F6F805EE; Tue,  3 Nov 2026 01:50:01 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F0B10F805FA;
	Tue,  3 Nov 2026 01:50:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F363AF804CF; Tue,  3 Nov 2026 01:49:54 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793666994;
	b=ime4jOp3g7EOdTu9h41eoPXT/Pblts8TRU+2h2VLihoBbngVBTWajpWsn0UzzC5NL1ao
	 ObL+g5ddl9xck1ju7r9DlpCpLrVBz2bxY8niSX+WCNLqeWW2ceFaeRAvk33b8lAYg/0jq
	 iWpmk5LNl237xYNVSHLdrDtRtT7H3djxfHks6W4EhvFft/yYkm8Tc5OWVDxYN6MOxIu+5
	 g6/kifD8R0pYibCrEBY1t+3GY8kYCfxhN10S/ByYXw6Nb4bWt1iMfR7j8MwY71d+Sr2Dd
	 mAEcnzT+LJa7a5Owii06f154s5r7WOMsEWowMEMtBExa6ApD/IWHrTFGjvj6W/AgOpQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793666994;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=3cpIG6HcgDyb9qm5wU4RdIZ73en9/rFO3h8mOazxcoA=;
	b=ou3YpoDbHIy4z3QEZNX8UciSJyuHgeSps9czOAz18C9NsFk9JChueDb9qkXOm1SBLzfO
	 uhsPIT8ZK0+lafjbljZRjiYgRvj/fKusSQ1ZAyhiGV2L++0M4hxtR7vjNw89iAU+Iy63M
	 /BCOJ7unkCVHV8CFNAxAmKH/uig7Uh4+vVX3OmS9pgy96mDSjchUF+sH1H1BEL2O3CZAn
	 RP8wYvotSqKnGNy8B1Vcm+Z2LlCxEfbRYHMzvUQz6WPLg6pGoXv7nRcdDsCmmzTPMAIHn
	 5dtCYKJeg9/O+1MgiDuUKNOZZ5n2ghAYEuUJv7kM2PeGoPpCwQMENaMZomfuEFj1b6Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B72FF8021D
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2026 01:49:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B72FF8021D
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e462a0707a3d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/901@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/901@alsa-project.org>
Subject: ucm2: Arduino Monza: fix headset microphone capture
Date: Tue,  3 Nov 2026 01:49:54 +0100 (CET)
Message-ID-Hash: RO6GKJQAPH4PLPM7SVJ5QDGFF6TE73CO
X-Message-ID-Hash: RO6GKJQAPH4PLPM7SVJ5QDGFF6TE73CO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RO6GKJQAPH4PLPM7SVJ5QDGFF6TE73CO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #901 was opened from ricardosalveti:

Capture from the Headset device on the Arduino VENTUNO Q returns only silence: its enable sequence aborts before the ADC mixers are set up, because the card has no 'Headset Mic Switch' control:

  unable to execute cset 'name='Headset Mic Switch' on'

The qcs8275 sound card only has per-input pin switches for this codec, such as 'Headset Mic12' and 'Headset Mic56'.

Dropping that line alone is not enough, as the device feeds the ADC mixers from MIC2, which the shared max98090 enable sequence routes to IN3/IN4 ('MIC2 Mux' IN34). On the VENTUNO Q those pins are not connected. The headset jack of the UNO Media Carrier goes to IN1/IN2 of the MAX98091 (MIC_IN1_IN2 to JMISC_AUDIO_MIC_IN in the ABX00181 schematics), which the device already selects with 'MIC1 Mux' IN12 and the 'Headset Mic12' pin, matching the IN12 and MICBIAS routes of the device tree. With MIC1 left out of every enabled path, DAPM also keeps MICBIAS off, so the headset microphone is not biased either.

Drop the non-existent switch and feed the ADC mixers from MIC1.

Tested on the VENTUNO Q with the UNO Media Carrier and a CTIA headset: the Headset device enables without errors, MICBIAS is on, and speech recorded from it plays back clearly on the Headphones device.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/901
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/901.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
