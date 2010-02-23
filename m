From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCHES_v1] ASoC: Towards dropping runtime field
	from snd_soc_dai
Date: Tue, 23 Feb 2010 13:57:30 +0900
Message-ID: <1b68c6791002222057t15ccff9ei395078c86cd4a67e@mail.gmail.com>
References: <1b68c6791002212255j69faa9b7k13da803bf65c2177@mail.gmail.com>
	<20100222142748.GB27789@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id ED7E024156
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 05:57:31 +0100 (CET)
Received: by vws13 with SMTP id 13so725198vws.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 20:57:31 -0800 (PST)
In-Reply-To: <20100222142748.GB27789@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

T24gTW9uLCBGZWIgMjIsIDIwMTAgYXQgMTE6MjcgUE0sIE1hcmsgQnJvd24KPGJyb29uaWVAb3Bl
bnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBNb24sIEZlYiAyMiwgMjAxMCBh
dCAwMzo1NTo1OVBNICswOTAwLCBqYXNzaSBicmFyIHdyb3RlOgo+PiA8RHVlIHRvIHNvbWUgcHJv
YmxlbSBJIGFtIHVuYWJsZSB0byBzZW5kIGlubGluZSBwYXRjaGVzLCBwbGVhc2UgYWNjZXB0Cj4+
IHRoZSBhdHRhY2hlZCBwYXRjaGVzIGZvciB0aGlzIHRpbWU+Cj4KPiBJZiB5b3UncmUgZ29pbmcg
dG8gZG8gdGhpcyBwbGVhc2Ugc2VuZCBqdXN0IHRoZSBwYXRjaGVzIGFzIHRoZQo+IGF0dGFjaG1l
bnRzLCBpbmNsdWRpbmcgdGhlIHBhdGNoIGRlc2NyaXB0aW9uIGluIHRoZSBhdHRhY2htZW50IGNh
c2VzCj4gdGhlbSB0byBjb21lIG91dCBsaWtlIHRoaXM6Cj4KPiDCoCDCoEFTT0M6IEFUTUVMOiBH
ZXR0aW5nIGNwdV9kYWkgbWV0aG9kIGNoYW5nZQo+Cj4gwqAgwqBbUEFUQ0ggMi8zXSBBU09DOiBB
VE1FTDogR2V0dGluZyBjcHVfZGFpIG1ldGhvZCBjaGFuZ2UKPgo+IMKgIMKgQ3VycmVudGx5IG9u
bHkgdGhlIGF0bWVsIGRyaXZlciBtYWtlIHVzZSBvZiBzbmRfc29jX2RhaS5ydW50aW1lIGZpZWxk
Lgo+Cj4gd2hlbiBhcHBsaWVkIHdoaWNoIGlzbid0IGlkZWFsLgpJIGludGVuZGVkIHRoZW0gdG8g
YmUgJ2dpdCBhbScgYXBwbGllZC4gQW55d2F5cywgSSBob3BlIEkgZG9uJ3QgaGF2ZSB0bwpzZW5k
IGF0dGFjaG1lbnRzIGluIGZ1dHVyZS4KCj4+IFtQQVRDSCAxLzNdIEFTb0M6IFBMQVRGT1JNOiBQ
YXNzIGRhaV9saW5rIGFzIGFyZ3VtZW50IHRvIHN1c3BlbmQsIHJlc3VtZQo+PiBbUEFUQ0ggMi8z
XSBBU09DOiBBVE1FTDogR2V0dGluZyBjcHVfZGFpIG1ldGhvZCBjaGFuZ2UKPj4gW1BBVENIIDMv
M10gQVNPQzogU05EX1NPQ19EQUk6IEdldCByaWQgb2YgJ3J1bnRpbWUnIGZpZWxkCj4KPiBOb3Rl
IGFsc28gdGhlIGRpZmZlcmVudCBzcGVsbGluZ3Mgb2YgQVNvQyBoZXJlIChhbmQgZWxzZXdoZXJl
IGluIHlvdXIKPiBjb21taXQgbWVzc2FnZXMpIC0gdGhlIGZpcnN0IGlzIGNvcnJlY3QuIMKgWW91
IGRvbid0IG5lZWQgdG8gY2FwaXRhbGlzZQo+IGFsbCB0aGUgbGV0dGVycyBpbiBuYW1lcy4KT2su
Cgo+IElmIHlvdXIgcHJvYmxlbXMgYXJlIChhcyBJJ20gZ3Vlc3NpbmcgaXMgdGhlIGNhc2UpIGdt
YWlsIGJyZWFrYWdlIHlvdQo+IG1pZ2h0IHdhbnQgdG8gbG9vayBpbnRvIGltYXAtc2VuZCwgd2hp
Y2ggd2lsbCBkdW1wIHRoZSBwYXRjaGVzIGluIGFuCj4gSU1BUCBtYWlsYm94IGZvciB0cmFuc21p
c3Npb24uCndpbGwgY2hlY2sgdGhhdCBvdXQuCnRoYW5rcy4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
