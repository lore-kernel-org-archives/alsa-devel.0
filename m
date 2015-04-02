From: Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH] drm/edid: add #defines for ELD versions
Date: Thu,  2 Apr 2015 13:52:00 +0300
Message-ID: <1427971920-3830-1-git-send-email-jani.nikula@intel.com>
References: <20150401115602.GB24899@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20150401115602.GB24899@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jani Nikula <jani.nikula@linux.intel.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Yakir Yang <ykk@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

QWRkIEVMRCB2ZXJzaW9ucyBhY2NvcmRpbmcgdG8gSERBIFNwZWNpZmljYXRpb24gdjEuMGEuCgoy
IGluZGljYXRlcyB2ZXJzaW9uIDIsIHdoaWNoIHN1cHBvcnRzIENFQV9WZXIgODYxRCBvciBiZWxv
dy4gTWF4aW11bQpCYXNlbGluZSBFTEQgc2l6ZSBvZiA4MCBieXRlcyAoMTUgU0FEIGNvdW50KS4K
CjMxIGluZGljYXRlcyBhbiBFTEQgdGhhdCBoYXMgYmVlbiBwYXJ0aWFsbHkgcG9wdWxhdGVkIHRo
cm91Z2gKaW1wbGVtZW50YXRpb24gc3BlY2lmaWMgbWVhbiBvZiBkZWZhdWx0IHByb2dyYW1taW5n
IGJlZm9yZSBhbiBleHRlcm5hbApncmFwaGljcyBkcml2ZXIgaXMgbG9hZGVkLiBPbmx5IHRoZSBm
aWVsZCB0aGF0IGlzIGNhbGxlZCBvdXQgYXMgImNhbm5lZCIKZmllbGQgd2lsbCBiZSBwb3B1bGF0
ZWQsIGFuZCBhdWRpbyBkcml2ZXIgc2hvdWxkIGlnbm9yZSB0aGUgbm9uICJjYW5uZWQiCmZpZWxk
LgoKU2lnbmVkLW9mZi1ieTogSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGludGVsLmNvbT4KCi0t
LQoKUnVzc2VsbCwgcGxlYXNlIGZlZWwgZnJlZSB0byBpbmNsdWRlIHRoaXMgcGF0Y2ggaW4geW91
ciBzZXJpZXMgaWYgdGhpcwppc24ndCBwaWNrZWQgdXAgb24gaXRzIG93bi4KLS0tCiBpbmNsdWRl
L2RybS9kcm1fZWRpZC5oIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9lZGlkLmggYi9pbmNsdWRlL2RybS9kcm1fZWRp
ZC5oCmluZGV4IDg3ZDg1ZTgxZDNhNy4uNzk5MDUwMTk4MzIzIDEwMDY0NAotLS0gYS9pbmNsdWRl
L2RybS9kcm1fZWRpZC5oCisrKyBiL2luY2x1ZGUvZHJtL2RybV9lZGlkLmgKQEAgLTIxNSw2ICsy
MTUsOCBAQCBzdHJ1Y3QgZGV0YWlsZWRfdGltaW5nIHsKICNkZWZpbmUgRFJNX0VMRF9WRVIJCQkw
CiAjIGRlZmluZSBEUk1fRUxEX1ZFUl9TSElGVAkJMwogIyBkZWZpbmUgRFJNX0VMRF9WRVJfTUFT
SwkJKDB4MWYgPDwgMykKKyMgZGVmaW5lIERSTV9FTERfVkVSX0NFQTg2MUQJCSgyIDw8IDMpIC8q
IHN1cHBvcnRzIDg2MUQgb3IgYmVsb3cgKi8KKyMgZGVmaW5lIERSTV9FTERfVkVSX0NBTk5FRAkJ
KDB4MWYgPDwgMykKIAogI2RlZmluZSBEUk1fRUxEX0JBU0VMSU5FX0VMRF9MRU4JMgkvKiBpbiBk
d29yZHMhICovCiAKLS0gCjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAo=
