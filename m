Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34522CD343F
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2026 09:29:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F38A66020A;
	Fri, 15 May 2026 11:29:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F38A66020A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778837393;
	bh=zrFATqRg3iN6CJS5wEEVZdxtTb5Mi3rlSVVJOXYmiY0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vtpFLBzA5PrldEiGwu5eT+Z3TK5swKb24HP14tvl8HTIHBTby/y644RWOrNZXVtXC
	 DEPVxTQwpcGuBZh7FqW6yor/B+KFBLA2tFK4jBdcAmKqe7SdG5/P+0meUSinXjP6Tl
	 mcQ7ygaimAV32CLcNZ+mX7QjafSOJD5YFFnL/0a0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 920D4F805ED; Fri, 15 May 2026 11:29:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C3DFF805F2;
	Fri, 15 May 2026 11:29:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A37EF80557; Fri, 15 May 2026 11:29:10 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 23DE7F800BD
	for <alsa-devel@alsa-project.org>; Fri, 15 May 2026 11:29:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23DE7F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oAAfJDpl
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-367cbac9cb1so6877566a91.3
        for <alsa-devel@alsa-project.org>;
 Fri, 15 May 2026 02:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778837346; x=1779442146;
 darn=alsa-project.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZbRMQ/r8w55rbfPu/3ks70cDm2dftFwxYVIRkr55L4=;
        b=oAAfJDplutGWC6le+YMYEUucaqcH1YmfRsREcgd4Y5jQxBV7LWJhU675rPzLNqm977
         oZRdCH1vsNptqKbtyTD1zUc8xI64Qbkdkem2XErB2nVBIi1fvzK1Oc4CR/kMjqjKYheH
         LL3CSt39PGTnUrWrx+HQkDzVxYi//2sqBLDH546Sz+AINIJ9JCRHbV35lWtUf0foY0fa
         QqYKhvkOqS+lUUvnja233F3Oax0jua2aOIscqb2tcLdr16vAIWPeXEw1V74hGK4mNODN
         g5wGt8LbmVgWcy/tBcWNYaQzNI7xpkCE1QJPGDLfrpXdqBCxKv8Ls+wMXhZQxQwMFAps
         eP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837346; x=1779442146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LZbRMQ/r8w55rbfPu/3ks70cDm2dftFwxYVIRkr55L4=;
        b=U+YrPqj2+4wCRu05smZBgPIbIAsJiUeD8I8IILKuLBvYSTwBpuz0+FNPcjy6k1Xy2e
         AJtFiQjIiWM1C6a6avo1TXzkHBySVjHzNqXNogScjv0MtA0FIwJ8U/UjHSHYffWhqBvj
         hDhPkoOLHqsQlshCJas6tmOTWo92XEmnvV+ixFTuHPz9yvnvftjvgz6/+zkiokStHseD
         eIa4SNILZOqq1p+Nt6+HVriHcCMgq3lgftfCZRxl3FndOJgh8pTcIg+xqgf57zAFCRCR
         gxm+0kzgYDIbU2nEbrrWqVWhqiNDzwvaFOYxW4h6fMPD0jvV6JrSXwPUpiTplq7Ow1RD
         yWOA==
X-Gm-Message-State: AOJu0YzDEq6Ex4J9K4q9/puLGudBFjWqrTL3MwMhnQTIqNUYGcb8FQTG
	W+vDwV1UN6n99TKvEcXaDaEXL+7+37V5wQA7vV9WTnteHWPrGcU9WhilEz36dQ==
X-Gm-Gg: Acq92OEg84FNN/5BY8Ebthtdq6vEBxp9zEaJAeHeQOGX7dTptAi9COfhwc6vAWeo1Hi
	/RBzDFTiIJoVy09XSTf8GFLoB8msZrxQzT3AMxzrfiB+sZ0tLzYqGVSCWQ1O+z4dqd1rCt/Q7gq
	BmkreSgvSv/QTsnZmkJ8zgcMW9sEd9MPCaWCcBiGt0sWAbps2AzUwsz3GA/jtEsRcv6q5ked6UX
	NqytE1TMMEVXNd3eLDF56ZD3dha4swSuOGzvVmcMFu5wyP6YRbRQ6mDJR6/UmxhBZie1M2xEo8m
	l51vwsQonD1wivu+gQTG72x0nG5uEk7XjJVzM9ODzh2CT3IuasBXiDHhVRSFx7YojYOymzuMG+K
	uaeOqNslQEfWMEyvWWrjBpKHjcyjgIcINY1Yo3pynPkZeMlzWiaZK/I0Uj+FOATN7+CcXY5g4ns
	HGrSpt7d+rcTcEq4hj2+Dwxdm8xFryI4aZ2WtNGj99ZSub89t67scOZDQDPJ0NknCXlC1S
X-Received: by 2002:a17:90b:3811:b0:359:1130:1047 with SMTP id
 98e67ed59e1d1-36951b88708mr3045637a91.17.1778837345332;
        Fri, 15 May 2026 02:29:05 -0700 (PDT)
Received: from archlinux (d-203-140-186-253.ftth.katch.ne.jp.
 [203.140.186.253])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369517d8570sm2191870a91.14.2026.05.15.02.29.04
        for <alsa-devel@alsa-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:29:04 -0700 (PDT)
Date: Fri, 15 May 2026 18:29:02 +0900
From: Kay <a3.works@gmail.com>
To: alsa-devel@alsa-project.org
Subject: Re: [BUG] ALC295 internal speaker silent on Panasonic Let's Note
 CF-SV8 (PCI subsys 10f7:8338)
Message-ID: <agbmDHkCiyheGiiQ@archlinux>
References: <afSbGRSm0KSNnoBA@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afSbGRSm0KSNnoBA@archlinux>
Message-ID-Hash: ZNMLBRW4VYDBSCSCT2WEOI3JHOKQ24OM
X-Message-ID-Hash: ZNMLBRW4VYDBSCSCT2WEOI3JHOKQ24OM
X-MailFrom: a3.works@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZNMLBRW4VYDBSCSCT2WEOI3JHOKQ24OM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Closing the loop on this bug report for the list archive.

The root cause turned out to lie entirely outside the ALSA driver. The
codec layer (snd_hda_codec_realtek) was correct all along; no kernel
fixup or patch is needed for this hardware. The actual issue was a
combination of (1) an older BIOS that left the ALC295 codec in a state
that could not drive the internal speaker amplifier at all, and (2) a
userspace ACP path config that unconditionally mutes the speaker mixer
control on every path activation.

(1) BIOS
-------

Panasonic shipped a BIOS update for this model (V2.00L30, dated
2025-06-19) via Windows Update. After applying it, the ALC295 codec
initializes correctly. The "Speaker Playback Switch" then behaves as a
normal Pin 0x14 Amp-Out mute bit, and toggling it on lets audio flow
through the internal speaker as expected.

For others hitting the same symptom on Panasonic Let's Note CF-SV8: a
BIOS update via Windows Update resolved the codec-side issue here, with
no kernel changes required. Older BIOS versions appear to leave the
codec in a state from which the internal speaker cannot be unmuted at
all, even with manual hda-verb writes to Pin 0x14.

(2) Persistence (PipeWire / ACP path config)
-------------------------------------------

After the BIOS fix, the speaker could be unmuted with
`amixer sset Speaker on`, but the "Speaker Playback Switch" was reset
to off on every wireplumber restart and on every boot, leaving the
speaker silent again until manually unmuted.

The cause is in the ACP path config file
/usr/share/alsa-card-profile/mixer/paths/analog-output-speaker.conf,
specifically:

    [Element Speaker]
    required-any = any
    switch = off
    volume = merge

The "switch = off" directive instructs ACP to "always set this control
to off" whenever this path is activated. This config assumes a
classical HD-Audio layout where Master is the master attenuator/mute
and Speaker is a path-selection hint that should be left off. On
ALC295, however, "Speaker" is the per-pin (Pin 0x14) Amp-Out mute bit
of the internal speaker, and Master alone does not gate it. The
unconditional "switch = off" therefore mutes the internal speaker on
every path activation.

Workaround: drop a copy of analog-output-speaker.conf into
/etc/alsa-card-profile/mixer/paths/ and change the [Element Speaker]
directive to "switch = ignore":

    [Element Speaker]
    required-any = any
-   switch = off
+   switch = ignore
    volume = merge

PipeWire's ACP picks up the /etc/ copy in preference to the one under
/usr/share/. After this change, ACP no longer touches the Speaker mixer
control on path activation, the speaker stays unmuted across
wireplumber restarts, warm reboots, and cold boots (including a full
battery-out power cycle), and no other userspace component
(alsa-restore.service, autostart scripts, custom systemd units) is
needed to keep it that way.

Thanks to the list -- lore archives of similar codec quirks were
useful while triaging this.

--
kay-ws
