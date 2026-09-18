Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A75C982D7
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:34:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84503601FC;
	Fri, 18 Sep 2026 20:34:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84503601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789756458;
	bh=L7PsXAdEga2lJmEvEtq8DEze2VMF/heAs09jTZSnvCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bqetnl4XLAAvH7k+Jf7mb9dlqEOF+EgicBM9nyjHh5aLjn5xoCs+2/4eOGxwCwhqE
	 xXfQwpswTnFjsxDlOdF3waCHeeDgvgOXlq12UXC8hSSYvxhf22HRrfHFRCoRMjAUj7
	 rRdyrY/EV8GB7jmxWpmzT3E8EpwlIe103SWMihug=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 249E3F80580; Fri, 18 Sep 2026 20:33:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 68ECDF805F9;
	Fri, 18 Sep 2026 20:33:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E53E4F80571; Fri, 18 Sep 2026 20:33:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789756412;
	b=T09Sgb4CsJmvLOPOJhRV4mBkyfuP+w4deIBEBuz9N0iaW9FVoBFnZMWVenpRV7BMXAG4
	 Q+YKa1s5mEsAaTP/SMbxKkp96w3iub0sJlvDCq2s9KB7X5qGTC2EUfEpOglzj9hOwh6td
	 JZmS1XvQZ2BweAPa0X34maFBWKy6NLyX5JuUwrIgB75c4JTbaECaDa6MOhmFc9EycYcV4
	 06vmYlmiKVkdqUl32Yd1cgkW4s/oBdkWApsyg2rMGcAIBG/sMSOSWlFmWdxBjHunxVPus
	 vzqQkNymSfCQbOYl787+fRCRQGaUOdCKJRuMZRJNxwgHoy5v2Bl7pYc6gyzEJhw/OlA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789756412;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=L7PsXAdEga2lJmEvEtq8DEze2VMF/heAs09jTZSnvCA=;
	b=Z32cg6as+x1PmW6mCeEkgjk3eSzxfsObGIxuGzZ5c6oxK6bgTOpOoCaaeC+esnPr9Iy1
	 Lilu3GpzFKwbNOAz2gMqPWMN+ZtRGMODcKnWAvI4BRgiCPjDvkPDt60Lddt39pgYGrL+X
	 AZdZ319nnY1NeS8COEzErfjnt1C/zLlItiJdV3hEQK0TOr6Kw8RFCVaMDyOXscYcKkwcd
	 7mpVFGtp4cEQNXrx6MyHFTz//JrJPOxSMjZAB05nA8R9Dd/+vpMZtfEj0r+GoxsbmHETr
	 P+YBqYm6+DVbE9I7LTfHHDXBy3v2xiFsWH+9Fp8yv4YDP7oltirmc52RNWBLXcSVTFQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=yPjoNs89;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3BBD8F80088
	for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2026 20:33:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BBD8F80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yPjoNs89
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=DLnOD92O0mvyMHKGbRAZQQhIOnSZOnx1HdrRVCsT2r4=; b=yPjoNs89exrslITOnBnceWqFaw
	CB3i5/fvlqVlCsRVPfz3JfPdhXJnHbmUPNXkWBqYEN1W4DL1GD52hsZEPDP3+qc+e513Uta6rzm3N
	2rvNKOuhvdcLxKao17Gln4coU8+oCmUlBA/T9sF6UzyWgyg9pYaaOLm2xJcW65qNKmbueJGLDbDUJ
	N3YDzAQz6LzRXRE2f+PnTNS6RccGuJ9tccgIHV7LqcFjcgpzWh9XDryjIrc+4x+IdMIB/kHJJPiTW
	PRXQHadEGe1ay+lu0gthZUljm4BibBD4klLSAWqBLskON4Chb9I9vJl1uC0GtkNSujIBklvXmkKcm
	8VuN8Dfw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7dOo-0000000FK57-36zQ;
	Fri, 18 Sep 2026 18:33:26 +0000
Message-ID: <c854ef1b-04c9-44ae-adc6-f8c34731bfff@infradead.org>
Date: Fri, 18 Sep 2026 11:33:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 8/8] Documentation: sound: add the Babyface Pro
 proprietary-mode design doc
To: =?UTF-8?Q?Isma=C3=AFl_Bahloul?= <i.bahloul01@gmail.com>,
 linux-sound@vger.kernel.org
Cc: linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
 tiwai@suse.com, linux-kernel@vger.kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org
References: <20260918113944.76871-1-i.bahloul01@gmail.com>
 <20260918113944.76871-9-i.bahloul01@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260918113944.76871-9-i.bahloul01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YIW67T2ODTQOTXQQRENSTEXWS7N6BZ74
X-Message-ID-Hash: YIW67T2ODTQOTXQQRENSTEXWS7N6BZ74
X-MailFrom: rdunlap@infradead.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YIW67T2ODTQOTXQQRENSTEXWS7N6BZ74/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,
Just one nit below...

On 9/18/26 4:39 AM, Ismaïl Bahloul wrote:
> A big-picture companion to the patch series, for human reviewers:
> why the proprietary mode needs a standalone driver instead of a
> snd-usb-audio quirk, the vendor protocol's write-only/no-readback
> shape and what that forces onto the driver, the asynchronous stream
> model, why the mixer state has to be cached and replayed, and why
> the driver has to emulate TotalMix's own role for the front panel.
> 
> Requested by Takashi Iwai's v4 review: documentation for reviewers,
> not restating what the code comments already say inline.
> 
> Signed-off-by: Ismaïl Bahloul <i.bahloul01@gmail.com>
> ---
>  Documentation/sound/cards/babyface-pro.rst | 163 +++++++++++++++++++++
>  Documentation/sound/cards/index.rst        |   1 +
>  2 files changed, 164 insertions(+)
>  create mode 100644 Documentation/sound/cards/babyface-pro.rst
> 
> diff --git a/Documentation/sound/cards/babyface-pro.rst b/Documentation/sound/cards/babyface-pro.rst
> new file mode 100644
> index 000000000..d67f8c6fe
> --- /dev/null
> +++ b/Documentation/sound/cards/babyface-pro.rst
> @@ -0,0 +1,163 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================================================
> +RME Babyface Pro / Pro FS (snd-usb-babyface-pro)
> +=================================================
> +
> +This document describes the design of the ``snd-usb-babyface-pro``
> +driver for reviewers who need the big picture before reading the
> +patches - what problem the driver solves, why it is a standalone
> +driver instead of a snd-usb-audio quirk, and the four design
> +decisions (stream model, protocol shape, mixer-state persistence,
> +front-panel emulation) that shape most of the code.  The patch series
> +itself is split by feature (core+PCM, then masters+crosspoint,
> +preamp, routing flags, suspend/resume, front panel, DSP EQ, in that
> +order) so each patch can be read and built on its own; this document
> +does not repeat what each patch's own commit message already covers.
> +
> +Two USB personalities, one device
> +==================================
> +
> +The RME Babyface Pro and Babyface Pro FS present two different USB
> +configurations depending on a physical/firmware switch: a
> +class-compliant one, already handled by ``snd-usb-audio``, and a
> +proprietary one (USB ID ``2a39:3fc0``) that this driver covers.  The
> +two hardware models share the same USB ID, ``bcdDevice`` and
> +``iProduct`` string shape; nothing in the descriptors tells them
> +apart, and the driver runs unmodified on both.
> +
> +In proprietary mode, interface 5 carries the PCM stream on two
> +INTERRUPT endpoints (``0x01`` OUT, ``0x82`` IN) instead of the
> +isochronous endpoints the USB Audio Class specifies.  Isochronous
> +transfers are rejected there with ``-EINVAL``.  ``snd-usb-audio`` has
> +no interrupt-PCM transport, so this mode cannot be a quirk on top of
> +it; the driver is standalone, modelled on ``snd-usb-caiaq`` (another
> +interrupt-streaming RME/NI-style device).
> +
> +Why interrupt endpoints and not isochronous is a hardware/firmware
> +choice on RME's side, not something this driver can change - the
> +class-compliant mode already exists on the same device for users who
> +want a fully standard, quirk-free path with a subset of the
> +functionality (no mixer, no front panel).  This driver is for users
> +who want the full mixer, routing matrix, and hardware DSP EQ that
> +only the proprietary mode exposes.
> +
> +The vendor protocol: writes only, no readback
> +==============================================
> +
> +Every mixer and clock function is one of a handful of USB vendor
> +control requests (``bmRequestType 0x40``, i.e. host-to-device,
> +vendor, device-recipient), each identified by its request number and
> +a 16-bit value/index pair - there is no larger command structure.
> +The commonly used ones are:
> +
> +======  ========================================
> +0x10    settings word / stream start trigger
> +0x12    16-bit crosspoint and output-master writes
> +0x16    cold-init register clear
> +0x17    front-panel + preamp state (read and write)
> +0x1a    8-bit gain / output-master companion writes
> +0x1b    clock DDS quads (base rate and varispeed)
> +======  ========================================
> +
> +The full register map, decoded from Windows USB captures and
> +cross-checked against hardware, lives in the driver's own development
> +repository (not shipped in-tree) - the constants and the comments
> +next to each vendor write in the source are the authoritative
> +in-tree reference.
> +
> +The one property that shapes the rest of the driver: **almost nothing
> +here is readable back**.  The 0x17 request returns the front-panel

   here can be read back**.

> +and preamp state, but the crosspoint matrix, the output masters, the
> +routing flags and the clock all have to be tracked host-side - the
> +device will accept a write blindly and never confirm what it actually
> +holds.  Two consequences follow directly from this:
-- 
~Randy

