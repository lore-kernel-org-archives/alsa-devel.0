From: Daniel Yek <dyek@real.com>
Subject: Re: How to close ALSA device nodes? / ALSA's fds
Date: Fri, 23 Oct 2009 11:51:45 -0700
Message-ID: <4AE1FB41.2020408@real.com>
References: <200910182038.34252.rem@videolan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kal-el.real.com (kal-el.real.com [207.188.23.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 19F9A1037F8
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Oct 2009 20:51:47 +0200 (CEST)
In-Reply-To: <200910182038.34252.rem@videolan.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?UsOpbWkgRGVuaXMtQ291cm1vbnQ=?= <rem@videolan.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

W0JyYW5jaCB0aGUgdGhyZWFkIGZvciBhIHNlcGFyYXRlIHN1Z2dlc3Rpb24uLi5dCgpSw6ltaSBE
ZW5pcy1Db3VybW9udCB3cm90ZToKPiBMZSBkaW1hbmNoZSAxOCBvY3RvYnJlIDIwMDkgMjA6MTM6
MTUgUm9iZXJ0IEhhbmNvY2ssIHZvdXMgYXZleiDDqWNyaXQgOgo+Pj4gRnJvbSB0aGUgZWFybGll
ciB0aHJlYWQsIEkgcmVja29uIHRoYXQgQUxTQSBkZXZlbG9wZXJzIGNvbnNpZGVyIHRoYXQKPj4+
IHRoaXMKPj4+IGlzIGFuIHVwcGVyLWxheWVyIGlzc3VlLiBNYXliZSBzbywgYnV0IHRoZW4gaG93
IGlzIHRoZSB1cHBlci1sYXllcgo+Pj4gc3VwcG9zZWQgdG8gZmluZCB3aGljaCBmaWxlIGRlc2Ny
aXB0b3JzIEFMU0EtbGliIGhhcyBvcGVuZWQgLSBpZiBhbnk/Cj4+PiBDb252ZXJzZWx5LCBpZiBB
TFNBLSBsaWIgd29uJ3QgdGVsbCB3aGlsZSBmaWxlIGRlc2NyaXB0b3JzIGl0IGlzIHVzaW5nLAo+
Pj4gd2hhdCBjb3VsZCBwb3NzaWJseSBiZSB0aGUgdXNlIGNhc2UgZm9yIG5vdCBjbG9zaW5nIHRo
b3NlIG9uIGV4ZWM/Cj4+IEkgYWdyZWUgdGhhdCBpdCdzIGEgZGlmZmljdWx0IHByb2JsZW0gZm9y
IGFuIGFwcCB0aGF0IHdhbnRzIHRvIGZvcmsKPj4gYW5kIGV4ZWMgYW5vdGhlciBwcm9jZXNzLi4g
SSdkIHRoaW5rIHJlYWxseSBzaG91bGQgYmUgc29tZSB3YXkgZm9yIGFuCj4+IGFwcCB0byBjb250
cm9sIHRoZSBDTE9FWEVDIGZsYWcgZm9yIHRoZSBmaWxlIGRlc2NyaXB0b3JzIHRoYXQgYWxzYS1s
aWIKPj4gaGFzIG9wZW4uLgo+IDxzbmlwPgo+Cj4gVGhhdCBzYWlkLCBJIHN0aWxsIGZhaWwgdG8g
c2VlIGFueSBwb3RlbnRpYWwgdXNlIGNhc2UgdG8gbm90IHNldCB0aGUKPiBmbGFnLgo+IFNpbmNl
IEFMU0EtbGliIHdvbid0IGxldCB0aGUgYXBwbGljYXRpb24ga25vdyBhYm91dCB0aGUgZmlsZSBo
YW5kbGVzLCBhbnkKPiBhcHBsaWNhdGlvbiBjYW5ub3QgYSB1c2UgdGhlbSBhY3Jvc3MgZXhlYygp
IGluIHRoZSBmaXJzdCBwbGFjZS4KCklzIHNuZF9wY21fcG9sbF9kZXNjcmlwdG9ycygpIGFkZXF1
YXRlIGZvciB0aGlzIHBhcnRpY3VsYXIgaXNzdWU/CgpSZWdhcmRzLAoKLS0gCkRhbmllbCBZZWsu
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1k
ZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
