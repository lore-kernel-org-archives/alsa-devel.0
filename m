Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3038D606A326
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=c1YJZV2x
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53D6F601FE;
	Mon,  2 Nov 2026 20:03:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53D6F601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793646235;
	bh=abnWhS7P9xkMO20EB3jqSt3/EuJNalphHi7dHZYXJiM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=c1YJZV2x94c0Jclgvm6dpg2qO0gasVgd4EhdfbiS+B//Trnfg4UChi3bHq2b1ekRK
	 pPHDKOEfpGblPpXRXfyfkKivN7fmW5GZdqqODs70EZjg00oeKhPIdHql7z4fKvwkmV
	 LM8Rq1Y5FJmmmp8y0kfTOKi+n0RY8o5yMercfcY4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4E6E0F80601; Mon,  2 Nov 2026 20:03:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CBBAF80601;
	Mon,  2 Nov 2026 20:03:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 31B53F8016E; Mon,  2 Nov 2026 20:03:17 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793646196;
	b=RR19TjcdjdrkWppPCk5Ny8K/8sleMUb/6Tdpa/MaFFaHQSW8EIo+19y9h6Uhs4I4AX0h
	 BhKZj1hr/jWXpZRTlDpTmEvOzYWJ3nFPMnae4ZrZvjGOeUqGEMEr6xSq3d3D6HXLFxTrx
	 ASQIzKjhRfPcF4U2OHrKPUFiHq6lh7HV9Kh3f0aHp+fm93ghCZ68jaK86lvIFomJxGCo+
	 PpdPKCjls12gn0NOr58EdLsMu6n8+lo9MGdhpdo3Wi/qus7VNHndSedkkEKist+FKqvfP
	 CK9DmMCbymaTfhpJ2jDlpplIPTDe1PsYzGojB3dj3dt1eiAtSdAImFfeosCiopZORxw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793646196;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=abnWhS7P9xkMO20EB3jqSt3/EuJNalphHi7dHZYXJiM=;
	b=l/OcjP2/5vO+2jjWstwYycuna2uVw6ia4T1y0XtZi8rNzQMWHbksZI5OlVQ6/cLXtIGp
	 Sq2H8YdFcxp18WTduJFtok/TVcHh5ujmUZNROJyd9v4zfWRHULvNBBkMR2HHFNYDt+Wgt
	 TR4wwWwLgU2z5Qb3Gf9PBz7IJ9lHEOlfBqYdGLCBVVNmMxZrVZ3USns4Az0CTfUqH+34N
	 UGLpuMst6MD1HGe3/e3mXnzcwPRwNlijItqaYjGCbmray3ZmC6wO6wAUHPsGXaQCr+c+F
	 ACCQEqf+5MWnz3ZXQoAJ24mcS8jl2VlkIuwUXabS0V3PLny9PMY9qwUgv10aCV1DlsA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 15801F80038
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 20:03:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15801F80038
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e44fb5e7d4e300-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/540@alsa-project.org>
References: <alsa-project/alsa-lib/pr/540@alsa-project.org>
Subject: conf: discover bundled configuration beside the loaded shared library
Date: Mon,  2 Nov 2026 20:03:17 +0100 (CET)
Message-ID-Hash: WHN7EZJPJ72S24BDALNJNG2QX4JIT7QA
X-Message-ID-Hash: WHN7EZJPJ72S24BDALNJNG2QX4JIT7QA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WHN7EZJPJ72S24BDALNJNG2QX4JIT7QA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-lib pull request #540 was opened from Robolightning:

When a shared ALSA library is distributed with its original configuration tree, the compiled build-machine data directory may be unavailable after relocation. Resolve a readable `alsa-config/alsa.conf` beside the actually loaded DSO before falling back to the compiled directory. An absolute explicit `ALSA_CONFIG_DIR` keeps precedence.

Cache an owned path with `pthread_once`. Resolve the DSO from a static local function address so another globally loaded libasound cannot substitute the lookup target. This does not mutate process environment variables or change PCM plugins, exported symbols, or compiled-directory fallback.

Validated on the v1.2.14 source baseline with the original `make check` (configuration and MIDI tests), all 1,835 exported SDK symbols unchanged, and real null/plug:null PCM I/O: four threads, 32,768 frames per case. Separate native processes checked relocated default, explicit user directory, compiled fallback, and explicit-handle use alongside an older globally loaded library. The private producer used the existing `--enable-symbolic-functions` option; no data-symbol binding change is proposed.

The scope is SDK configuration discovery. An unrelated Python extension's external calls can still resolve to an older library explicitly preloaded RTLD_GLOBAL; this change makes no claim to isolate those calls. Physical sound hardware was unavailable.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/540
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/540.patch
Repository URL: https://github.com/alsa-project/alsa-lib
