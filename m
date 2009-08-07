From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [BUG] NULL pointer dereference in patch_sigmatel.c
Date: Fri, 7 Aug 2009 10:43:07 +0100
Message-ID: <ad2655cb0908070243h6318dbdep80d90a08fa6c435b@mail.gmail.com>
References: <4A5F84D6.5040708@pardus.org.tr> <s5h1vofac2z.wl%tiwai@suse.de>
	<s5hy6qn8wyj.wl%tiwai@suse.de> <4A7ADD87.4030109@pardus.org.tr>
	<s5hfxc5114w.wl%tiwai@suse.de> <4A7BF4F7.20405@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 765A41038F5
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 11:43:07 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so355240fga.21
	for <alsa-devel@alsa-project.org>; Fri, 07 Aug 2009 02:43:07 -0700 (PDT)
In-Reply-To: <4A7BF4F7.20405@pardus.org.tr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

MjAwOS84LzcgT3phbiDDh2HEn2xheWFuIDxvemFuQHBhcmR1cy5vcmcudHI+Ogo+Cj4gQWRkZWQg
dGhlIGZvbGxvd2luZyBsaW5lczoKPgo+IHByaW50ayhLRVJOX0lORk8gIjB4JXBcbiIsIGphY2sp
Owo+IHByaW50ayhLRVJOX0lORk8gIjB4JXBcbiIsIGphY2stPmphY2spOwo+IHByaW50ayhLRVJO
X0lORk8gIjB4JXBcbiIsIGphY2stPmphY2stPnByaXZhdGVfZGF0YSk7Cj4KPiBkbWVzZzoKPgo+
IE5WUk06IGxvYWRpbmcgTlZJRElBIFVOSVggeDg2IEtlcm5lbCBNb2R1bGUgwqAxODAuNTEgwqBU
aHUgQXByIDE2IDE5OjAyOjE1Cj4gUERUIDIwMDkKPiBBQ1BJOiBQQ0kgSW50ZXJydXB0IDAwMDA6
MDA6MWIuMFtBXSAtPiBHU0kgMjIgKGxldmVsLCBsb3cpIC0+IElSUSAyMgo+IFBDSTogU2V0dGlu
ZyBsYXRlbmN5IHRpbWVyIG9mIGRldmljZSAwMDAwOjAwOjFiLjAgdG8gNjQKPiAweGY3NzdhNjE0
Cj4gMHgwMDAwMDAwMAo+IEJVRzogdW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVy
IGRlcmVmZXJlbmNlIGF0IDAwMDAwMDc0Cj4gSVA6IFs8ZjkzZjJkOTc+XSA6c25kX2hkYV9jb2Rl
Y19jb25leGFudDpjb25leGFudF9hZGRfamFjaysweDU3LzB4ODEKPiAqcGRlID0gMDAwMDAwMDDC
two+IE9vcHM6IDAwMDAgWyMxXSBTTVAKPgoKTmVlZCBtb3JlIG9mIHRoZSBkbWVzZyBvdXRwdXQu
CkkuZS4gdG8gc2VlIHdoaWNoIHByaW50IHN0YXRlbWVudHMgc3VjY2VlZGVkLgpBbHRlcm5hdGl2
ZWx5LCBhdHRhY2ggdGhlIHNuZF9oZGEua28gc28gb25lIGNhbiBzZWUgd2hlcmUgaW4gdGhhdCBm
aWxlCm9mZnNldCAweDU3IGlzLgpCdXQgYSBtb3JlIHVzZWZ1bCBwcmludCB3b3VsZCBiZToKaWYg
KCFqYWNrKSBwcmludGsoS0VSTl9JTkZPICJqYWNrIG51bGxcbiIpOwplbHNlIGlmICghKGphY2st
PmphY2spKSBwcmludGsoS0VSTl9JTkZPICJqYWNrLT5qYWNrIG51bGxcbiIpOwplbHNlIGlmICgh
KGphY2stPmphY2stPnByaXZhdGVfZGF0YSkpIHByaW50ayhLRVJOX0lORk8KImphY2stPmphY2st
PnByaXZhdGVfZGF0YSBudWxsXG4iKTsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
