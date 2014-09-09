From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Asynchronous ALSA - callback and latency questions
Date: Tue, 09 Sep 2014 13:23:50 +0200
Message-ID: <540EE346.3050908@ladisch.de>
References: <1135001813.415555.1410192193064.open-xchange@upcmail.upc.nl>
 <540EB957.7030705@ladisch.de>
 <975727754.436995.1410252241332.open-xchange@upcmail.upc.nl>
 <s5ha969fa4c.wl-tiwai@suse.de>
 <901056793.444760.1410259814514.open-xchange@upcmail.upc.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 01B2C265055
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 13:23:52 +0200 (CEST)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by dehamd003.servertools24.de (Postfix) with ESMTPSA id 1018AF808F
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 13:23:23 +0200 (CEST)
In-Reply-To: <901056793.444760.1410259814514.open-xchange@upcmail.upc.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

QnJhbSBCb3Mgd3JvdGU6Cj4+Pj4+IEnigJltIHVzaW5nIEFMU0EgZm9yIGJ1aWxkaW5nIGEgcGVy
Zm9ybWFuY2UgbXVzaWNhbCBpbnN0cnVtZW50LCBzbyBJ4oCZbQo+Pj4+PiBhZnRlcgo+Pj4+PiBs
b3ctbGF0ZW5jeSBhdWRpbyBvdXRwdXQuCj4+Pj4+Cj4+Pj4+IDEuIEnigJltIHVzaW5nIGFzeW5j
aHJvbm91cyBhdWRpbyBvdXRwdXQgKGkuZS4gdXNpbmcgYSBjYWxsYmFjaykuCj4+Pj4KPj4+PiBE
b24ndC4KPj4+Cj4+PiBUaGF0J3MgYW4gaW50ZXJlc3RpbmcgaW5zaWdodC4gSSByZWNrb25lZCB1
c2luZyBhIGNhbGxiYWNrIHdhcyB0aGUgbW9zdCBlbGVnYW50Cj4+PiBzb2x1dGlvbiBzaW5jZSB0
aGF0J3Mgd2hhdCBJJ20gdXNlZCB0byBmb3IgRGlyZWN0U291bmQsIGlPUywgT1NYLCBXTU1FLCBB
U0lPIGV0Yy4KPj4KPj4gSWYgeW91IHdhbnQgdG8gZ28gaW4gdGhhdCBkaXJlY3Rpb24sIGp1c3Qg
dXNlIEpBQ0suCj4KPiBBbmQgdGhlIG5leHQgYmVzdCBhbHRlcm5hdGl2ZSB3b3VsZCBiZSBibG9j
a2VkLW1vZGUvcG9sbGluZyB0aHJvdWdoIEFMU0EsIHRoZW4/CgpZZXMuICAoVGhhdCdzIHdoYXQg
SmFjayB1c2VzOyB3aXRoIGZ1bGwgZHVwbGV4LCB5b3UgYWxyZWFkeSBuZWVkIHRvIGhhbmRsZQpt
dWx0aXBsZSBkZXZpY2VzLikKCgpSZWdhcmRzLApDbGVtZW5zCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2Et
ZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
