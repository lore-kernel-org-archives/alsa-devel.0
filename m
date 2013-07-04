From: Jordi Mallach <jordi@debian.org>
Subject: Re: [PATCH] Add -lm to test programs to fix build
 failure.
Date: Thu, 04 Jul 2013 09:29:29 +0200
Message-ID: <1372922969.19157.20.camel@penyagolosa.oskuro.net>
References: <1372424744-27504-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id DB8E926569A
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 09:29:31 +0200 (CEST)
Received: from [192.168.1.140] (167.22.15.37.dynamic.jazztel.es [37.15.22.167])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id DBFE661DF2
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 09:29:41 +0200 (CEST)
In-Reply-To: <1372424744-27504-1-git-send-email-jordi@debian.org>
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

VGFrYXNoaSwgZGlkIHlvdSBzZWUgdGhlIHBvc3QgYmVsb3cgZnJvbSBsYXN0IEZyaWRheT8KClRo
YW5rcywKSm9yZGkKCkVsIGR2IDI4IGRlIDA2IGRlIDIwMTMgYSBsZXMgMTU6MDUgKzAyMDAsIGVu
L25hIEpvcmRpIE1hbGxhY2ggdmEKZXNjcml1cmU6Cj4gQWRkIC1sbSB0byB0ZXN0IHByb2dyYW1z
IHRoYXQgdXNlIHNpbigpLCB0byBmaXggYSBidWlsZCBmYWlsdXJlIHdpdGggcmVjZW50Cj4gYmlu
dXRpbHMuCj4gCj4gU2lnbmVkLW9mZi1ieTogSm9yZGkgTWFsbGFjaCA8am9yZGlAZGViaWFuLm9y
Zz4KPiAtLS0KPiAgdGVzdC9NYWtlZmlsZS5hbSB8IDIgKysKPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0L01ha2VmaWxlLmFtIGIvdGVzdC9N
YWtlZmlsZS5hbQo+IGluZGV4IDg3MDU0MDIuLmMxODk2ZjggMTAwNjQ0Cj4gLS0tIGEvdGVzdC9N
YWtlZmlsZS5hbQo+ICsrKyBiL3Rlc3QvTWFrZWZpbGUuYW0KPiBAQCAtNyw4ICs3LDEwIEBAIGNo
ZWNrX1BST0dSQU1TPWNvbnRyb2wgcGNtIHBjbV9taW4gbGF0ZW5jeSBzZXEgXAo+ICAKPiAgY29u
dHJvbF9MREFERD0uLi9zcmMvbGliYXNvdW5kLmxhCj4gIHBjbV9MREFERD0uLi9zcmMvbGliYXNv
dW5kLmxhCj4gK3BjbV9MREZMQUdTPSAtbG0KPiAgcGNtX21pbl9MREFERD0uLi9zcmMvbGliYXNv
dW5kLmxhCj4gIGxhdGVuY3lfTERBREQ9Li4vc3JjL2xpYmFzb3VuZC5sYQo+ICtsYXRlbmN5X0xE
RkxBR1M9IC1sbQo+ICBzZXFfTERBREQ9Li4vc3JjL2xpYmFzb3VuZC5sYQo+ICBwbGF5bWlkaTFf
TERBREQ9Li4vc3JjL2xpYmFzb3VuZC5sYQo+ICB0aW1lcl9MREFERD0uLi9zcmMvbGliYXNvdW5k
LmxhCgotLSAKSm9yZGkgTWFsbGFjaCBQw6lyZXogIC0tICBEZWJpYW4gZGV2ZWxvcGVyICAgICBo
dHRwOi8vd3d3LmRlYmlhbi5vcmcvCmpvcmRpQHNpbmRvbWluaW8ubmV0ICAgICBqb3JkaUBkZWJp
YW4ub3JnICAgICBodHRwOi8vd3d3LnNpbmRvbWluaW8ubmV0LwpHbnVQRyBwdWJsaWMga2V5IGlu
Zm9ybWF0aW9uIGF2YWlsYWJsZSBhdCBodHRwOi8vb3NrdXJvLm5ldC8KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0
CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
