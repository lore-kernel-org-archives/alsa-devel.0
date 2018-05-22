From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Subject: Re: [PATCH v3 4/6] ALSA: xen-front: Implement handling
 of shared buffers
Date: Tue, 22 May 2018 08:25:28 +0300
Message-ID: <5aaef4e5-3e9d-9170-f92d-382e4cf5ffba@epam.com>
References: <20180514062742.25879-1-andr2000@gmail.com>
 <20180514062742.25879-5-andr2000@gmail.com> <s5ho9hi56ds.wl-tiwai@suse.de>
 <e37b5170-4fab-0c06-8902-730e57118ceb@gmail.com>
 <s5h8t8l5ufq.wl-tiwai@suse.de>
 <19a2c003-6730-265a-29aa-1eedd37147b9@epam.com>
 <s5ho9he94s7.wl-tiwai@suse.de> <s5hh8n03gd4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0046.outbound.protection.outlook.com [104.47.2.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 8167F267623
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 07:25:35 +0200 (CEST)
In-Reply-To: <s5hh8n03gd4.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: Juergen Gross <jgross@suse.com>, alsa-devel@alsa-project.org, konrad.wilk@oracle.com, Oleksandr Andrushchenko <andr2000@gmail.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
List-Id: alsa-devel@alsa-project.org

T24gMDUvMjEvMjAxOCAxMToyNiBQTSwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+IE9uIFRodSwgMTcg
TWF5IDIwMTggMDg6MjY6MTYgKzAyMDAsCj4gVGFrYXNoaSBJd2FpIHdyb3RlOgo+PiBPbiBUdWUs
IDE1IE1heSAyMDE4IDA4OjAyOjA4ICswMjAwLAo+PiBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyB3
cm90ZToKPj4+IE9uIDA1LzE1LzIwMTggMDk6MDEgQU0sIFRha2FzaGkgSXdhaSB3cm90ZToKPj4+
PiBPbiBUdWUsIDE1IE1heSAyMDE4IDA3OjQ2OjM4ICswMjAwLAo+Pj4+IE9sZWtzYW5kciBBbmRy
dXNoY2hlbmtvIHdyb3RlOgo+Pj4+PiBPbiAwNS8xNC8yMDE4IDExOjI4IFBNLCBUYWthc2hpIEl3
YWkgd3JvdGU6Cj4+Pj4+PiBPbiBNb24sIDE0IE1heSAyMDE4IDA4OjI3OjQwICswMjAwLAo+Pj4+
Pj4gT2xla3NhbmRyIEFuZHJ1c2hjaGVua28gd3JvdGU6Cj4+Pj4+Pj4gLS0tIC9kZXYvbnVsbAo+
Pj4+Pj4+ICsrKyBiL3NvdW5kL3hlbi94ZW5fc25kX2Zyb250X3NoYnVmLmMKPj4+Pj4+PiBAQCAt
MCwwICsxLDE5MyBAQAo+Pj4+Pj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MCBPUiBNSVQKPj4+Pj4+PiArCj4+Pj4+Pj4gKy8qCj4+Pj4+Pj4gKyAqIFhlbiBwYXJhLXZpcnR1
YWwgc291bmQgZGV2aWNlCj4+Pj4+Pj4gKyAqCj4+Pj4+Pj4gKyAqIENvcHlyaWdodCAoQykgMjAx
Ni0yMDE4IEVQQU0gU3lzdGVtcyBJbmMuCj4+Pj4+Pj4gKyAqCj4+Pj4+Pj4gKyAqIEF1dGhvcjog
T2xla3NhbmRyIEFuZHJ1c2hjaGVua28gPG9sZWtzYW5kcl9hbmRydXNoY2hlbmtvQGVwYW0uY29t
Pgo+Pj4+Pj4+ICsgKi8KPj4+Pj4+PiArCj4+Pj4+Pj4gKyNpbmNsdWRlIDx4ZW4veGVuLmg+Cj4+
Pj4+Pj4gKyNpbmNsdWRlIDx4ZW4veGVuYnVzLmg+Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICsjaW5jbHVk
ZSAieGVuX3NuZF9mcm9udF9zaGJ1Zi5oIgo+Pj4+Pj4gSG0sIHdpdGggdGhlIGxvY2FsIGJ1aWxk
IHRlc3QsIEkgZ2V0IHRoZSBmb2xsb3dpbmcgZXJyb3I6Cj4+Pj4+Pgo+Pj4+Pj4gICAgICBDQyBb
TV0gIHNvdW5kL3hlbi94ZW5fc25kX2Zyb250X3NoYnVmLm8KPj4+Pj4+ICAgICAgSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIHNvdW5kL3hlbi94ZW5fc25kX2Zyb250X3NoYnVmLmM6MTE6MDoKPj4+Pj4+
ICAgICAgLi9pbmNsdWRlL3hlbi94ZW4uaDoxODo4OiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUg
4oCYYm9vbOKAmQo+Pj4+Pj4gICAgICAgZXh0ZXJuIGJvb2wgeGVuX3B2aDsKPj4+Pj4+ICAgICAg
ICAgICAgICAgXn5+fgo+Pj4+Pj4gICAgICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4vaW5jbHVk
ZS94ZW4vaW50ZXJmYWNlL3hlbi5oOjMwOjAsCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAg
IGZyb20gLi9pbmNsdWRlL3hlbi94ZW4uaDoyOSwKPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgZnJvbSBzb3VuZC94ZW4veGVuX3NuZF9mcm9udF9zaGJ1Zi5jOjExOgo+Pj4+Pj4gICAgICAu
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3hlbi9pbnRlcmZhY2UuaDo5MjoyMTogZXJyb3I6IHVua25v
d24gdHlwZSBuYW1lIOKAmHVpbnQ2NF904oCZCj4+Pj4+PiAgICAgICBERUZJTkVfR1VFU1RfSEFO
RExFKHVpbnQ2NF90KTsKPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+Pj4+Pj4g
CQkJCj4+Pj4+PiBBZGRpbmcgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPiBmaXhlZCB0aGUgaXNz
dWUuCj4+Pj4+Pgo+Pj4+Pj4gRGlkIHlvdSByZWFsbHkgdGVzdCB5b3VyIHBhdGNoZXMgd2l0aCB0
aGUgbGF0ZXN0IExpbnVzIHRyZWU/Cj4+Pj4+IE15IGJhZCwgaXQgZG9lcyBidWlsZCBmb3IgQVJN
ICh3aGljaCBpcyBteSB0YXJnZXQpLCBidXQgYWxzbyBkb2VzCj4+Pj4+IG5lZWQgIiNpbmNsdWRl
IDxsaW51eC9rZXJuZWwuaD4iIGZvciB4ODYgd2hpY2ggSSBkaWRuJ3QgYnVpbGQgdGhpcyB0aW1l
Lgo+Pj4+PiBTb3JyeSBhYm91dCB0aGF0Lgo+Pj4+Pgo+Pj4+PiBEbyB5b3Ugd2FudCBtZSB0byBy
ZXNlbmQgdGhpcyBzaW5nbGUgcGF0Y2ggb3IgeW91IGNhbiBtYWtlIHRoZSBjaGFuZ2UKPj4+Pj4g
d2hpbGUgYXBwbHlpbmc/Cj4+Pj4gWWVzLCBpdCdzIGZpbmUuCj4+PiBUaGFuayB5b3UKPj4gRldJ
VywgdGhlIHBhdGNoZXMgYXJlIGluIHRvcGljL3hlbiBicmFuY2ggaW4gc291bmQuZ2l0IHRyZWUs
IGFuZCBJJ2xsCj4+IGtlZXAgYm9pbGluZyBmb3IgYSB3aGlsZSB0byBzZWUgaWYgYW55IGlzc3Vl
cyBhcmUgY2F1Z2h0IGJ5IDBkYXkgYm90Lgo+IC4uLiBhbmQgbm93IHRoZSB0b3BpYy94ZW4gYnJh
bmNoIGdvdCBtZXJnZWQgdG8gZm9yLW5leHQsIHRhcmdldGVkIGZvcgo+IDQuMTguCj4KPiBUaGFu
a3MgZm9yIHlvdXIgcGF0aWVudCB3b3JrcyEKPgo+Cj4gVGFrYXNoaQpHcmVhdCBuZXdzLCB0aGFu
ayB5b3UsCk9sZWtzYW5kcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5v
cmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2Et
ZGV2ZWwK
