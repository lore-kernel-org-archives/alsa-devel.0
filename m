From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: Re:
 =?utf-8?q?=5BPATCH_2/2=5D_ASoC=3A_fsl=5Fssi=3A_Fix_n?=
 =?utf-8?q?umber_of_words_per_frame_for_I2S-slave_mode?=
Date: Wed, 29 Jun 2016 10:52:01 +0300
Message-ID: <1467186721.688218396@f75.i.mail.ru>
References: <1466830762-31646-1-git-send-email-shc_work@mail.ru>
 <1467143972.433375523@f318.i.mail.ru>
 <20160628220641.GB378@Asurada-Nvidia>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f75.i.mail.ru (f75.i.mail.ru [128.140.169.157])
 by alsa0.perex.cz (Postfix) with ESMTP id D5A60265611
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 09:52:05 +0200 (CEST)
In-Reply-To: <20160628220641.GB378@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?Tmljb2xpbiBDaGVu?= <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, =?UTF-8?B?TGlhbSBHaXJkd29vZA==?= <lgirdwood@gmail.com>, =?UTF-8?B?WGl1Ym8gTGk=?= <Xiubo.Lee@gmail.com>, =?UTF-8?B?VGltdXIgVGFiaQ==?= <timur@tabi.org>, =?UTF-8?B?VGFrYXNoaSBJd2Fp?= <tiwai@suse.com>, =?UTF-8?B?TWFyayBCcm93bg==?= <broonie@kernel.org>, =?UTF-8?B?RmFiaW8gRXN0ZXZhbQ==?= <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

PtCh0YDQtdC00LAsIDI5INC40Y7QvdGPIDIwMTYsIDE6MDYgKzAzOjAwINC+0YIgTmljb2xpbiBD
aGVuIDxuaWNvbGVvdHN1a2FAZ21haWwuY29tPjoKPgo+T24gVHVlLCBKdW4gMjgsIDIwMTYgYXQg
MTA6NTk6MzJQTSArMDMwMCwgQWxleGFuZGVyIFNoaXlhbiB3cm90ZToKPj4gPtCS0YLQvtGA0L3Q
uNC6LCAyOCDQuNGO0L3RjyAyMDE2LCAyMToyMCArMDM6MDAg0L7RgiBOaWNvbGluIENoZW4gPCBu
aWNvbGVvdHN1a2FAZ21haWwuY29tID46Cj4+ID4KPj4gPk9uIFNhdCwgSnVuIDI1LCAyMDE2IGF0
IDA3OjU5OjIyQU0gKzAzMDAsIEFsZXhhbmRlciBTaGl5YW4gd3JvdGU6Cj4+ID4+IFRoZSBpLk1Y
NTEgZGF0YXNoZWV0IHNheXM6Cj4+ID4+IENoYXB0ZXIgNTYuMS4yLjQgSTJTIE1vZGUKPj4gPj4g
Li4uCj4+ID4+IFdoZW4gSTJTIG1vZGVzIGFyZSBlbnRlcmVkIChJMlMgbWFzdGVyICgwMSkgb3Ig
STJTIHNsYXZlICgxMCkpLAo+PiA+PiB0aGUgZm9sbG93aW5nIHNldHRpbmdzIGFyZSByZWNvbW1l
bmRlZDoKPj4gPj4gLi4uCj4+ID4+IC0gVFggRnJhbWUgUmF0ZSBzaG91bGQgYmUgMiBpLmUuIChT
VENDUlsxMjo4XSA9IDEpCj4+ID4+IC0gUlggRnJhbWUgUmF0ZSBzaG91bGQgYmUgMiBpLmUuIChT
UkNDUlsxMjo4XSA9IDEpCj4+ID4+IAo+PiA+PiBDaGFwdGVyIDU2LjMuMy4xMiBTU0kgVHJhbnNt
aXQgYW5kIFJlY2VpdmUgQ2xvY2sgQ29udHJvbCBSZWdpc3RlcnMgKFNUQ0NSICYgU1JDQ1IpCj4+
ID4+IC4uLgo+PiA+PiBCaXRzIDEyLTggREM0LURDMAo+PiA+PiBGcmFtZSBSYXRlIERpdmlkZXIg
Q29udHJvbC4gVGhlc2UgYml0cyBhcmUgdXNlZCB0byBjb250cm9sIHRoZSBkaXZpZGUgcmF0aW8K
Pj4gPj4gZm9yIHRoZSBwcm9ncmFtbWFibGUgZnJhbWUgcmF0ZSBkaXZpZGVycy4gVGhlIGRpdmlk
ZSByYXRpbyB3b3JrcyBvbiB0aGUgd29yZAo+PiA+PiBjbG9jay4gSW4gTm9ybWFsIG1vZGUsIHRo
aXMgcmF0aW8gZGV0ZXJtaW5lcyB0aGUgd29yZCB0cmFuc2ZlciByYXRlLgo+PiA+PiBJbiBOZXR3
b3JrIG1vZGUsIHRoaXMgcmF0aW8gc2V0cyB0aGUgbnVtYmVyIG9mIHdvcmRzIHBlciBmcmFtZS4g
VGhlIGRpdmlkZQo+PiA+PiByYXRpbyByYW5nZXMgZnJvbSAxIHRvIDMyIGluIE5vcm1hbCBtb2Rl
IGFuZCBmcm9tIDIgdG8gMzIgaW4gTmV0d29yayBtb2RlLgo+PiA+PiBJbiBOb3JtYWwgbW9kZSwg
YSBkaXZpZGUgcmF0aW8gb2YgMSAoREM9MDAwMDApIHByb3ZpZGVzIGNvbnRpbnVvdXMgcGVyaW9k
aWMKPj4gPj4gZGF0YSB3b3JkIHRyYW5zZmVyLiBBIGJpdC1sZW5ndGggZnJhbWUgc3luYyBtdXN0
IGJlIHVzZWQgaW4gdGhpcyBjYXNlLgo+PiA+PiAKPj4gPj4gRnVuY3Rpb24gZnNsX3NzaV9od19w
YXJhbXMoKSBzZXR1cCBOb3JtYWwgbW9kZSBmb3IgTU9OTyBvdXRwdXQsCj4+ID4+IHNvIHdpdGgg
REM9MCwgU1NJIGVudGVycyB0byBjb250aW51b3VzIHBlcmlvZGljIGRhdGEgd29yZCB0cmFuc2Zl
ci4KPj4gPj4gVG8gZml4IHRoaXMsIHNldHVwIERDIGZvciBhbnkgSTJTIG1vZGUuCj4+ID4KPj4g
PlRoZSBjaGFuZ2UgbG9va3MgZmluZSBhbmQgZGlkbid0IHNob3cgYW55IHByb2JsZW0gd2hlbiBJ
IHRlc3RlZCBpdC4KPj4gPkJ1dCBJIGFtIHdvbmRlcmluZyB3aGF0J3MgdGhlIGZhaWxlZCB1c2Vy
IGNhc2UgaGVyZSBzbyB3ZSBuZWVkIHRoaXMKPj4gPnBhdGNoIHRvIGZpeD8gKFRoZSBtb25vIHBs
YXliYWNrIHdvcmtzIHdpdGhvdXQgdGhpcyBwYXRjaCBhcyB3ZWxsLikKPj4gCj4+IFByb2JhYmx5
IHRoaXMgd29ya3MgZmluZSB3aXRob3V0IHBhdGNoIGlmIEZTY2xrID09IEJJVGNsayAqIHNpemUu
Cj4KPkkgYWNrZWQgdGhpcyBwYXRjaCBzaW5jZSBpdCdzIG1vcmUgbGlrZWx5IGEgY29ycmVjdCBj
b25maWd1cmF0aW9uCj5hY2NvcmRpbmcgdG8gdGhlIHJlZmVyZW5jZSBtYW51YWwgd2hpbGUgc3Rp
bGwgd2FudCB0byBrbm93IHdoYXQncwo+eW91ciBmYWlsZWQgY2FzZS4gQ291bGQgeW91IHBsZWFz
ZSB0ZWxsIG1lIHdoYXQgd2VyZSB0aGUgRlNjbGssCj5CSVRjbGsgYW5kIHNpemUgb2YgeW91ciBj
YXNlPwoKSGVsbG8uCgpIZXJlIGlzIG15IG9zY2lsbG9ncmFtcyB3aXRoL3dpdGhvdXQgcGF0Y2g6
CkJjbGs9MTIgTUh6LCBzb3VuZCBpcyBqdXN0IGEgImNhdCAvZGV2L3VyYW5kb20gPiAvZGV2L2Rz
cCIsIGkuZS4gRlM9OCBLSHosIE1PTk8uClVwcGVyICh5ZWxsb3cpIGxpbmUgaXMgVFhEQVRBLCBM
b3dlciAoYmx1ZSkgaXMgRlMuCgpNZWFzdXJlbWVudCB3aXRob3V0IHBhdGNoOiBodHRwczovL2Ns
b3VkLm1haWwucnUvcHVibGljL1Jjc3YveHI4OFY1U2ExCk1lYXN1cmVtZW50IHdpdGggcGF0Y2g6
IGh0dHBzOi8vY2xvdWQubWFpbC5ydS9wdWJsaWMvTkN3bi9EUW56aW9RRUwKClRoYW5rcy4KLS0t
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxt
YW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
