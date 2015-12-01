From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 8/9] ALSA: hda - Skip ELD notification during
	PM process
Date: Tue,  1 Dec 2015 17:09:57 +0100
Message-ID: <1448986198-3488-9-git-send-email-tiwai@suse.de>
References: <1448986198-3488-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <1448986198-3488-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, David Henningsson <david.henningsson@canonical.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

VGhlIEVMRCBub3RpZmljYXRpb24gY2FuIGJlIHJlY2VpdmVkIGFzeW5jaHJvbm91c2x5IGZyb20g
dGhlIGdyYXBoaWNzCnNpZGUsIGFuZCB0aGlzIG1heSBoYXBwZW4ganVzdCBhdCB0aGUgbW9tZW50
IHRoZSBzb3VuZCBkcml2ZXIgaXMKcHJvY2Vzc2luZyB0aGUgc3VzcGVuZCBvciB0aGUgcmVzdW1l
LCBhbmQgaXQgd291bGQgY29uZnVzZSB0aGUgd2hvbGUKcHJvY2VkdXJlLiAgU2luY2UgdGhlIEVM
RCBhbmQgY29ubmVjdGlvbiBzdGF0ZXMgYXJlIHVwZGF0ZWQgaW4gYW55d2F5CmF0IHRoZSBlbmQg
b2YgdGhlIHJlc3VtZSwgd2UgY2FuIHNraXAgaXQgd2hlbiByZWNlaXZlZCBkdXJpbmcgUE0KcHJv
Y2Vzcy4KClNpZ25lZC1vZmYtYnk6IFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5kZT4KLS0tCiBz
b3VuZC9wY2kvaGRhL3BhdGNoX2hkbWkuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMgYi9zb3Vu
ZC9wY2kvaGRhL3BhdGNoX2hkbWkuYwppbmRleCA0ZGMyMWVjZjcyMzAuLjc1ODE1YWNiNzdkYiAx
MDA2NDQKLS0tIGEvc291bmQvcGNpL2hkYS9wYXRjaF9oZG1pLmMKKysrIGIvc291bmQvcGNpL2hk
YS9wYXRjaF9oZG1pLmMKQEAgLTI0NTAsNiArMjQ1MCw5IEBAIHN0YXRpYyB2b2lkIGludGVsX3Bp
bl9lbGRfbm90aWZ5KHZvaWQgKmF1ZGlvX3B0ciwgaW50IHBvcnQpCiAJICovCiAJaWYgKHNuZF9w
b3dlcl9nZXRfc3RhdGUoY29kZWMtPmNhcmQpICE9IFNORFJWX0NUTF9QT1dFUl9EMCkKIAkJcmV0
dXJuOworCS8qIGRpdHRvIGR1cmluZyBzdXNwZW5kL3Jlc3VtZSBwcm9jZXNzIGl0c2VsZiAqLwor
CWlmIChhdG9taWNfcmVhZCgmKGNvZGVjKS0+Y29yZS5pbl9wbSkpCisJCXJldHVybjsKIAogCS8q
IGV4ZWN1dGUgRUxEIHVwZGF0ZSBpbiBhIHdvcmsgZm9yIGF2b2lkaW5nIGEgZGVhZGxvY2sgKi8K
IAlwZXJfcGluID0gZ2V0X3BpbihzcGVjLCBwaW5faWR4KTsKLS0gCjIuNi4zCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpJbnRlbC1nZnggbWFpbGluZyBs
aXN0CkludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeAo=
