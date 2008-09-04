From: "=?UTF-8?Q?Vedran_Mileti=C4=87?=" <rivanvx@gmail.com>
Subject: Re: [PATCH 1/2] ca0106 playback 44100Hz support to
	SPDIF and playback format & rate constraints
Date: Thu, 4 Sep 2008 09:16:46 +0200
Message-ID: <fd3eb9bf0809040016g62ec2767rb135d55ce4799909@mail.gmail.com>
References: <1219415921.32652.254.camel@localhost>
	<s5h63ptf48b.wl%tiwai@suse.de> <1219502224.15980.32.camel@localhost>
	<s5h7ia5dpe0.wl%tiwai@suse.de> <1220375467.7459.8.camel@localhost>
	<48BDAD8B.8060007@superbug.co.uk>
	<Pine.LNX.4.58.0809030912020.24305@shell4.speakeasy.net>
	<48BED943.1080504@superbug.co.uk> <s5hej40o1wc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 39377245C7
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 09:16:49 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so3227966wfg.23
	for <alsa-devel@alsa-project.org>; Thu, 04 Sep 2008 00:16:47 -0700 (PDT)
In-Reply-To: <s5hej40o1wc.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SXMgaXQgbWF5YmUgdGhhdCBDQTAxMDYsIGFzIDEwazEgYW5kIDEwazIgY2FuJ3Qgd29yayBhdCA0
NDEwMD8KCjIwMDgvOS80IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT46Cj4gQXQgV2VkLCAw
MyBTZXAgMjAwOCAxOTozNjo1MSArMDEwMCwKPiBKYW1lcyBDb3VydGllci1EdXR0b24gd3JvdGU6
Cj4+Cj4+IFRyZW50IFBpZXBobyB3cm90ZToKPj4gPiBPbiBUdWUsIDIgU2VwIDIwMDgsIEphbWVz
IENvdXJ0aWVyLUR1dHRvbiB3cm90ZToKPj4gPj4gQmVuIFN0YW5sZXkgd3JvdGU6Cj4+ID4+PiAr
ICAgICAgICAgLyogV2Ugb25seSBzdXBwb3J0IDQ0MTAwIHRvIHNwZGlmLCBub3QgdG8gREFDLgo+
PiA+Pj4gKyAgICAgICAgICAgIChGSVhNRSBXSFk/KSovCj4+ID4+IFdIWT8gIEJlY2F1c2UgdGhl
IERBQyBjYW5ub3QgYmUgY2xvY2tlZCBhdCA0NDEwMCwgb25seSA0ODAwMCBhbmQgOTYwMDAKPj4g
Pj4gZnJvbSB0aGUgQ0EwMTA2IGNoaXAuCj4+ID4+IFRoZSBTUERJRiBjYW4gYmUgY2xvY2tlZCBh
dCA0NDEwMC4KPj4gPj4gSXQgaXMgYSBoYXJkd2FyZSBsaW1pdGF0aW9uLgo+PiA+Cj4+ID4gVGhl
IERBQyBzdXBwb3J0cyA0NDEwMC4gIElzIHRoZSBwcm9ibGVtIHRoYXQgdGhlIGNhMDEwNiBjYW4n
dCBwcm92aWRlIGEKPj4gPiA0NDEwMCBjbG9jayB0byB0aGUgREFDPwo+PiBJdCBkb2VzIG5vdCBy
ZWFsbHkgbWF0dGVyIHdoeSwgaXQgZG9lcyBub3Qgd29yayBhdCA0NDEwMCBhbmQgdGhhdCBpcyBm
YWN0Lgo+Cj4gSXQgZG9lcyBtYXR0ZXIuICBBdCBsZWFzdCwgdGhlIHNpdHVhdGlvbiBzaG91bGQg
YmUgY29tbWVudGVkCj4gY29ycmVjdGx5LiAgT3RoZXJ3aXNlIHlvdSdsbCBoYXZlIHRoZSBzYW1l
IHF1ZXN0aW9uIGFuZCBnaXZlIHRoZSBzYW1lCj4gYW5zd2VyIGFnYWluIGFuZCBhZ2Fpbi4KPgo+
Cj4gVGFrYXNoaQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKPiBodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAo+CgoKCi0tIApWZWRyYW4gTWlsZXRpxIcKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZl
bEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbHNhLWRldmVsCg==
