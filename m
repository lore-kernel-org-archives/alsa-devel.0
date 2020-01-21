Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C747CC2D0CE
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 18:55:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC7524655
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 18:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NINRxWf8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBize4MQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC7524655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96D0D822;
	Tue, 21 Jan 2020 19:54:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96D0D822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579632922;
	bh=4xmmDVkLb1cNjqO8/YEfn4seA77SYUTJuKIuGIxJp8g=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NINRxWf8o7QpzDgPE5iZPBm0Of1EVcUELzTfoDnm8lz7niAqvBNBotSRDd9ZwcLYq
	 WDTx2pBM8VvDqH3K+k0bV7Y8fVYCvO9ZMbLTA3fAM330CPMS+ROdfskK35I0FIczNA
	 dtfEt1Gtdph0OywNgfgaPGSbCJ4a1uRN9Xk3iOxc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F081F8015B;
	Tue, 21 Jan 2020 19:54:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E5E3F801D9; Tue, 21 Jan 2020 19:54:30 +0100 (CET)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87752F800CB
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 19:54:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87752F800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="DBize4MQ"
Received: by mail-ed1-x543.google.com with SMTP id f8so4113019edv.2
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 10:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5wQMTpimvaMznbvYI4EKz0kLTIVvcRzlxme+D5Y8GcY=;
 b=DBize4MQMnv3Ysj1ZktpwCNoe1WJDC7RbzwC954usMDvHcckIHSjCEXz5eXmBDeB+s
 V97xHmAtcjCist0T4VI5yAH5I9dbneqt8IAlpsCoYqE35vvSBDbq3u03Cx9DaFRt13xS
 Kbo3XkLYr0G/kLZcXxAcWYyPtc4+3r1DZbEuTMdHyFPjnBuToubz//YEHw238npUrr0i
 82GAhRd7LcqCZefhm6F2ioFrn0nyDnt5SD7yCGBmJNd1rbG7gQdyfL7amRGpx2S4D20T
 /Na12JL3+X+as27RZ0gzw9rpeLrGmsWlrXzZuRgSpvpRoHkuVxLZAviNFtyx1UQzgTs/
 eYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5wQMTpimvaMznbvYI4EKz0kLTIVvcRzlxme+D5Y8GcY=;
 b=rTQR+WeHvcmELzeJtUDxsCcAvOGUqnhZdt7tDzJWzf7tMR2QjHhPd7+5hHoDxEFwrH
 nMvwWgf/mU3DNZSLJxG+VrYMnOwJuE2XHU70PBZrPpXgEWX7ZMz366YU1ol5DErKhY9n
 TtUKQiVbkVhEiVzs4tyLWUwPA+1gb+c4EH1SS8elBiB7TwIrlCj8CO8M2nbAj0EfKIYj
 9pBMVpmNqigonLUAm/2K+3D4DZmiYGdnB1pTRUmyXjSOFVQxSRrzK6qorRwQlun9IMTq
 +1hBW8Sc+kfxQG3Pyp9jIWkcxkgjd4H0F04IgA6o/1FdUW7NKBmqtIK++zQuA6WqhbTy
 oeDw==
X-Gm-Message-State: APjAAAXYezi73Y4MiZ0DDnONGZzu3OM8X5rWMzQx4GnOgezrUI2M8OcE
 PVZE3klt3XDBrishZthHRcKRsp6c
X-Google-Smtp-Source: APXvYqyv9SiwDSHiz7Kv9vtIi33Q50o8KMKFstas+IBpjmjlZTguMS/DRKhqx9SlW2d+WdUEJkAldA==
X-Received: by 2002:a17:906:a859:: with SMTP id
 dx25mr5713348ejb.226.1579632866508; 
 Tue, 21 Jan 2020 10:54:26 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru.
 [79.139.233.37])
 by smtp.googlemail.com with ESMTPSA id j63sm1367192edd.81.2020.01.21.10.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 10:54:26 -0800 (PST)
To: Ben Dooks <ben.dooks@codethink.co.uk>, Jon Hunter <jonathanh@nvidia.com>
References: <20191018154833.7560-1-ben.dooks@codethink.co.uk>
 <b4e2ec44-bc89-b5ca-cfa7-a6d5c45a9c94@codethink.co.uk>
 <a11ba33e-5ffb-c5c6-04f5-0e031877c55f@gmail.com>
 <621fa27d-9259-2949-9cf5-d2eda5cb0677@gmail.com>
 <a0f027d9-e9e0-d76c-1e40-002fdc37eb5f@nvidia.com>
 <d43d518d-9336-a011-2a69-3f9331f6d0b4@codethink.co.uk>
 <aba4edd6-0ea5-5e95-c5a0-9e749587c763@nvidia.com>
 <449bdc3c-bf82-7cc4-6704-440dd100ca3a@gmail.com>
 <5d3ae629-5d30-0930-5dd1-15161e64926e@codethink.co.uk>
 <9daeeb94-2b90-18b8-2e1e-daae5acf079d@gmail.com>
 <fd73f68c-80f5-ac80-f6e4-42256d3df76d@codethink.co.uk>
 <37beb96a-a525-c72f-a7e1-e9ef5d61f3b2@gmail.com>
 <29db3df4-6f51-7c0f-1eef-90171f1d233a@codethink.co.uk>
 <9a5447e2-155c-7e6e-b8f1-95523c6f42c6@gmail.com>
 <b4a416fb-f2b1-660d-27e3-aebf602178f9@codethink.co.uk>
 <680e2dfd-6f4f-5c96-63b7-97520961dc82@gmail.com>
 <0e0cd260e39ad293edb881da1c565510@codethink.co.uk>
 <eb90ee78-e462-401a-de60-4a9bfc2a00c4@nvidia.com>
 <9fc97644-b679-ef9f-41ca-1d3a5f296f3a@codethink.co.uk>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <01154788-89a6-8937-130c-4618c105d409@gmail.com>
Date: Tue, 21 Jan 2020 21:54:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9fc97644-b679-ef9f-41ca-1d3a5f296f3a@codethink.co.uk>
Content-Language: en-US
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Edward Cragg <edward.cragg@codethink.co.uk>, linux-tegra@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v5 2/7] ASoC: tegra: Allow 24bit and 32bit
 samples
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

MjEuMDEuMjAyMCAyMToxNSwgQmVuIERvb2tzINC/0LjRiNC10YI6Cj4gT24gMDcvMDEvMjAyMCAx
MDoyOSwgSm9uIEh1bnRlciB3cm90ZToKPj4KPj4gT24gMDUvMDEvMjAyMCAxMDo1MywgQmVuIERv
b2tzIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAyMDIwLTAxLTA1IDAxOjQ4LCBEbWl0cnkgT3NpcGVu
a28gd3JvdGU6Cj4+Pj4gMDUuMDEuMjAyMCAwMzowNCwgQmVuIERvb2tzINC/0LjRiNC10YI6Cj4+
Pj4+IFtzbmlwXQo+Pj4+Pgo+Pj4+PiBJJ3ZlIGp1c3QgZ29uZSB0aHJvdWdoIHRlc3RpbmcuCj4+
Pj4+Cj4+Pj4+IFNvbWUgc2ltcGxlIGRhdGEgdGVzdHMgc2hvdyAxNiBhbmQgMzItYml0cyB3b3Jr
Lgo+Pj4+Pgo+Pj4+PiBUaGUgMjQgYml0IGNhc2Ugc2VlbXMgdG8gYmUgd2VpcmQsIGl0IGxvb2tz
IGxpa2UgdGhlIDI0LWJpdCBleHBlY3RzCj4+Pj4+IDI0IGJpdCBzYW1wbGVzIGluIDMyIGJpdCB3
b3Jkcy4gSSBjYW4ndCBzZWUgYW55IHBhY2tpbmcgb3B0aW9ucyB0bwo+Pj4+PiBkbyAyNCBiaXQg
aW4gMjQgYml0LCBzbyB3ZSBtYXkgaGF2ZSB0byByZW1vdmUgMjQgYml0IHNhbXBsZSBzdXBwb3J0
Cj4+Pj4+ICh3aGljaCBpcyBhIHNoYW1lKQo+Pj4+Pgo+Pj4+PiBNeSBwcmVmZXJlbmNlIGlzIHRv
IHJlbW92ZSB0aGUgMjQtYml0IHN1cHBvcnQgYW5kIGtlZXAgdGhlIDMyIGJpdCBpbi4KPj4+Pj4K
Pj4+Pgo+Pj4+IEludGVyZXN0aW5nLi4gSm9uLCBjb3VsZCB5b3UgcGxlYXNlIGNvbmZpcm0gdGhh
dCAyNGJpdCBmb3JtYXQgaXNuJ3QKPj4+PiB1c2FibGUgb24gVDMwPwo+Pj4KPj4+IElmIHRoZXJl
IGlzIGFuIG9wdGlvbiBvZiAyNCBwYWNrZWQgaW50byAzMiwgdGhlbiBJIHRoaW5rIHRoYXQgd291
bGQKPj4+IHdvcmsuCj4+Pgo+Pj4gSSBjYW4gdHJ5IHRlc3RpbmcgdGhhdCB3aXRoIHJhdyBkYXRh
IG9uIE1vbmRheS4KPj4KPj4gSSB3aWxsIGNoZWNrIG9uIHRoaXMuIEkgd291bGQgaGF2ZSB0aG91
Z2h0IHRoYXQgUzI0X0xFICgyNC1iaXRzIHBhY2tlZAo+PiBpbnRvIDMyLWJpdCBlbGVtZW50cykg
d291bGQgYmUgZmluZS4gVHlwaWNhbGx5IHdlIGRvbid0IHN1cHBvcnQgUzI0XzNMRQo+PiAoMjQt
Yml0cyBpbiAyNC1iaXQgZWxlbWVudHMpLgo+Pgo+IAo+IEkndmUganVzdCBoYWQgdG8gc3BlbmQg
dGltZSBmaXhpbmcgcHVsc2V2aWV3L3NpZ3JvaydzIGkycyBoYW5kbGluZyBmb3IKPiB0aGlzLCBi
dXQgaGF2ZSBydW4gYSBzaW1wbGUgdGVzdCBvZiBTMjRfTEUgdXNpbmcgYSBwYXR0ZXJuIGdlbmVy
YXRvcgo+IGFuZCB0aGUgbG93IGxldmVsIG91dHB1dCBsb29rcyBvay4KPiAKPiBJIHdpbGwgdGVz
dCBhIGJpdCBtb3JlIHRvbW9ycm93LCBidXQgSSBzdXNwZWN0IHNvbWV0aGluZyBlbHNlIGlzIGVp
dGhlcgo+IGdldHRpbmcgUzI0X0xFIHdyb25nIG9yIHdlIGhhdmUgc29tZSBvdGhlciBpc3N1ZS4K
Ck9rYXksIHRoYW5rcyBmb3IgdGhlIHVwZGF0ZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBh
bHNhLXByb2plY3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8vYWxzYS1kZXZlbAo=
