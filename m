From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH RFC] ALSA: hda - Add workaround for
 conflicting IEC958 controls
Date: Wed, 17 Oct 2012 20:43:22 +0800
Message-ID: <CAN8cciYBXAhTVK4dgTDK4Z931VduQOk9AYqdi7TMSABUv0YQrw@mail.gmail.com>
References: <s5hpq4nk9b1.wl%tiwai@suse.de> <s5hobk7k918.wl%tiwai@suse.de>
 <s5h7gqp7bst.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id DE4FA265214
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 14:43:23 +0200 (CEST)
Received: by mail-qa0-f51.google.com with SMTP id j40so444434qab.17
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 05:43:23 -0700 (PDT)
In-Reply-To: <s5h7gqp7bst.wl%tiwai@suse.de>
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

MjAxMi0xMC0xNyDkuIvljYg0OjE3IOaWvCAiVGFrYXNoaSBJd2FpIiA8dGl3YWlAc3VzZS5kZT4g
5a+r6YGT77yaCj4KPiBBdCBGcmksIDEyIE9jdCAyMDEyIDE3OjI0OjUxICswMjAwLAo+IFRha2Fz
aGkgSXdhaSB3cm90ZToKPiA+Cj4gPiBXaGVuIGJvdGggYW4gU1BESUYgYW5kIGFuIEhETUkgZGV2
aWNlIGFyZSBjcmVhdGVkIG9uIHRoZSBzYW1lIGNhcmQKPiA+IGluc3RhbmNlLCBtdWx0aXBsZSBJ
RUM5NTggY29udHJvbHMgYXJlIGNyZWF0ZWQgd2l0aCBpbmRpY2VzPTAsIDEsIC4uLgo+ID4gQnV0
IHRoZSBhbHNhLWxpYiBjb25maWd1cmF0aW9uIGNhbid0IGtub3cgd2hpY2ggaW5kZXggY29ycmVz
cG9uZHMKPiA+IGFjdHVhbGx5IHRvIHdoaWNoIFBDTSBkZXZpY2UsIGFuZCBib3RoIHRoZSBTUERJ
RiBhbmQgdGhlIEhETUkKPiA+IGNvbmZpZ3VyYXRpb25zIHBvaW50IHRvIHRoZSBmaXJzdCBJRUM5
NTggY29udHJvbCB3cm9uZ2x5Lgo+ID4KPiA+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIChoYWNr
aXNoIGFuZCB1Z2x5KSB3b3JrYXJvdW5kOiB0aGUgSUVDOTU4Cj4gPiBjb250cm9scyBmb3IgdGhl
IFNQRElGIGRldmljZSBhcmUgcmUtbGFiZWxlZCB3aXRoIGRldmljZT0xIHdoZW4gSERNSQo+ID4g
Y29leGlzdHMuICBUaGUgZGV2aWNlPTEgY29ycmVzcG9uZHMgdG8gdGhlIGFjdHVhbCBQQ00gZGV2
aWNlIGZvcgo+ID4gU1BESUYsIHNvIGl0J3MgYW55d2F5IGEgYmV0dGVyIHJlcHJlc2VudGF0aW9u
LiAgSW4gZnV0dXJlLCBIRE1JCj4gPiBjb250cm9scyBzaG91bGQgYmUgbW92ZWQgd2l0aCB0aGUg
Y29ycmVzcG9uZGluZyBQQ00gZGV2aWNlIG51bWJlciwKPiA+IHRvby4KPiA+Cj4gPiBTaWduZWQt
b2ZmLWJ5OiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Cj4KPiBTaW5jZSB0aGVyZSB3YXMg
bm8gYmlnIG9iamVjdGlvbiB0byB0aGlzIG1vdmUsIEkgcXVldWVkIHRoZSBrZXJuZWwKPiBwYXRj
aCB0byBmb3ItbmV4dCBicmFuY2ggbm93Lgo+Cj4gQWJvdXQgdGhlIGFsc2EtbGliIGhhY2ssIGl0
J3Mgc3RpbGwgaW4gY29uc2lkZXJhdGlvbi4gIEJ1dCB0aGlzIGtlcm5lbAo+IHBhcnQgZG9lc24n
dCBjb25mbGljdCB3aXRoIG90aGVyIHBvc3NpYmxlIGZpeCwgc28gbGV0IGl0IGJlIGluLgo+Cgpi
dXQgeW91ciBwYXRjaCBzdGlsbCBub3QgY29udGFpbiBhZDE5ODhiICwgY29uZXhhbnQgYW5kIHZp
YSAgdnQxNzA4cyBoZGEKY29kZWNzIHNpbmNlIHRoZXJlIGFyZSBjb21wdXRlcnMgaGF2ZSB0aG9z
ZSBhdWRpbyBjb2RlY3Mgd2l0aCBudmlkaWEgbWNwNzcKY29kZWNzCj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
