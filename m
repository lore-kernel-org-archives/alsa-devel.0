Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD39E606A918
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=XtT+/6tp
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1AE8E60205;
	Mon,  2 Nov 2026 18:11:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1AE8E60205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793639478;
	bh=it3ymwybh3nnX33yb5f428NmUEZvGttEA5nn0NqqNUc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=XtT+/6tp6v0rJHc2N57VA6gFpR/HiUj0lsHY1I98WS8s+pLSTQLi3zWZ9vPff5EKR
	 LxxH92cpcx9Vc2TEwG2hrrbL0nuGUeRDhBxhNtsjCIgK3eLbCeeXjhrQEcG8CrFC71
	 7kiobqOqMuetKiNkSlUh2qNmGnVMyjkPFXUdEzSQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11DB5F805FE; Mon,  2 Nov 2026 18:10:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 36881F805FF;
	Mon,  2 Nov 2026 18:10:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 822A6F8016E; Mon,  2 Nov 2026 18:10:39 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793639438;
	b=kxoBeB/UaPB4rtKAwoEPNYaY/Bp0FVMldaLmd6NYi5x7/8scU52bU7++JqycT5f/J5z0
	 LEFaKG+m7Il0q6ALA5RZDq0Vq+TonhSdVQYvhvOtQh59Cpca6eAYxrFET5J/U8UKrFpL0
	 rzogV0giSshnm8IvlQiD23SdoWHW3S93FI0hbB/Ds5cCbR3DAczCfmNCCk6uS+X8909wj
	 GrPkVrYgvyDDe9T9rK8ypQnnPTOhXjZiuadFx9DysVCPFw00ZeRxTKbmvdBUFToRKxjgl
	 rJvLmaSCSU8j1qEoFyfA5hIjcyZDNCYBdW5JxzsLQtdlCYgHCURI/n3OS5hnFsO7yDg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793639438;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=it3ymwybh3nnX33yb5f428NmUEZvGttEA5nn0NqqNUc=;
	b=WR/RvnpzkIxH9LOdaFLEd+NhDXWxgbjfUkEsesxImvFpiBlHitht1ZjkeCnLTRmVHzoN
	 Ludw6+NsB5/XlOA/vqNTE34LIc+nl5ltPgMyXNcT9t5Txu71ILPFZ8cSBiFmmcSpAmyXO
	 JeIDKmtKKbHDYV4DMMIHxPa3M34cipq3gx3ccqUmPin+HFtdP4EgnlmOmfsIJwL8au92V
	 tLG5DguDehEdAJNMYU6Wk+nEAHRNCB0Twya0DqvxbwnFx5nVFwQcdvuY/XDHqnnC8PuHm
	 vmWucPAoT/KwMUnmgkxbrLYqgLsutajbrFuMkRBi7HQkl3d0TY35AoJvTkRlHjjSUGw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C6753F80038
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2026 18:10:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6753F80038
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e449906ec91b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/900@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/900@alsa-project.org>
Subject: Feat: Enable both speaker paths on ASUS ProArt P14
Date: Mon,  2 Nov 2026 18:10:39 +0100 (CET)
Message-ID-Hash: Z2ZZ465AFCA3SWQ3B2VV7H2337DS5RLC
X-Message-ID-Hash: Z2ZZ465AFCA3SWQ3B2VV7H2337DS5RLC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Z2ZZ465AFCA3SWQ3B2VV7H2337DS5RLC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #900 was opened from Solaris17:

The existing MT8901 configuration enables the CS35L56 bottom speakers but leaves the CS42L43 top speakers silent. Add a P14 H7407BA profile that routes stereo to both paths, enables CS42L43 hardware EQ using ASUS coefficients, and makes speakers and headphones mutually exclusive.

Tested on Ubuntu 26.10: independent top/bottom playback and combined music playback worked.

Related: alsa-project/alsa-ucm-conf#862

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/900
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/900.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
