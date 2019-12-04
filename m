Return-Path: <SRS0=elh7=Z2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510F8C43603
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:13:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F2220803
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RQCDIpFn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="fIAE0k0K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="BzRtcW8u";
	dkim=neutral (0-bit key) header.d=ab3.no header.i=@ab3.no header.b="PjUUEIah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F2220803
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=ab3.no
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E21D583E;
	Wed,  4 Dec 2019 14:13:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E21D583E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575465231;
	bh=xTdKxVZjSarDkDNiYinOx6YIAKEhADync5LCFLami00=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RQCDIpFnSzg9JGGAcIz4a1FiuvcnHOJiM+Ayfpk5XQtmR87OFwA65xkWxT1PgUylm
	 Ud3XdNgmAsEWAymlKQJp+slBK8uwAl7jUBaXwVJC1wvumXzf9XF0DD1FKfOUWGnhLj
	 iNZBigvgsthkiG67kQBO8rM3In+QW+5DEc4Dwe+o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68C79F800B4;
	Wed,  4 Dec 2019 14:13:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9D57F801EC; Wed,  4 Dec 2019 14:12:58 +0100 (CET)
Received: from mail.ab3.no (mail.ab3.no [176.58.113.160])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43FE0F800B4
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2019 14:12:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43FE0F800B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="fIAE0k0K"; 
 dkim=fail reason="signature verification failed" (1024-bit key)
 header.d=ab3.no header.i=@ab3.no header.b="BzRtcW8u"; 
 dkim=fail reason="signature verification failed" (1024-bit key)
 header.d=ab3.no header.i=@ab3.no header.b="PjUUEIah"
X-Virus-Scanned: amavisd-new at ab3.no
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no C644A2A3BCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
 t=1575465174; bh=Zt/grgNf4fy+cFv3761Fq2x6YT8ezWD+4NH/vQOH8GE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=fIAE0k0Ko5mYDhq2DP70qDZq6FyxwI8h7jm6wijADucO1gdaEB6DkE1Mz3+3ZOdSR
 cXAbX6lmyFZtC7uQE8tbAtxFShlOybqUjXMAU6Xzu3uO4kBZQ+qsZ0MxH5tMQHRCOS
 XygS31KIS1CXR0+gboWWGdaR4DEV4p5woMs2zTY4=
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no B27D52A3BCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
 t=1575465174; bh=5l6pBmNkoOtpZeGmwMRt+DRrx2q3MydvM4C5feEYUwI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=BzRtcW8uOhUL0EHUMOtqg7kJm6b01S7rtk01pcfXG1SGpIIu0BlL7wResdRellE8X
 XZM+Sa/O2HOGL1y33wT6fv1lG8TUl5NqrXktUq3b/FmbHCMY6f+cXGmD3vLDTdnu5x
 U0VuSWQpH5mZRavmyhOL7pepxusG5EtuY/pazUGo=
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no 2E94D2A3BCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
 t=1575465173; bh=5l6pBmNkoOtpZeGmwMRt+DRrx2q3MydvM4C5feEYUwI=;
 h=To:Cc:References:From:Date:In-Reply-To:From;
 b=PjUUEIah9rWZurXw+dIcOHugUpDQCpwzSnRx1maOmbQXulmaXCOJ7g+SmVUv4rEi0
 b8+0qGgLwlp1pXGes42HUU4Q8rKOR9fbCuyxYc1NP+bb2HtZl6lD4FKgAEcYlHSVTm
 DoCVTZrOlfurQMhUlnNHAk+DaCTugFBQXmb/v32w=
To: Curtis Malainey <cujomalainey@google.com>
References: <CAOReqxjFaWhYCzzyZ90Pc5EvzUky6kCYqakz2XBwSOii9d3maA@mail.gmail.com>
 <6b310509-212e-b887-5e3a-483a740d2d1c@ab3.no>
 <CAOReqxj3P4Kvf5YwTXoEzHd9hURBOP4ySEjURsO7LjK+vbpQTw@mail.gmail.com>
From: =?UTF-8?Q?Mads_L=c3=b8nsethagen?= <mads@ab3.no>
Message-ID: <54e497c2-1266-c4fc-8474-ad8a9cac70bb@ab3.no>
Date: Wed, 4 Dec 2019 14:12:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAOReqxj3P4Kvf5YwTXoEzHd9hURBOP4ySEjURsO7LjK+vbpQTw@mail.gmail.com>
Content-Language: nb-NO
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Dylan Reid <dgreid@google.com>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
Subject: Re: [alsa-devel] Headset button mapping in the kernel
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

Ck9uIDAzLjEyLjIwMTkgMjE6NDMsIEN1cnRpcyBNYWxhaW5leSB3cm90ZToKCj4gSGkgTWFkcyzC
oAo+IAo+IC4uLgo+IAo+IFRoaXMgcHJvamVjdCB3aWxsIGhhdmUgdG8gYmUgdGllZCB0byBBTFNB
IGluIHNvbWUgZmFzaGlvbiAoYXMgeW91IGNhbgo+IHNlZSBpdCBpcyB0aWVkIHRvIHRoZSBqYWNr
IHdoaWNoIGlzIGFuIEFMU0HCoGNvbmNlcHQpLCBidXQgSSBzdGlsbCBoYXZlCj4gdG8gZG8gdGhl
IGRlc2lnbiBkb2NzLiBJbiB0aGVvcnksIHRoaXMgd2lsbCBlbmFibGUgdmFuaWxsYSBsaW51eCB0
byBiZQo+IGNvbmZpZ3VyZWQgZm9yIGFueSBoZWFkc2V0IGJ1dHRvbnMgb25jZSBkb25lLsKgCj4g
CgpUaGFuayB5b3UgZm9yIHJlcGx5aW5nLCBpdCdzIG5pY2UgdG8ga25vdyBhYm91dCB0aGlzIDop
CgotIE1hZHMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHBz
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
