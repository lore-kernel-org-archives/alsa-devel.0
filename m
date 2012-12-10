From: l9jj@163.com
Subject: Re: what is period_size, buffer_size and boundary size,
	i confuse them
Date: Mon, 10 Dec 2012 16:09:04 +0800 (GMT+08:00)
Message-ID: <5ec59db3.354.13b83dc3158.Coremail.l9jj@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m13-238.163.com (m13-238.163.com [220.181.13.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 10025260306
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2012 09:09:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cgp0aGFuayB5b3UgdmVyeSBtdWNoLgpidXQsCu+8iDHvvIl3aGF0IGlzIHRoZSByZWxhdGlvbnNo
aXAgYmV0d2VlbiBETUEgYnVmZmVyIHNpemUgYW5kIHRoZSBib3VuZGFyeQpzaXpl77yfZG9lcyAg
dGhlIHZhcmlhYmxlIGJ1ZmZlcl9zaXplIGVxdWFsIHRvICBETUEgc2l6Ze+8nwooMilob3cgdGhl
IHBvcz5idWZmZXJfc2l6ZSB3aWxsIGhhcHBlbiBpbiB0aGUgaW50ZXJmYWNlIHNuZF9wY21fdXBk
YXRlX2h3X3B0cjAoKe+8nyB0aGUgdmFyaWFibGUgcG9zIGlzIGluIHRoZSByYW5nZSBvZiBETUFf
c2l6Ze+8jGl0IGNhbiBub3QgYmlnZ2VyIHRoYW4gdGhlIGJ1ZmZlcl9zaXplLml0IGJsb2NrZWQg
bWUuCgp0aGFua3MgYSBsb3QuCgoK5ZyoIDIwMTItMTItMTAgMDA6MjM6NTUsIENsZW1lbnMgTGFk
aXNjaCA8Y2xlbWVuc0BsYWRpc2NoLmRlPuWGmemBkzoKbDlqaiB3cm90ZToKPiBjYW4gYW55b25l
IGhlbHAgbWUgdG8gZmlndXJlIG91dCAgdGhlIGNvbmNlcHRzIGJldHdlZW4gcGVyaW9kX3NpemUg
LGJ1ZmZlcl9zaXplIGFuZCBib3VuZGFyeSBzaXplPwo+IG4gKiBwZXJpb2Rfc2l6ZSA9IGJ1ZmZl
cl9zaXplPwoKWWVzLiAgT24gbWFueSBkZXZpY2VzLCBuIGlzIG5vdCByZXF1aXJlZCB0byBiZSBh
biBpbnRlZ2VyLgoKPiBtICogYnVmZmVyX3NpemUgPSBib3VuZGFyeV9zaXplPwoKWWVzLCB3aGVy
ZSBtIGlzIHZlcnkgYmlnLiAgSW4gYXBwbGljYXRpb25zLCB0aGUgYWN0dWFsIHZhbHVlIG9mIHRo
ZSBib3VuZGFyeQpzaXplIGRvZXMgbm90IG1hdHRlciAoZXhjZXB0IGFzIGEgc3BlY2lhbCB2YWx1
ZSBmb3Igc29tZSBzdyBwYXJhbXMpLgoKPiBhbmQgaG93IHRoZSBkbWEgYnVmZmVyIG1hcHBlZCB0
byB0aGUgYWxzYSBidWZmZXI/CgpUaGUgRE1BIGJ1ZmZlciBfaXNfIHRoZSBBTFNBIGJ1ZmZlci4K
CgpSZWdhcmRzLApDbGVtZW5zCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxz
YS1kZXZlbAoKCmw5ampAMTYzLmNvbQoKIOKAlOKAlOe9keaYk+mCrueuseaJi+acuuWuouaIt+er
r+KAlOKAlApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpB
bHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cDov
L21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
