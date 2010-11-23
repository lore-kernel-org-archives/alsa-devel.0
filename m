From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCHv4 17/18] ASoC: Samsung: Generalize Kconfig
	symbols
Date: Tue, 23 Nov 2010 23:16:57 +0900
Message-ID: <AANLkTik=eFwdN5UjhKWGe5Os_SwTE=uH++s6Xu+0zxVA@mail.gmail.com>
References: <1290407690-28917-1-git-send-email-jassisinghbrar@gmail.com>
	<1290407842-29591-1-git-send-email-jassisinghbrar@gmail.com>
	<20101123141255.GH18960@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 06BE8103A73
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 15:16:58 +0100 (CET)
Received: by wwe15 with SMTP id 15so1312029wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 06:16:58 -0800 (PST)
In-Reply-To: <20101123141255.GH18960@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBOb3YgMjMsIDIwMTAgYXQgMTE6MTIgUE0sIE1hcmsgQnJvd24KPGJyb29uaWVAb3Bl
bnNvdXJjZS53b2xmc29ubWljcm8uY29tPiB3cm90ZToKPiBPbiBNb24sIE5vdiAyMiwgMjAxMCBh
dCAwMzozNzoyMlBNICswOTAwLCBKYXNzaSBCcmFyIHdyb3RlOgo+Cj4+IMKgIMKgIMKgIMKgIFNO
RF9TT0NfU01ES19TUERJRiAtPiBBU09DX1NBTVNVTkdfU01ES19TUERJRgo+PiDCoCDCoCDCoCDC
oCBTTkRfU09DX1NNREtfV004NTgwIC0+IEFTT0NfU0FNU1VOR19TTURLX1dNODU4MAo+PiDCoCDC
oCDCoCDCoCBTTkRfU09DX1NNREtfV005NzEzIC0+IEFTT0NfU0FNU1VOR19TTURLX1dNOTcxMwo+
PiDCoCDCoCDCoCDCoCBTTkRfU09DX0dPTklfQVFVSUxBX1dNODk5NCAtPiBBU09DX0dPTklfQVFV
SUxBX1dNODk5NAo+Cj4gSHJtLiDCoFRoZXNlIG9uZXMgSSdtIG5vdCBlbnRpcmVseSBoYXBweSBh
Ym91dCAtIHdlJ3JlIHByZXR0eQo+IGNvbnNpc3RlbnRseSB1c2luZyBTTkRfU09DXyByYXRoZXIg
dGhhbiBBU09DXyB0aHJvdWdob3V0IHRoZSBzdWJzeXN0ZW0KPiBzbyBjaGFuZ2luZyB0byBBU09D
XyBmZWVscyBsaWtlIGNodXJuLiDCoElzIHRoZXJlIGFueSBncmVhdCByZWFzb24gZm9yCj4gdGhl
IHJlbmFtZT8gwqBJIGRvbid0IG1pbmQgdGhlIGFkZGl0aW9uIG9mIFNBTVNVTkdfIG9uZSB3YXkg
b3IgdGhlIG90aGVyLAo+IGl0J3MganVzdCB0aGUgc3Vic3lzdGVtIHByZWZpeC4KSWYgU05EX1NP
QyBpcyB0byBiZSB1c2VkIGFjcm9zcyBhbGwgcGxhdGZvcm1zLCBteSBjaGFuZ2VzIGFyZSBpbmRl
ZWQKb3V0IG9mIGxpbmUuCk90aGVyd2lzZSwgQVNPQyByZXByZXNlbnRzIFNORF9TT0MgYmV0dGVy
IGFuZCBjb21wYWN0bHkuCgo+IEkndmUgYXBwbGllZCB0aGlzIGp1c3Qgbm93IGFzIHRoZSByZW5h
bWUgcGF0Y2ggZGVwZW5kcyBvbiBpdC4KT2ssIHRob3VnaCBJIHdhcy9hbSB3aWxsaW5nIHRvIHN1
Ym1pdCB5ZXQgYW5vdGhlciByZXZpc2lvbi4KClRoYW5rcy4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
