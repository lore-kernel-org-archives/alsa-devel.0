Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB88606A322
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=ZjQllq95;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYISZiBD
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3FF36019A;
	Mon,  9 Nov 2026 14:12:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3FF36019A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794229970;
	bh=PcMNJsWMebRPsUJuTo+NQIpzptpfYPUWOVJNZj0OcuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZjQllq95cipYr5r5KhNFnIgK1EABQ2obMOq6xZcWjr9AehINSCBoQRPFi8ljhn3sB
	 NGbcKaD8NeOqS4KB+PQjd7+uB8Xq9uvn9o3qJV71xCWsR45SqsPiXKK2IgNCrO8nxK
	 O6YpTAwx6ezUfM3h2sksjCYzgYxRnnCRpmmd4DU8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD02CF805F5; Mon,  9 Nov 2026 14:12:17 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 29AFEF80600;
	Mon,  9 Nov 2026 14:12:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11B52F805C7; Mon,  9 Nov 2026 14:12:08 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794229926;
	b=TFiCitH4QJ7Fr5KFH5zyw76orA5nUuimqcxkEUo7xNufaEy4z4hvWxc6MW7a3rZrILB3
	 KFXRHxAvJu78IHPZWG/nDnzX1vnZy3yYnhkzCgDgLJQhmJscE7hcjAc5fk+Kl2NRgHlj8
	 H0saykm20QaudTbhHQ9HgTTG0DO1aTtuJbAIM7LFNUX6UNPaZJBtkF7aXzXackiCNcUX0
	 h86AJNc9Cr+cZ6utNTu4pQbpa0FUYTy581OG1a3QdZX+xW0//f4jE36Z5Z+fxcZ/r6ALj
	 vYgSgPd3Vff2dWuRp3M0noG162t/sFs5wH9OU1j4oiGvdWXHfCDO5YFfUbzOqedmb9w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794229926;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=PcMNJsWMebRPsUJuTo+NQIpzptpfYPUWOVJNZj0OcuY=;
	b=gJTqu/ZUaAqko0QEWBaeTO3ZY46YLbU7JNnTbRV3Lj250MFt/Uc3KKWYU05NPfgYggPY
	 NmIAEL8nRYnApyOFrsHeZYftpHxEsPIgxVDOeWn2MbYi4QcUQIJ2uFDaO/u748AGP5pRx
	 8NVqd4CXZV7Iwfmz/K6HNpCtPAHNbPBOoLNkBwq7tfAVD5ov3ln+pNmj2Zq5mIf8Q9nda
	 78aSzMMFhXxlf51ZUcY+2RWsPqY8bRgEkq4wD8wdUNGCeCx0nwP+PjrYm/ggm7lULR5Qn
	 WLuF2Tpiu3x4aKIwHkp67LjWoy8z1v0d4uuNaskrjFsUNBe9Po5GZw1LAYhrv1krjMw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YYISZiBD;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1CDD6F80124
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2026 14:12:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1CDD6F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YYISZiBD
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C06A631E2;
	Mon,  9 Nov 2026 13:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254951F0089F;
	Mon,  9 Nov 2026 13:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794229922;
	bh=URZ/ULk+4PWcUSYqJk0FCIDVu0Cq9bVkhuiXHZozVsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YYISZiBD7mBBiBmdvss79zT5VFDrcBjl3rsasdZGo0XqYSP7aTWYRyXSL5DA1JUx3
	 azU1VX/tkgJEqKYtrt6qU8jGbJtafsHojQ6iQs9YWONiAZ6WvwQxYPAZ0nRBadgo58
	 Nz/ESq7N1Fn0+WDoviLuVmgbVak881v2O+3v4MT82ulYn95wrfHK36w61Z+J1vXl3k
	 29KLq1UkY8TnAymJTWs+LsqhdL4YuFfr7nEqi8g6rjLvTHvS4VnG87AOWQTPbwvGbH
	 NO1bQ6KU5BAjdgd2kua7N/rbucscxeUAuqY0ZtTfX3DYoFC+ddMaw22cYcV6Wf9YnM
	 R6tfM1xGVCKow==
Date: Mon, 9 Nov 2026 14:11:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 neo.chang70@gmail.com,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com, lkp@intel.com
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: nuvoton,nau8310: Add NAU83G10
Message-ID: <20261109-grateful-white-meerkat-090edc@quoll>
References: <20261109051251.471879-1-YLCHANG2@nuvoton.com>
 <20261109051251.471879-2-YLCHANG2@nuvoton.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109051251.471879-2-YLCHANG2@nuvoton.com>
Message-ID-Hash: TLNA4UBON3TJQ344PXRBHXPAELM3HM7B
X-Message-ID-Hash: TLNA4UBON3TJQ344PXRBHXPAELM3HM7B
X-MailFrom: krzk@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TLNA4UBON3TJQ344PXRBHXPAELM3HM7B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Mon, Nov 09, 2026 at 01:12:50PM +0800, Neo Chang wrote:
> +  nuvoton,sar-voltage:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      SAR Gain Tracking Selection.
> +    enum:
> +      - 0 # VDDA
> +      - 1 # VDDA * 1.0
> +      - 2 # VDDA * 1.1
> +      - 3 # VDDA * 1.2
> +      - 4 # VDDA * 1.3
> +      - 5 # VDDA * 1.4
> +      - 6 # VDDA * 1.54
> +      - 7 # VDDA * 3.12
> +    default: 0
> +
> +  nuvoton,sar-compare-time:

Use proper unit suffix from property-units in dtschema.

Also, Sashiko feedback needs to be addressed.

Best regards,
Krzysztof

