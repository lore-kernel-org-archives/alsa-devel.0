From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Subject: Re: [PATCH v3 4/6] ALSA: xen-front: Implement handling
 of shared buffers
Date: Thu, 17 May 2018 09:33:04 +0300
Message-ID: <847efda8-2b8e-fe71-454e-677566b7a825@epam.com>
References: <20180514062742.25879-1-andr2000@gmail.com>
 <20180514062742.25879-5-andr2000@gmail.com> <s5ho9hi56ds.wl-tiwai@suse.de>
 <e37b5170-4fab-0c06-8902-730e57118ceb@gmail.com>
 <s5h8t8l5ufq.wl-tiwai@suse.de>
 <19a2c003-6730-265a-29aa-1eedd37147b9@epam.com>
 <s5ho9he94s7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40082.outbound.protection.outlook.com [40.107.4.82])
 by alsa0.perex.cz (Postfix) with ESMTP id DF30126707F
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 08:33:09 +0200 (CEST)
In-Reply-To: <s5ho9he94s7.wl-tiwai@suse.de>
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

T24gMDUvMTcvMjAxOCAwOToyNiBBTSwgVGFrYXNoaSBJd2FpIHdyb3RlOgo+IE9uIFR1ZSwgMTUg
TWF5IDIwMTggMDg6MDI6MDggKzAyMDAsCj4gT2xla3NhbmRyIEFuZHJ1c2hjaGVua28gd3JvdGU6
Cj4+IE9uIDA1LzE1LzIwMTggMDk6MDEgQU0sIFRha2FzaGkgSXdhaSB3cm90ZToKPj4+IE9uIFR1
ZSwgMTUgTWF5IDIwMTggMDc6NDY6MzggKzAyMDAsCj4+PiBPbGVrc2FuZHIgQW5kcnVzaGNoZW5r
byB3cm90ZToKPj4+PiBPbiAwNS8xNC8yMDE4IDExOjI4IFBNLCBUYWthc2hpIEl3YWkgd3JvdGU6
Cj4+Pj4+IE9uIE1vbiwgMTQgTWF5IDIwMTggMDg6Mjc6NDAgKzAyMDAsCj4+Pj4+IE9sZWtzYW5k
ciBBbmRydXNoY2hlbmtvIHdyb3RlOgo+Pj4+Pj4gLS0tIC9kZXYvbnVsbAo+Pj4+Pj4gKysrIGIv
c291bmQveGVuL3hlbl9zbmRfZnJvbnRfc2hidWYuYwo+Pj4+Pj4gQEAgLTAsMCArMSwxOTMgQEAK
Pj4+Pj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBNSVQKPj4+Pj4+
ICsKPj4+Pj4+ICsvKgo+Pj4+Pj4gKyAqIFhlbiBwYXJhLXZpcnR1YWwgc291bmQgZGV2aWNlCj4+
Pj4+PiArICoKPj4+Pj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMTYtMjAxOCBFUEFNIFN5c3RlbXMg
SW5jLgo+Pj4+Pj4gKyAqCj4+Pj4+PiArICogQXV0aG9yOiBPbGVrc2FuZHIgQW5kcnVzaGNoZW5r
byA8b2xla3NhbmRyX2FuZHJ1c2hjaGVua29AZXBhbS5jb20+Cj4+Pj4+PiArICovCj4+Pj4+PiAr
Cj4+Pj4+PiArI2luY2x1ZGUgPHhlbi94ZW4uaD4KPj4+Pj4+ICsjaW5jbHVkZSA8eGVuL3hlbmJ1
cy5oPgo+Pj4+Pj4gKwo+Pj4+Pj4gKyNpbmNsdWRlICJ4ZW5fc25kX2Zyb250X3NoYnVmLmgiCj4+
Pj4+IEhtLCB3aXRoIHRoZSBsb2NhbCBidWlsZCB0ZXN0LCBJIGdldCB0aGUgZm9sbG93aW5nIGVy
cm9yOgo+Pj4+Pgo+Pj4+PiAgICAgIENDIFtNXSAgc291bmQveGVuL3hlbl9zbmRfZnJvbnRfc2hi
dWYubwo+Pj4+PiAgICAgIEluIGZpbGUgaW5jbHVkZWQgZnJvbSBzb3VuZC94ZW4veGVuX3NuZF9m
cm9udF9zaGJ1Zi5jOjExOjA6Cj4+Pj4+ICAgICAgLi9pbmNsdWRlL3hlbi94ZW4uaDoxODo4OiBl
cnJvcjogdW5rbm93biB0eXBlIG5hbWUg4oCYYm9vbOKAmQo+Pj4+PiAgICAgICBleHRlcm4gYm9v
bCB4ZW5fcHZoOwo+Pj4+PiAgICAgICAgICAgICAgIF5+fn4KPj4+Pj4gICAgICAgSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIC4vaW5jbHVkZS94ZW4vaW50ZXJmYWNlL3hlbi5oOjMwOjAsCj4+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUveGVuL3hlbi5oOjI5LAo+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgIGZyb20gc291bmQveGVuL3hlbl9zbmRfZnJvbnRfc2hidWYu
YzoxMToKPj4+Pj4gICAgICAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL3hlbi9pbnRlcmZhY2UuaDo5
MjoyMTogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lIOKAmHVpbnQ2NF904oCZCj4+Pj4+ICAgICAg
IERFRklORV9HVUVTVF9IQU5ETEUodWludDY0X3QpOwo+Pj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4KPj4+Pj4gCQkJCj4+Pj4+IEFkZGluZyAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+
IGZpeGVkIHRoZSBpc3N1ZS4KPj4+Pj4KPj4+Pj4gRGlkIHlvdSByZWFsbHkgdGVzdCB5b3VyIHBh
dGNoZXMgd2l0aCB0aGUgbGF0ZXN0IExpbnVzIHRyZWU/Cj4+Pj4gTXkgYmFkLCBpdCBkb2VzIGJ1
aWxkIGZvciBBUk0gKHdoaWNoIGlzIG15IHRhcmdldCksIGJ1dCBhbHNvIGRvZXMKPj4+PiBuZWVk
ICIjaW5jbHVkZSA8bGludXgva2VybmVsLmg+IiBmb3IgeDg2IHdoaWNoIEkgZGlkbid0IGJ1aWxk
IHRoaXMgdGltZS4KPj4+PiBTb3JyeSBhYm91dCB0aGF0Lgo+Pj4+Cj4+Pj4gRG8geW91IHdhbnQg
bWUgdG8gcmVzZW5kIHRoaXMgc2luZ2xlIHBhdGNoIG9yIHlvdSBjYW4gbWFrZSB0aGUgY2hhbmdl
Cj4+Pj4gd2hpbGUgYXBwbHlpbmc/Cj4+PiBZZXMsIGl0J3MgZmluZS4KPj4gVGhhbmsgeW91Cj4g
RldJVywgdGhlIHBhdGNoZXMgYXJlIGluIHRvcGljL3hlbiBicmFuY2ggaW4gc291bmQuZ2l0IHRy
ZWUsIGFuZCBJJ2xsCj4ga2VlcCBib2lsaW5nIGZvciBhIHdoaWxlIHRvIHNlZSBpZiBhbnkgaXNz
dWVzIGFyZSBjYXVnaHQgYnkgMGRheSBib3QuClRoYW5rIHlvdSwgaG9wZSBldmVyeXRoaW5nIGdv
ZXMgd2VsbAo+Cj4gVGFrYXNoaQpUaGFuayB5b3UsCk9sZWtzYW5kcgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
