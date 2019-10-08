Return-Path: <SRS0=gTnd=YB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7BEC4360C
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:01:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2380B206BB
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UYQPwMdm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oKCYXWE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2380B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64A0E850;
	Tue,  8 Oct 2019 13:00:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64A0E850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570532479;
	bh=EsLLjljTTh3W7HiiFYp1N1tr0Gq0/xb8Pu10xrqQw7I=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UYQPwMdmHFVAvXe0hhReqPfFGjkzsSxbuo6zKFLNd7h8w3W5JbyBN2cjEUPfT0CII
	 AaPiB6Qee2s0YHXh6g2I4sjS06HGOpFL67eDRjpg3ormhcoJS3Fm6q3WwNddTxuPzH
	 5INnSezojejpyNuWgDAReN0slWJT5Fy/0GfC6gQM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE632F80322;
	Tue,  8 Oct 2019 13:00:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1788F8038F; Tue,  8 Oct 2019 13:00:27 +0200 (CEST)
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com
 [IPv6:2607:f8b0:4864:20::e42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F10DF80113
 for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2019 13:00:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F10DF80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="oKCYXWE9"
Received: by mail-vs1-xe42.google.com with SMTP id d204so10970647vsc.12
 for <alsa-devel@alsa-project.org>; Tue, 08 Oct 2019 04:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=s7KHCS6KC1Tl40GL5iXixVsuoc97CWY0yIdoZ4HB+JY=;
 b=oKCYXWE9YUO5Q+gyNopdJFXbgLDXR7oiJicNzI/yWRRlhKf08+wDdVtaEe9O3Gk+/H
 QfoFqwKIuROipl97GM/bv7m7KwteJvhV2Av/d4xo0Sy5MsJwEbrNxOUtTGAQN5gZEubg
 gUiU53zHUBitzPDqCFh/8t47BMri1iPt7V35M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s7KHCS6KC1Tl40GL5iXixVsuoc97CWY0yIdoZ4HB+JY=;
 b=OYSgeOopJZAUWrjkg3i9FJbMOvfrLiUwC4ZV8AlMRqFbcMx79HmafoaLfTmuyfLnqC
 GZ3s3/7etOW0qiMwJh2yGoi06aBUUNnGjMR0/ECKgg5m1tkCxthWj0sZwE2mGFTldTBw
 BWjuOJbhvYKzqwPU+oT0vU9WsYVXucwEcy+Sh/LAQXiXMWuZUOP7X8F2p59uAvQAqCXy
 rg5d1ttS7p5tqGo2/OLAcclv7oXEI14N2juBCQOl/17D1kbh9IAS2PuoVc3vZYTczZ1N
 b6onBGvCgrhEk4AxgdJkIdlSLnFHrGI1pzI/IZ37f/FN7gDq0VZjXDoTsgeVCZBG7Jib
 6X7g==
X-Gm-Message-State: APjAAAXhI8plU3CwsAQLHRJPDAUMwX1Jej5krVIcyp9eGsGWYkzvAK2c
 WXdgB6LTpaEPFQ+CkpaA+xVy5OWjO3yAyZSzx1DziA==
X-Google-Smtp-Source: APXvYqww5oLx8OBE+dN9EZyS/u9edZb/af+cZyO9+LWoC0jUUiUIt/0n8QV3FeRe0MC2PvuYFFfZi7l2V/Cfgb0y1+E=
X-Received: by 2002:a67:c20c:: with SMTP id i12mr18376167vsj.138.1570532423307; 
 Tue, 08 Oct 2019 04:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <8f933cee57fc4420875e1e2ba14f1937@realtek.com>
 <20191008105138.GC4382@sirena.co.uk>
In-Reply-To: <20191008105138.GC4382@sirena.co.uk>
From: Cheng-yi Chiang <cychiang@chromium.org>
Date: Tue, 8 Oct 2019 18:59:57 +0800
Message-ID: <CAFv8NwJ+g+ESJJ5JxaLHADhBASKsjTE7pqY=HhcZZcT2Yy+Ygw@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 =?UTF-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>, Cheng-Yi Chiang <cychiang@chromium.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt1011: export r0 and temperature
	config
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

T24gVHVlLCBPY3QgOCwgMjAxOSBhdCA2OjUxIFBNIE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVs
Lm9yZz4gd3JvdGU6Cj4KPiBPbiBUdWUsIE9jdCAwOCwgMjAxOSBhdCAwOTozMzoyNEFNICswMDAw
LCBTaHVtaW5nIFvojIPmm7jpiphdIHdyb3RlOgo+Cj4gPiBJbiBjaHJvbWVib29rIGNhc2UsIHRo
ZSBtYWNoaW5lIGRyaXZlciB3aWxsIGdldCB0aGUKPiA+IHIwIGNhbGlicmF0aW9uIGRhdGEgYW5k
IHRlbXBlcmF0dXJlIGZyb20gVlBELgo+ID4gVGhlcmVmb3JlLCB0aGUgY29kZWMgZXhwb3J0cyBy
MCBhbmQgdGVtcGVyYXR1cmUgY29uZmlnIEFQSSBmb3IgaXQuCj4KPiBXaHkgd2lsbCB0aGUgbWFj
aGluZSBkcml2ZXIgZG8gdGhpcz8KCkhpIE1hcmssClRoZSBjYWxpYnJhdGlvbiBkYXRhIChSMCB2
YWx1ZXMgYW5kIHRlbXBlcmF0dXJlKSB3ZXJlIG1lYXN1cmVkIGFuZAp3cml0dGVuIHRvIFZQRCBp
biB0aGUgZmFjdG9yeS4gV2hlbiBtYWNoaW5lIGRyaXZlciBpbml0aWFsaXplcyBzb3VuZApjYXJk
LCBpdCByZWFkcyB0aGUgdmFsdWUgZnJvbSBWUEQgYW5kIHVzZXMgdGhlIGV4cG9ydGVkIEFQSSB0
byBzZXQKY2FsaWJyYXRpb24gdmFsdWUgZm9yIGNvZGVjLiBUaGUgcHVycG9zZSBpcyB0byBwcm90
ZWN0IHNwZWFrZXIuIFRoaXMKbmVlZHMgdG8gYmUgZG9uZSBiZWZvcmUgc291bmQgY2FyZCBpcyBp
bml0aWFsaXplZC4gSWYsIGFsdGVybmF0aXZlbHksCnRoaXMgcHJvY2VzcyBpcyBkb25lIGluIHVz
ZXIgc3BhY2UgdGhyb3VnaCBtaXhlciBjb250cm9sIGFmdGVyIHRoZQpzb3VuZCBjYXJkIGlzIGlu
aXRpYWxpemVkLCB1c2VyIHNwYWNlIG1heSB1c2UgYXVkaW8gYmVmb3JlIGNhbGlicmF0aW9uCmlz
IGRvbmUsIGFuZCB0aGlzIHdpbGwgYWxsb3cgdGhlIHBvc3NpYmlsaXR5IHRvIGRhbWFnZSBzcGVh
a2Vycy4KSG9wZSB0aGlzIGNsYXJpZmllcyB0aGUgaW50ZW50aW9uIG9mIHRoaXMgcGF0Y2guClRo
YW5rcyEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHBzOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
