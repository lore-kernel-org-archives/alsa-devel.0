Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69193C43458
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:50:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20D4860226;
	Fri, 10 Jul 2026 08:49:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20D4860226
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783666206;
	bh=vVr1uJDfuyoA1SvRFXbwTzWpg2eJMBPIhqnqJ7g7dWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GbK4q3l4eTB192KmtQuPGqQbhtLmFJ3zG27WspyNi+SOw7Ue8eN2vKcvThPiJHz3U
	 WotVuYl7IBRUKe41grkiTu/Yau1pTeewNAZz/vhyZ9FDC0TciecWTWN1ulAGylDtDT
	 NHvrUkpit0m+RjuwTUkarwoQVOWU5VYwI0hVlRH0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4208F805F5; Fri, 10 Jul 2026 08:49:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D52C5F805FF;
	Fri, 10 Jul 2026 08:49:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF4C8F8057E; Fri, 10 Jul 2026 08:49:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783666161;
	b=QJNTnHJzCg9wJ3S23FJ2wk50IhB7zl8rVjaxlU2t5yT/08EP6v7Pnc0LhBmTuOrOKr5D
	 tV1IAD1kzJFZgARBseYlBjR/9BdEGp2+MgB9rZocADFQWSV6JdSZPAZUKbA2GB10pc9Sh
	 Y0uUbdOKyu7pkijPvM0No+nUuUXOCkgEsIWour1RFOnHny2zAdeyFs3i5Y90H+z4SSZKq
	 jla8B/q+3rVjpOFGWbxP70Z2zu660EDxTxH+PQU9KPZOQeEVhrjt9G+HGX01VRevjeYwU
	 7MN05CjGEtMUPSwH7kzDbk2tk58fxynDy8Xf2UxXOV3yLFz29VVTJ3e8zvl96EwVHfA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783666161;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=vVr1uJDfuyoA1SvRFXbwTzWpg2eJMBPIhqnqJ7g7dWk=;
	b=Li4MJACGXogxl0N3qG1R+N+geZLrBAF3dLIyPtwuRDeSuNZ5hMfJeGBZinscM/8/j6de
	 z3j3hAZ6F4+3RNGCyigMsJmQRowCGVNXORBGf74wA13Qxg1EYWiyP5irZsrajUmjEvUup
	 8mNabPsnrwzDQhbqyfzUU0OulvkdGcLjPcWkUSpTW9tuRcisF2eCb+YvyjokmiB8CBJvQ
	 KL0XuBGrQIlUDNIT85h6PdB+179DDLyk80nHoEgF5iyN5ANWr1i36HRdw6sCDxgXcdNZE
	 0rvzw8hqK0AYPkGnqAuD5MMYXB0erbRHxMr87H9chzD/1wep+blumFzAOFPifbMKMng==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JqOd6Avf;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3068BF800D0
	for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2026 08:49:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3068BF800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=JqOd6Avf
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D9D49414B4;
	Fri, 10 Jul 2026 06:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108EE1F000E9;
	Fri, 10 Jul 2026 06:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783666156;
	bh=6oAdhzaAuRMYdEvKNDBaztOD5HPKtd1DAWVsV2R72yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JqOd6AvfUNOVDcIHEFOKxGbHMhWK/M6gQLv2iqc7a/bGg9vKV1cGPMRAq5QHrPv7r
	 DFBpA1XvlaygWTEru4XKSpOyibfYI9VkCkwTICTrMMXWivUjivOjbxszishWYzNi9h
	 Ax35Lwk+al/KuwMMOc26/XpLO1A+Ccfga13iuxMcObFjyPyKspeKuilHSLOjtwLoHE
	 gYm9cOxIHAV+qjN2dOqQs6XbNzTh+wM+nbjUXKQ/3Rp1T21uGQyXEkkYKCXaIgJrL7
	 FIKnAIP7gs/OgXJP1Zz11qnWci32meZhtKlak3BwfkZ9Jze2ute70rRBaWg/Hbkv4t
	 LCLGkoIJxGlsA==
Date: Fri, 10 Jul 2026 08:49:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 neo.chang70@gmail.com,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v6 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Message-ID: <20260710-fervent-squid-of-speed-b0d078@quoll>
References: <20260708093506.895481-1-YLCHANG2@nuvoton.com>
 <20260708093506.895481-2-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708093506.895481-2-YLCHANG2@nuvoton.com>
Message-ID-Hash: Q5KI4HY5WDTSOJVJB2K4NOZUM7CLL2TM
X-Message-ID-Hash: Q5KI4HY5WDTSOJVJB2K4NOZUM7CLL2TM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q5KI4HY5WDTSOJVJB2K4NOZUM7CLL2TM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Jul 08, 2026 at 05:35:05PM +0800, Neo Chang wrote:
> Add device tree bindings documentation for the Nuvoton NAU83G60
> audio amplifier.
> 
> Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

