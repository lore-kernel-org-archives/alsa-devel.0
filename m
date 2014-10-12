From: =?utf-8?Q?Sh=C3=A9rab?= <Sebastien.Hinderer@ens-lyon.org>
Subject: Re: snd_pcm_hw_params_get_tick_time
Date: Sun, 12 Oct 2014 13:21:57 +0200
Message-ID: <20141012112157.GA14867@pema>
References: <20141011174857.GA7694@pema>
 <543994BB.6000501@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
 by alsa0.perex.cz (Postfix) with ESMTP id F1904260441
 for <alsa-devel@alsa-project.org>; Sun, 12 Oct 2014 13:21:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 4924D200B4
 for <alsa-devel@alsa-project.org>; Sun, 12 Oct 2014 13:21:58 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r4oPwOzXHAye for <alsa-devel@alsa-project.org>;
 Sun, 12 Oct 2014 13:21:58 +0200 (CEST)
Received: from pema.homeunix.org
 (AMontsouris-551-1-36-51.w90-24.abo.wanadoo.fr [90.24.219.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id 29316200B3
 for <alsa-devel@alsa-project.org>; Sun, 12 Oct 2014 13:21:58 +0200 (CEST)
Received: from seb by pema.homeunix.org with local (Exim 4.84)
 (envelope-from <Sebastien.Hinderer@ens-lyon.org>) id 1XdHDp-0003tU-KD
 for alsa-devel@alsa-project.org; Sun, 12 Oct 2014 13:21:57 +0200
Content-Disposition: inline
In-Reply-To: <543994BB.6000501@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

RGVhciBDbGVtZW5zLAoKTWFueSB0aGFua3MgZm9yIHlvdXIgaGVscGZ1bCByZXNwb25zZSEKCj4g
QWxsb3cgbWUgdG8gcHJlc2VudCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbjoKPiAKPiBpbnQg
c25kX3BjbV9od19wYXJhbXNfZ2V0X3RpY2tfdGltZShjb25zdCBzbmRfcGNtX2h3X3BhcmFtc190
ICpwYXJhbXMsIHVuc2lnbmVkIGludCAqdmFsLCBpbnQgKmRpcikKPiB7Cj4gICAgICAgICAqdmFs
ID0gMDsKPiAgICAgICAgIHJldHVybiAwOwo+IH0KCkxPTCEgR29vZCBpZGVhIHRvIGxvb2sgYXQg
dGhlIGNvZGUsIHNvcnJ5IEkgZGlkbmQndCBoYXZlIGl0IG15c2VsZiEKIAo+IFdoYXQgaXMgdGhl
IGVuZ2luZSB0cnlpbmcgdG8gZG8gd2l0aCB0aGlzIHZhbHVlPwoKTG9va2luZyBhdCB0aGUgY29k
ZSBtb3JlIGNsb3NlbHksIGl0IHVzZXMgdGhlIHZhbCBhcmd1bWVudCBpbiBhIHByaW50ZgpiZWZv
cmUgd3JpdGluZyBzb21ldGhpbmcgZWxzZSBpbnRvIGl0IGFuZCBkb2VzIG5vdCB1c2UgdGhlIGRp
ciBhcmd1ZW1udAphdCBhbGwsIHNvIEkgZ3Vlc3MgdGhlIGNhbGwgY2FuIGJlIHNpbXBseSByZW1v
dmVkIGJ1dCBJJ20gZG91YmxlIGNoZWNraW5nCndpdGggdGhlIG90aGVyIGRldmVsb3BlcnMgb2Yg
dGhlZW5naW5lLgoKVGhhbmtzIGZvciB5b3VyIGhlbHAhCgpTaMOpcmFiLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
