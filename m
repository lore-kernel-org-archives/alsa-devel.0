Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E269EB7ED7
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2026 12:16:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AB3060251;
	Wed,  4 Mar 2026 13:16:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AB3060251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772626610;
	bh=PBDVooyzCefiyIitd0M3iDAx0Hg7S0kMyA1mzUb1sZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OEry6VSgW7Rd3kbaJb9p9GQ9KOwSu8397XOmjSe184W3mS1Qb8exQ8bs+eBgeOSqj
	 BLFsMYJiUrLahb1ZTDLtXE146XZCg5q1WdpJUQAXWjCBq+ZPRfnU/jTx0nADE7+fV6
	 ed8nIwlDKXAj8l1rbJb5m7L87f3ETMgKZiQ/5AVU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7BB0FF80611; Wed,  4 Mar 2026 13:16:07 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D77D6F80608;
	Wed,  4 Mar 2026 13:16:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90B8BF8014E; Mon, 23 Feb 2026 09:41:22 +0100 (CET)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1454BF8014E
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2026 09:41:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1454BF8014E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=LyFIHQe8
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-59e60925251so4132101e87.3
        for <alsa-devel@alsa-project.org>;
 Mon, 23 Feb 2026 00:41:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771836064; cv=none;
        d=google.com; s=arc-20240605;
        b=GV2PMrT1xV0HNdmqQDuLaQryPt2N6pnK8rKx7jzX5QqfAwe5Uj2lEobr0d7eMSMjUH
         9ZYeBHUMaKROj1ZL6nFP+CrpOEYYnkIocavR8n4Iu+4Rd1y7Dv/RPtNYDvAGFwbkEQoT
         FoIEliD5QPIik1zXk0qgGr2ZOJDB5SZCQWngYvERHTmISUqPRssXxQppKHlGZ99IRoEU
         40TafOX87ZskVMXV1PPlt9MmWYo0M4zjJh/DkK3JEb+inW9udXOQsOlT5LLsAqTCPEzK
         ZTeqCyANFPQ7fdw6SdB0mOch/1yjE9qqhLkGxXfI2O4WjwLgeTScUvkv8JQpo0Uskjwg
         Kxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kkRpvush5jVJzwdLBsTBICCwVZqeaDt17iAztgOLWrY=;
        fh=+21mFUfsCQHfjg76zILVucSeaxk1lI5HXzIA3PuW5UM=;
        b=eKWn9NFCV9YfnJACB1ghCpDB7o9GojQogtmSv0ptbah6OL6r1AuWfhR+RyJNZF5yMC
         2uPkp9jDJKSgflogXIyT5oEkvhEtmATqIJAtKrew9EyEDCVSqlEfw4oipkX7PFy/vJUI
         UteR7TWxxqNTMK8hPqhIwHZSUV3IKUmFUg4U+qRc+mhovUXC+8+e0uxQCxGqXC1bvDxG
         6Z3UxuaF6l0P5wnpDpSd+FLYyRo5hqKjO5Nu717sYnKjwv1NJrJq2gjxrxQ1OGIqfQxA
         qGRhR0W67r1HQBSBx8F3ePR0oL/qIVzZL/ReIaGyABK+l8rMXuVoMyL7vr6nb3iatzc4
         iMlg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771836064; x=1772440864;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kkRpvush5jVJzwdLBsTBICCwVZqeaDt17iAztgOLWrY=;
        b=LyFIHQe8R54vDXNuHiszWGeMgJJUNvXO5ezlAMWM6fl7cOae7KFmvMsPmRT2yTl5IQ
         1R7lftNN4q8NfyLvlSyfurN0/v8iXr8Tro4ecmVV8qvXLIm9DX7Q4OHR9sXJ8/51JofE
         l05qsFfC0EIgb9R2XSbEhSZnuQEAxmMGMedLvSv6/Oaj0YBW+27jxUGgyuSeypXebScp
         YBuD5f2h8gCR3E63cFYktkO1fSjkxCXjJTzkeCjVnwjcv2b9ydkxNoa4TwWoYnzqQ573
         N+6hrwMQfSRaBHMoqiA8e6xVEOjRmRtccTE0ON6HaLob7Ciecpji+K+vpFnfdEEfUJtL
         yBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836064; x=1772440864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkRpvush5jVJzwdLBsTBICCwVZqeaDt17iAztgOLWrY=;
        b=mIZg4LdMyfKInkNGoLkN85DV0WFE7YqGCguVy2v2JNRGaEq4bJ8RHmoNX9C4IF5p/n
         Ayq1gZBcq0QxisGMOwLUrq/mG3k06HD/bUFnrJMGAHuQumWlxOL2+rCIM1LRednza7zt
         HrYTlA+njlGW1QjUJsadm5CdEH70w0A27HNUzpWTeqvFCQXph8Xf5ptL+Tc4oybtgePa
         XVbDj8c65l7MOZTSXJfdhafjqYETZdSfBf3rHsXtfB+OZK/4mHKOBOwq3yODJeM7bwvQ
         hXo7oAZVldk5uIrvJ5zjouCRGN5hTph84IUepaqFF8QeUF2Sp/IT6fAh5Jy2y0HJSHBc
         WQIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb+s75r1knJqIuHcV99DznKNRGoVnx+hSRh7GREVsQXYCxVOH2jt4JrF68pMkiPgUHkiuiMv6Ct9El@alsa-project.org
X-Gm-Message-State: AOJu0Yxjv8JSozO1K1SFTNhBQr5yeeu6DJa9pVq8Aj7IOv+5I0rwy22S
	Ob4p1y8N1EGJsI+4luIWNYUbaYogck54j/qmA4eteHXldmEgqRg+nbgoZh2kI7s8bLerdGNlBSQ
	aLx34TWkSdhVTewfvx6Td/LIGgiCs8hI=
X-Gm-Gg: AZuq6aLeVcsR+Sv5DS2clJ4Hi03d5jCczdN7B1efEklb7DYSzsAi/dCX9Pcvun3aNUk
	aIXTfmeyqXbmLisW5xYe9SqN6ixF67vif3t0DAQ/u18Zq+h3elUoM5gTDm3fVmKK9G73LrE2/0T
	jNk7PCdp1bMXKHBSy8ZEjGkak7/QuqyAknt15z8BE1gn9T9w1P6g7UVTeRYtTWH71K68EPTApOo
	kypiOBu+hIYbOSiovhlolr0rJZExGWa86ycnB+RrxtlMb/Vvszny650JmJzGKcwrQk2zBd3c7Ql
	4rBob3g=
X-Received: by 2002:a05:6512:104b:b0:59e:5b94:18a6 with SMTP id
 2adb3069b0e04-5a0ed87d6d6mr2154459e87.1.1771836063517; Mon, 23 Feb 2026
 00:41:03 -0800 (PST)
MIME-Version: 1.0
References: <20260201121728.16597-1-tgaraev653@gmail.com>
In-Reply-To: <20260201121728.16597-1-tgaraev653@gmail.com>
From: Honey Tydik <tgaraev653@gmail.com>
Date: Mon, 23 Feb 2026 11:40:45 +0300
X-Gm-Features: AaiRm522cNQuSsqEAwidtC0bTyoZoZxRqFkb4kCMAf8ZAHVBqaZAk7jytv_KaeQ
Message-ID: 
 <CALBQW2vDSzmzdF4vsn8SMvvwFcG4fp3_KG2oZOnJpcX0MspBEg@mail.gmail.com>
Subject: Re: [RFC PATCH] ASoC: Intel: sof_es8336: Add DMI quirk for Huawei
 BOD-WXX9
To: broonie@kernel.org
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
X-MailFrom: tgaraev653@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: GNOHD6XMGCOLBW6FWDQDVITECOBF2BQA
X-Message-ID-Hash: GNOHD6XMGCOLBW6FWDQDVITECOBF2BQA
X-Mailman-Approved-At: Wed, 04 Mar 2026 12:15:58 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GNOHD6XMGCOLBW6FWDQDVITECOBF2BQA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

R2VudGxlIHBpbmcgb24gdGhpcyBSRkMuIEknbSBzdGlsbCBpbnZlc3RpZ2F0aW5nIHdoeSBHUElP
IGNvbnRyb2wgZnJvbQ0KREFQTSBldmVudCBkb2Vzbid0IHdvcmsgb24gSHVhd2VpIEJPRC1XWFg5
LCB3aGlsZSB0aGUgc2FtZSBjb2RlIHdvcmtzDQpmcm9tIHByb2JlIGNvbnRleHQuDQoNCkFueSBm
ZWVkYmFjayBvciBzdWdnZXN0aW9ucyB3b3VsZCBiZSBhcHByZWNpYXRlZC4NCg0KVGhhbmtzLA0K
VGFnaXINCg0K0LLRgSwgMSDRhNC10LLRgC4gMjAyNuKAr9CzLiDQsiAxNToxOSwgVGFnaXIgR2Fy
YWV2IDx0Z2FyYWV2NjUzQGdtYWlsLmNvbT46DQoNCj4gQWRkIERNSSBlbnRyeSBmb3IgSHVhd2Vp
IE1hdGVib29rIEQgKEJPRC1XWFg5KSB3aXRoIEhFQURQSE9ORV9HUElPDQo+IGFuZCBETUlDIHF1
aXJrcy4NCj4NCj4gVGhpcyBkZXZpY2UgaGFzIEVTODMzNiBjb2RlYyB3aXRoOg0KPiAtIEdQSU8g
MTYgKGhlYWRwaG9uZS1lbmFibGUpIGZvciBoZWFkcGhvbmUgYW1wbGlmaWVyIGNvbnRyb2wNCj4g
LSBHUElPIDE3IChzcGVha2Vycy1lbmFibGUpIGZvciBzcGVha2VyIGFtcGxpZmllciBjb250cm9s
DQo+IC0gR1BJTyAyNjkgZm9yIGphY2sgZGV0ZWN0aW9uIElSUQ0KPiAtIDItY2hhbm5lbCBETUlD
DQo+DQo+IEhhcmR3YXJlIGludmVzdGlnYXRpb24gc2hvd3MgdGhhdCBib3RoIEdQSU8gMTYgYW5k
IDE3IGFyZSByZXF1aXJlZA0KPiBmb3IgcHJvcGVyIGF1ZGlvIHJvdXRpbmcsIGFzIGhlYWRwaG9u
ZXMgYW5kIHNwZWFrZXJzIHNoYXJlIHRoZSBzYW1lDQo+IHBoeXNpY2FsIG91dHB1dCAoSFBPTC9I
UE9SKSBhbmQgYXJlIHNlcGFyYXRlZCBvbmx5IHZpYSBhbXBsaWZpZXINCj4gZW5hYmxlIHNpZ25h
bHMuDQo+DQo+IFJGQzogU2Vla2luZyBhZHZpY2Ugb24gR1BJTyBjb250cm9sIGlzc3VlOg0KPg0K
PiBHUElPIHZhbHVlcyBjaGFuZ2UgaW4gZHJpdmVyIChncGlvZF9nZXRfdmFsdWUoKSBzaG93cyBs
b2dpY2FsIHZhbHVlDQo+IGNoYW5nZXMpIGJ1dCBub3QgcGh5c2ljYWxseSAoZGVidWdmcyBncGlv
IHNob3dzIG5vIGNoYW5nZSkuIFRoZSBzYW1lDQo+IGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcCgp
IGNhbGxzIHdvcmsgY29ycmVjdGx5IGluIHByb2JlIGNvbnRleHQgd2l0aA0KPiBtc2xlZXAoKSwg
YnV0IGZhaWwgd2hlbiBjYWxsZWQgZnJvbSBEQVBNIGV2ZW50IGNhbGxiYWNrcy4NCj4NCj4gQ29u
dGV4dCBpbmZvcm1hdGlvbiBmcm9tIGRpYWdub3N0aWNzOg0KPiAtIGluX2F0b21pYz0wLCBpbl9p
bnRlcnJ1cHQ9MCwgaXJxc19kaXNhYmxlZD0wDQo+IC0gUHJvY2VzcyBjb250ZXh0OiBwaXBld2ly
ZQ0KPiAtIEdQSU8gMTcgKHNwZWFrZXJzKTogY2hhbmdlcyBpbiBkcml2ZXIsIG5vIHBoeXNpY2Fs
IGNoYW5nZQ0KPiAtIEdQSU8gMTYgKGhlYWRwaG9uZSk6IGNoYW5nZXMgaW4gZHJpdmVyLCBubyBw
aHlzaWNhbCBjaGFuZ2UNCj4NCj4gSW4gV2luZG93cywgYXVkaW8gc3dpdGNoaW5nIHdvcmtzIHdp
dGhvdXQgdmlzaWJsZSBHUElPIGNoYW5nZXMsDQo+IHN1Z2dlc3RpbmcgcG9zc2libGUgQUNQSS9m
aXJtd2FyZSBpbnZvbHZlbWVudC4NCj4NCj4gQW55IHN1Z2dlc3Rpb25zIG9uIGhvdyB0byBwcm9w
ZXJseSBjb250cm9sIHRoZXNlIEdQSU9zIGZyb20gREFQTQ0KPiBldmVudHMgd291bGQgYmUgYXBw
cmVjaWF0ZWQuDQo+IFNpZ25lZC1vZmYtYnk6IFRhZ2lyIEdhcmFldiA8dGdhcmFldjY1M0BnbWFp
bC5jb20+DQo+IC0tLQ0KPiAgc291bmQvc29jL2ludGVsL2JvYXJkcy9zb2ZfZXM4MzM2LmMgfCA5
ICsrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvc291bmQvc29jL2ludGVsL2JvYXJkcy9zb2ZfZXM4MzM2LmMNCj4gYi9zb3VuZC9z
b2MvaW50ZWwvYm9hcmRzL3NvZl9lczgzMzYuYw0KPiBpbmRleCA3ZGQwMmQ3MDBkN2UuLjhjZWRm
Y2U5OWVkYyAxMDA2NDQNCj4gLS0tIGEvc291bmQvc29jL2ludGVsL2JvYXJkcy9zb2ZfZXM4MzM2
LmMNCj4gKysrIGIvc291bmQvc29jL2ludGVsL2JvYXJkcy9zb2ZfZXM4MzM2LmMNCj4gQEAgLTM2
Myw2ICszNjMsMTUgQEAgc3RhdGljIGludCBzb2ZfZXM4MzM2X3F1aXJrX2NiKGNvbnN0IHN0cnVj
dA0KPiBkbWlfc3lzdGVtX2lkICppZCkNCj4gICAqIGlmIHRoZSB0b3BvbG9neSBmaWxlIGlzIG1v
ZGlmaWVkIGFzIHdlbGwuDQo+ICAgKi8NCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3Rl
bV9pZCBzb2ZfZXM4MzM2X3F1aXJrX3RhYmxlW10gPSB7DQo+ICsgICAgICAgew0KPiArICAgICAg
ICAgICAgICAgLmNhbGxiYWNrID0gc29mX2VzODMzNl9xdWlya19jYiwNCj4gKyAgICAgICAgICAg
ICAgIC5tYXRjaGVzID0gew0KPiArICAgICAgICAgICAgICAgICAgICAgICBETUlfTUFUQ0goRE1J
X1NZU19WRU5ET1IsICJIVUFXRUkiKSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgRE1JX01B
VENIKERNSV9QUk9EVUNUX05BTUUsICJCT0QtV1hYOSIpLA0KPiArICAgICAgICAgICAgICAgfSwN
Cj4gKyAgICAgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9ICh2b2lkICopKFNPRl9FUzgzMzZfSEVB
RFBIT05FX0dQSU8gfA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
U09GX0VTODMzNl9FTkFCTEVfRE1JQykNCj4gKyAgICAgICB9LA0KPiAgICAgICAgIHsNCj4gICAg
ICAgICAgICAgICAgIC5jYWxsYmFjayA9IHNvZl9lczgzMzZfcXVpcmtfY2IsDQo+ICAgICAgICAg
ICAgICAgICAubWF0Y2hlcyA9IHsNCj4gLS0NCj4gMi41Mi4wDQo+DQo+DQo=
