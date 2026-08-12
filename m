Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054A5C5B572
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:57:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F56B60259;
	Mon, 17 Aug 2026 18:57:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F56B60259
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786985836;
	bh=I5OdS2n+1YMvdnnu3LsM3W/PVzjA7FGqMJwuGtrvDB8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RPUmeuVQKDuQRtwByTcY+X1dUdGtya8esX2IGG9EMK0zRkGbCUIKgUk4TmATp3Cz2
	 oGF4DBGn3ljkKRihgLgKB8elTAsIde6maGYcygsUN8wL/ciNxLf9SFAPJ47/aVsYp2
	 u2hrfpdKefKGbByjX00eih/qxFTelw6wReov0oUY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A39D2F805BD; Mon, 17 Aug 2026 18:56:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 20B6CF80601;
	Mon, 17 Aug 2026 18:56:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 116E8F804CF; Wed, 12 Aug 2026 18:18:42 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786551520;
	b=QvPHeLmvtnOXndVfQsPy0ODOs8rHncDBdllCMhzuLQMGiCvYGpg86DNEmqkw1WqRiCAW
	 36fNMLlmw4rfOuDIECDlE9dpbY7VZRCHlM0SOVfiAbvOpJ4/6dEnhNJAC92Ptxomlafs/
	 9lAGF6VPw3SacyYdy/l0H5mwKmfHWhnDfBptbAcUQvzBxSmzPfwaLbFUIjiqt9iIy3jUV
	 L3esZB4pIJ2Axmb51DcRccd9za3RGvJ0CPdM/RARTOOahWKl1sBO7RE56Uvj9SJ9vtutd
	 IXiXnLJOg4UmL4gc4ZZK+3A9GnySHo6D79h6RzQORac3LGfTodF8xtnY8ry8fzr2eyQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786551520;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=OliJskHFsBjvKXYVDVLcNtyfUS1a+czzrYlLJJ0MQIM=;
	b=QLOr0XUOn57kkxoRRRVhJvH1vNxCU/JPUay6tjoJ0MX0cQb9gKL1hBQBF3wCF8vFzB1J
	 +y8PKEQQ6Eg6PLIGTuUtCWNsDbKygiokAEriCXpU8E+dt2mKDfbTWgBuph5JxOOjtzbhK
	 C0UBh2SD+DgHTdUpRUt9FkqshuPyJpL6fnUgB+SKH6zvItyiVQIWkwFHv+h4+1jGgZ8lx
	 ltV2C2eEi9xnDjwTLMJi6ACVTSSsQpQL4vJ9JVhbLJicNAdbSoaNigz56yUAhH6resIbL
	 x5BiGVUt2wp8V8+c8maz27aQe8fdQtIvcEu0xS1yGdmfskNev1AArPRAisBTf8ehKUQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ns4onbTV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EE803F8010B
	for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2026 18:18:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE803F8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ns4onbTV
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-480033bdcf4so679059f8f.2
        for <alsa-devel@alsa-project.org>;
 Wed, 12 Aug 2026 09:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786551517; cv=none;
        d=google.com; s=arc-20260327;
        b=nRfKWv05Y5TCQSiAKpNC3gex7/N7kz0HIFGz+DmlwYF6u6XEb8mdBDfn00Miy0TJ/n
         IFnberkaHz8YbzEOWgELHNY1DGRMeH2MqQJAvQ9/V2nPwzqOy12gFxqjI6Fg7lC2to1w
         IxVVlmYIkvku7trf7Z49hxDJhTqbbReToVi8o0E8OKcFQ159NSrtXAPKAvN66xylI4sT
         iXAVLkF5ZsKkiuu0WbMwqL4Z8riDtHmymIye32VZbBQ5KpkrBz84imulM4bLPX9KDRlu
         797zBo8u2vLCkfEk1f/eaXeLj5toU6byL3aQWVdq6A0uUpEdrWBGMhpwdZzA3XHcRVTX
         6ZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9SrAckEMYGXjNjS41l+R3ePu2ynNh7uTlDlIWbdcLrQ=;
        fh=q7QbUNWjl5unbJ6oeq6junvxfgnEzyfof3cgzvmbZZc=;
        b=Fc6mg9uKZCh6QMpKKGJ9BZS7MpK+p5QpZ2FaUZ2jX69UTv/IDv+5rPODXqYdGak6Zj
         OjqMnmpyJKur9Qs4/FsJj2LeSuTda2G0/8Hbdj8SYfbcRhLCzt+Av9hV6Gh0V2Ff4Q9c
         pqqoUuzc3RcigGfvSToWP3KcHyJhmzehUIiYPw64BBto4veobXzYrzf4OPK9+WpUSg85
         nT5FQbVTGabwdvDxMsW/rAGStewxLMVGQ8eSnvI6PIIl07N42FDHclxdg1MY8MPYoI4W
         jHD+E5+3ONYpKfPXgVbm4Ev8578sE8u/Fkzgz8NRQOrOC0H9o9LwYzKCcmuKY0+O9Lfj
         3wgg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786551517; x=1787156317;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9SrAckEMYGXjNjS41l+R3ePu2ynNh7uTlDlIWbdcLrQ=;
        b=Ns4onbTVGRPz/GfZaLXV8wqPRDGR8iBHw/WsqYf3XFXdZwexrv3OcVszUxWP2nwfQT
         CFCZNVx/sCko8F6IeFMt2OEcq3K1+w/nXoiD046iyDqLaeNYLNUfNt2idczpnMaAKvaI
         gbTiUe7hJZgP8z/RhNOz+TJwQLUVJjgaFTwi/kOjwjMIcTBfdJiJ/3czR+g0IkQcXd92
         zK5B1wNUcgyuqi0RZP24TnHzB9wXitlb3EMqIxXpusseWoXwdO1Tas250af1e/+fi2mW
         oTOu1W9pue35ROKuj1FFPrbhAGrLpGgMXLnQdGPX4rJAKejm5RAm+ENI++mzMsJ9OvQI
         6Nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551517; x=1787156317;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9SrAckEMYGXjNjS41l+R3ePu2ynNh7uTlDlIWbdcLrQ=;
        b=AbJ+TRelMBCN9yTDX7TobfZGBS4Fm+n9VUw3egtwh86QHf9nlnrsUgmFmhJ1sN0HAj
         qaqrmO6YMoRaJ0Xh51CWDpuV7to0zH6x3Pp6eCoC57G3lcRaPEve93QIdYPkJ3pdcrWF
         NT0eu9hughDd7ZcBx/PuzlmmyNtEcrWhCnxskpIMcgetEcaIhCzSeXdLEBP93hnl04vl
         Lv3Nv81rS6tpZmAZihRmoI2hkduZTWTLkjAlxj42kNXjKUZbpjTN/dgchbCCLry0GHIw
         xaf8YWxwbSYWk//5jBXdwTEMctHmyFqWdDmox8871wJyNfY1jUh87DWrI/mRVmZbazwv
         ra7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoflQtpe/4GesGix4tERMFzL0/6fDf6cpo5KNzQ2lyUUKtNXnp+NnKOlHW0Lo1VRddwKQcn2zoStCmn@alsa-project.org
X-Gm-Message-State: AOJu0YwWvgqAA8ym3jOtJDqDZQENcTz9VIqN68Ae8QUp3cEpYvflHsQl
	r+RqJ3KWc571JTIoXi/rYxI7JKfkO0X0YHUNNc827EJUg1TDBJjFHpNGiicNvUnnUydr08w8NVN
	mVnbQi6i3uYkxFhXRqCZtl6ykEX0tKb4=
X-Gm-Gg: AR+sD12U6w9HlFwB/Cof3AlmsZHWc8bfheqfeQKhhr9VRrHZkywYCxWi5Pd60VKgY0d
	zVf5cu9QEH9dmV27mmiFeQSckrvl/mawm2uMcbdtmcbt8+TShtfepg1Eg/wbdCT5eSacRoot3Tv
	dmAd6dxPB1FgSjxUThaUGvGx+EHXuzeyg+QtYDcKAeOPatL6ES13yI6Eq0D/r88wL1HDIP8xLqr
	dVu8CdgQyWEzqX1RsKy6xbuPF1PLct4e9DScThTD7wZeuoEbr/D0wCAzshJHw5j/+odTPjPqIfu
	5Q/oyPlPvuSOi5D/zG4TZNWyMw2RToxn9VldbiynqGNs
X-Received: by 2002:a05:6000:4a01:b0:480:c5:d635 with SMTP id
 ffacd0b85a97d-4815277aed2mr10594846f8f.0.1786551517037; Wed, 12 Aug 2026
 09:18:37 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAB-5r0nx0fxnvoYqwHHfuGMuXngPk_AuXa=Q2RjCun2xRpt5og@mail.gmail.com>
 <6e623581-664b-4d79-b9de-429b3b433472@amd.com>
 <0e32d0ab-4ab0-44ec-939b-6792e694bd14@amd.com>
In-Reply-To: <0e32d0ab-4ab0-44ec-939b-6792e694bd14@amd.com>
From: Alexandru <eraleexxx@gmail.com>
Date: Wed, 12 Aug 2026 18:18:25 +0200
X-Gm-Features: AUfX_mxwJCM_NWT3bHZDwsnR7Fo7w7KQSnh7SMebeZQDrd8BNeY7DwawCE8dkWQ
Message-ID: 
 <CAB-5r0kAgFS-hxXGh_v4B2f45TMzTMoS0yHxVXSGtCNabNKP2w@mail.gmail.com>
Subject: Re: [PATCH/BUG] ALSA: acp6x: Add DMI/PCI quirk for HP 255R G10
 internal microphone (103c:8d22)
To: Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>, mario.limonciello@amd.com,
	"Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 alsa-devel@alsa-project.org
X-MailFrom: eraleexxx@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 3NKJJE5REWICSATFPOJESKM52I7FH27Q
X-Message-ID-Hash: 3NKJJE5REWICSATFPOJESKM52I7FH27Q
X-Mailman-Approved-At: Mon, 17 Aug 2026 16:56:29 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3NKJJE5REWICSATFPOJESKM52I7FH27Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgU3llZCwgVmlqZW5kYXIsDQoNClRoZSBwYXRjaCB3b3JrcyBwZXJmZWN0bHkhIFRoZSBpbnRl
cm5hbCBkaWdpdGFsIG1pY3JvcGhvbmUgKERNSUMpIGlzIG5vdw0KY29ycmVjdGx5IGRldGVjdGVk
IGFuZCByZWNvcmRpbmcgYXVkaW8gY2xlYXJseSBvbiBteSBIUCAyNTVSIEcxMC4NCg0KYXJlY29y
ZCAtbCBvdXRwdXQ6DQoNCg0KY2FyZCAyOiBhY3A2eCBbYWNwNnhdLCBkZXZpY2UgMDogRE1JQyBj
YXB0dXJlIGRtaWMtaGlmaS0wIFtdDQogIFN1YmRldmljZXM6IDEvMQ0KICBTdWJkZXZpY2UgIzA6
IHN1YmRldmljZSAjMA0KDQpOb3RlIGZvciB2MiBvZiB0aGUgcGF0Y2g6DQpUbyBtYWtlIHRoZSBE
TUkgbWF0Y2ggdHJpZ2dlciBwcm9wZXJseSwgdGhlIHZlbmRvciBzdHJpbmcgbmVlZHMgdG8gYmUN
CiJIZXdsZXR0LVBhY2thcmQiIGluc3RlYWQgb2YgIkhQIiwgYW5kIHRoZSBwcm9kdWN0IG5hbWUg
bmVlZHMgdG8gYmUgIkhQDQoyNTVSIDE1LjYgaW5jaCBHMTAgTm90ZWJvb2sgUEMiLg0KDQpIZXJl
IGlzIHRoZSBleGFjdCBETUkgc3RyaW5nIGZyb20gZG1lc2c6DQoNCiAgICBETUk6IEhld2xldHQt
UGFja2FyZCBIUCAyNTVSIDE1LjYgaW5jaCBHMTAgTm90ZWJvb2sgUEMvOEQyMiwgQklPUyBGLjEx
DQowNC8yMi8yMDI2DQoNCk1hdGNoaW5nIGNvZGUgdXNlZDoNCg0KDQp7DQogICAgLmRyaXZlcl9k
YXRhID0gJmFjcDZ4X2NhcmQsDQogICAgLm1hdGNoZXMgPSB7DQogICAgICAgIERNSV9NQVRDSChE
TUlfU1lTX1ZFTkRPUiwgIkhld2xldHQtUGFja2FyZCIpLA0KICAgICAgICBETUlfTUFUQ0goRE1J
X1BST0RVQ1RfTkFNRSwgIkhQIDI1NVIgMTUuNiBpbmNoIEcxMCBOb3RlYm9vayBQQyIpLA0KICAg
IH0sDQp9LA0KDQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIHF1aWNrIHN1cHBvcnQhDQoNCkJlc3Qg
cmVnYXJkcywNCkFsZXgNCg0KRWwgbWnDqSwgMTIgYWdvIDIwMjYgYSBsYXMgMTI6NDAsIFN5ZWQg
U2FiYSBLYXJlZW0gKDxzeWVkLnNhYmFrYXJlZW1AYW1kLmNvbT4pDQplc2NyaWJpw7M6DQoNCj4N
Cj4gT24gOC8xMC8yNiAxMTowNiwgTXVrdW5kYSxWaWplbmRhciB3cm90ZToNCj4NCj4NCj4NCj4g
T24gOC85LzI2IDE4OjIyLCBBbGV4YW5kcnUgd3JvdGU6DQo+DQo+IEhlbGxvLA0KPg0KPiBUaGUg
aW50ZXJuYWwgZGlnaXRhbCBtaWNyb3Bob25lIChETUlDL1BETSkgb24gdGhlIEhQIDI1NVIgRzEw
IGxhcHRvcCBpcw0KPiBub3QgZGV0ZWN0ZWQvd29ya2luZyB1bmRlciBMaW51eC4NCj4NCj4gU1lT
VEVNIElORk9STUFUSU9OOg0KPiAtIE1vZGVsOiBIUCAyNTVSIEcxMA0KPiAtIENQVTogQU1EIFJ5
emVuIDcgNzczNVUgKFJlbWJyYW5kdC1SIC8gWWVsbG93IENhcnApDQo+IC0gQUNQIFBDSSBEZXZp
Y2U6IDEwMjI6MTVlMiAocmV2IDYwKQ0KPiAtIFN1YnN5c3RlbSBJRDogMTAzYzo4ZDIyDQo+IC0g
VGVzdGVkIEtlcm5lbHM6IDYueCAvIDcueCAoQ2FjaHlPUyAvIEFyY2ggTGludXgpDQo+DQo+IFBS
T0JMRU0gREVTQ1JJUFRJT046DQo+IFRoZSBBTUQgQUNQIDYueCBQQ0kgZGV2aWNlICgxMDIyOjE1
ZTIpIGlzIGJvdW5kIGJ5IHRoZSBgc25kX3BjaV9hY3A2eGANCj4gZHJpdmVyLCBidXQgbm8gQUxT
QSBETUlDL1BETSBQQ00gY2FwdHVyZSBkZXZpY2UgaXMgaW5zdGFudGlhdGVkIChgYXJlY29yZA0K
PiAtbGAgb25seSBsaXN0cyB0aGUgSERBIEFMQzIzNiBjb2RlYykuDQo+DQo+IEluIFdpbmRvd3Ms
IHRoZSBpbnRlcm5hbCBtaWNyb3Bob25lIHdvcmtzIHByb3Blcmx5IHRocm91Z2ggdGhlIEFNRCBB
dWRpbw0KPiBDb1Byb2Nlc3NvciBkcml2ZXIgKGFtZGFjcGJ1cy5zeXMpIHVzaW5nIEhQIERNSUMg
ZXh0ZW5zaW9ucw0KPiAoYGFtZGRtaWNleHR0X2hwXyouaW5mYCkgYW5kIGlzIHByZXNlbnRlZCBh
cyAiTWljcm9waG9uZSBBcnJheSAoQU1EIEF1ZGlvDQo+IERldmljZSkiLg0KPg0KPiBJbiBMaW51
eCwgdGhlIGJvYXJkIHN1YnN5c3RlbSBJRCAoMTAzYzo4ZDIyKSBhcHBlYXJzIHRvIGJlIG1pc3Np
bmcgZnJvbQ0KPiB0aGUgRE1JIG1hdGNoIHRhYmxlIGluIGBzb3VuZC9zb2MvYW1kL3ljL2FjcDZ4
LW1hY2guY2AgKG9yIGVxdWl2YWxlbnQgQUNQDQo+IDYueCBtYWNoaW5lIGRyaXZlcikuDQo+DQo+
IERNSSAvIFBDSSBERVRBSUxTOg0KPiBWZW5kb3IgSUQ6IDB4MTAyMg0KPiBEZXZpY2UgSUQ6IDB4
MTVlMg0KPiBTdWJzeXN0ZW0gVmVuZG9yOiAweDEwM2MNCj4gU3Vic3lzdGVtIERldmljZTogMHg4
ZDIyDQo+DQo+IGBsc3BjaSAtbm5rIC1zIDAzOjAwLjVgOg0KPiAwMzowMC41IE11bHRpbWVkaWEg
Y29udHJvbGxlciBbMDQ4MF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0NCj4g
QXVkaW8gQ29wcm9jZXNzb3IgWzEwMjI6MTVlMl0gKHJldiA2MCkNCj4gU3Vic3lzdGVtOiBIZXds
ZXR0LVBhY2thcmQgQ29tcGFueSBEZXZpY2UgWzEwM2M6OGQyMl0NCj4gS2VybmVsIGRyaXZlciBp
biB1c2U6IHNuZF9wY2lfYWNwNngNCj4gS2VybmVsIG1vZHVsZXM6IHNuZF9wY2lfYWNwNngsIHNu
ZF9zb2NfYWNwNnhfbWFjaA0KPg0KPiBSZXF1ZXN0aW5nIHRvIGFkZCBhIHF1aXJrL2VudHJ5IGZv
ciBETUlfQk9BUkRfTkFNRSAiOEQyMiIgLyBTdWJzeXN0ZW0NCj4gMTAzYzo4ZDIyIHRvIGVuYWJs
ZSBBQ1AgUERNL0RNSUMgc3VwcG9ydCBmb3IgdGhpcyBsYXB0b3AgbW9kZWwuDQo+DQo+IEBrYXJl
ZW06IEFkZCBhIG1hY2hpbmUgZHJpdmVyIHF1aXJrIHBhdGNoIGFuZCBzaGFyZSBpdCBmb3IgdmFs
aWRhdGlvbi4NCj4NCj4gQEFsZXhhbmRydTogUGxlYXNlIGZpbmQgdGhlIGF0dGFjaGVkIHBhdGNo
IGZvciB0aGUgYWRkaXRpb24gb2YgdGhlIERNSQ0KPiBpZCdzLg0KPg0KPiBLaW5kbHkgdGVzdCBp
dCBhbmQgbGV0IHVzIGtub3cgdGhlIHJlc3VsdHMuIE9uY2UgdmFsaWRhdGVkLCB3ZSB3aWxsDQo+
IHVwc3RyZWFtIHRoZSBjaGFuZ2VzLg0KPg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEFsZXgNCj4N
Cj4NCj4NCg==
