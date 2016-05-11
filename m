From: Jeremy McDermond <nh6z@nh6z.net>
Subject: Re: [PATCH] ALSA: usb-audio: Yet another Phoneix Audio
	device quirk
Date: Wed, 11 May 2016 09:10:11 -0700
Message-ID: <7FF5B1C7-4545-4A9B-AFB7-7D23DD191A3D@nh6z.net>
References: <1462982112-7276-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F48D2666B9
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 18:10:15 +0200 (CEST)
In-Reply-To: <1462982112-7276-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cj4gT24gTWF5IDExLCAyMDE2LCBhdCA4OjU1IEFNLCBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2Uu
ZGU+IHdyb3RlOgo+IAo+IFBob2VuaXggQXVkaW8gaGFzIHlldCBhbm90aGVyIGRldmljZSB3aXRo
IGFub3RoZXIgaWQgKGV2ZW4gYSBkaWZmZXJlbnQKPiB2ZW5kb3IgaWQsIDA1NTY6MDAxNCkgdGhh
dCByZXF1aXJlcyB0aGUgc2FtZSBxdWlyayBmb3IgdGhlIHNhbXBsZQo+IHJhdGUuCj4gCj4gQnVn
emlsbGE6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTEwMjIx
Cj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgo+IFNpZ25lZC1vZmYtYnk6IFRha2FzaGkg
SXdhaSA8dGl3YWlAc3VzZS5kZT4KPiAtLS0KPiBzb3VuZC91c2IvcXVpcmtzLmMgfCAxICsKPiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPiAKPiBkaWZmIC0tZ2l0IGEvc291bmQvdXNi
L3F1aXJrcy5jIGIvc291bmQvdXNiL3F1aXJrcy5jCj4gaW5kZXggN2I2ZGNhMmQ3NDg4Li4yMjA3
NjRjZDYwYmQgMTAwNjQ0Cj4gLS0tIGEvc291bmQvdXNiL3F1aXJrcy5jCj4gKysrIGIvc291bmQv
dXNiL3F1aXJrcy5jCj4gQEAgLTExMzcsNiArMTEzNyw3IEBAIGJvb2wgc25kX3VzYl9nZXRfc2Ft
cGxlX3JhdGVfcXVpcmsoc3RydWN0IHNuZF91c2JfYXVkaW8gKmNoaXApCj4gCWNhc2UgVVNCX0lE
KDB4MDQ3RiwgMHgwNDE1KTogLyogUGxhbnRyb25pY3MgQlQtMzAwICovCj4gCWNhc2UgVVNCX0lE
KDB4MDQ3RiwgMHhBQTA1KTogLyogUGxhbnRyb25pY3MgREE0NSAqLwo+IAljYXNlIFVTQl9JRCgw
eDA0RDgsIDB4RkVFQSk6IC8qIEJlbmNobWFyayBEQUMxIFByZSAqLwo+ICsJY2FzZSB1U0JfSUQo
MHgwNTU2LCAweDAwMTQpOiAvKiBQaG9lbml4IEF1ZGlvIFRNWDMyMFZDICovCj4gCWNhc2UgVVNC
X0lEKDB4MDc0RCwgMHgzNTUzKTogLyogT3V0bGF3IFJSMjE1MCAoTWljcm9uYXMgVUFDMzU1M0Ip
ICovCgpTaG91bGRu4oCZdCB0aGlzIGJlIGFuIHVwcGVyY2FzZSBVIGluIFVTQl9JRCwgVGFrYXNo
aT8KCj4gCWNhc2UgVVNCX0lEKDB4MWRlNywgMHgwMDEzKTogLyogUGhvZW5peCBBdWRpbyBNVDIw
MmV4ZSAqLwo+IAljYXNlIFVTQl9JRCgweDFkZTcsIDB4MDAxNCk6IC8qIFBob2VuaXggQXVkaW8g
VE1YMzIwICovCj4gLS0gCj4gMi44LjIKCi0tCkplcmVteSBNY0Rlcm1vbmQgKE5INlopClhlbm90
cm9waWMgU3lzdGVtcwptY2Rlcm1qQHhlbm90cm9waWMuY29tCgoKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
