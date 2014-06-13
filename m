From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [RFC][PATCH 0/2] Add ASRC Peripheral to Peripheral driver
Date: Fri, 13 Jun 2014 18:07:03 +0800
Message-ID: <cover.1402653667.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: broonie@kernel.org, vinod.koul@intel.com, s.hauer@pengutronix.de
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de, linux-kernel@vger.kernel.org, b02247@freescale.com, rdunlap@infradead.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, b38343@freescale.com, perex@perex.cz, dmaengine@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, grant.likely@linaro.org, dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

VGhpcyBzZXJpZXMgb2YgcGF0Y2hlcyBoYXZlIGEgZGlyZWN0IGRlcGVuZGVuY3kgYmV0d2VlbiB0
aGVtLiBTbyB3ZSBtaWdodApuZWVkIHRvIHB1c2ggdGhlbSBpbnRvIG9uZSBicmFuY2guIEFuZCBz
b3JyeSBmb3IgdGhpcyA6KAoKUGF0Y2gtMSBhZGRzIGRldmljZSB0byBkZXZpY2Ugc3VwcG9ydCBp
biBTRE1BIGRyaXZlciBhbG9uZyB3aXRoIGEgc2Vjb25kYXJ5CnJlcXVlc3QgaW4gc3RydWN0IGlt
eF9kbWFfZGF0YSB3aGljaCdzIHJlcXVyZWQgaW4gdGhlIFBhdGNoLTIgQVNSQyBkcml2ZXIuCgpO
aWNvbGluIENoZW4gKDIpOgogIGRtYTogaW14LXNkbWE6IEFkZCBkZXZpY2UgdG8gZGV2aWNlIHN1
cHBvcnQKICBBU29DOiBmc2xfYXNyYzogQWRkIEFTUkMgQVNvQyBDUFUgREFJIGFuZCBwbGF0Zm9y
bSBkcml2ZXJzCgogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvZnNsLGFzcmMudHh0ICAg
ICAgICAgfCAgIDYyICsrCiBkcml2ZXJzL2RtYS9pbXgtc2RtYS5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgNDAgKy0KIGluY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9kbWEtaW14
LmggICAgICAgICAgICAgIHwgICAgMSArCiBzb3VuZC9zb2MvZnNsL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgIDkgKwogc291bmQvc29jL2ZzbC9NYWtlZmlsZSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAyICsKIHNvdW5kL3NvYy9mc2wvZnNsX2FzcmMu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTAzMSArKysrKysrKysrKysrKysrKysrKwog
c291bmQvc29jL2ZzbC9mc2xfYXNyYy5oICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNDMx
ICsrKysrKysrCiBzb3VuZC9zb2MvZnNsL2ZzbF9hc3JjX2RtYS5jICAgICAgICAgICAgICAgICAg
ICAgICB8ICAzODUgKysrKysrKysKIDggZmlsZXMgY2hhbmdlZCwgMTk1NiBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb3VuZC9mc2wsYXNyYy50eHQKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3Vu
ZC9zb2MvZnNsL2ZzbF9hc3JjLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvZnNsL2Zz
bF9hc3JjLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvZnNsL2ZzbF9hc3JjX2RtYS5j
CgotLSAKMS44LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5v
cmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
