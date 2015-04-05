From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 9/9] sound/ppc/snd_ps3.c: fix error return code
Date: Sun,  5 Apr 2015 13:38:33 +0200
Message-ID: <1428233914-4503-9-git-send-email-Julia.Lawall@lip6.fr>
References: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
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
To: Geoff Levand <geoff@infradead.org>
Cc: cbe-oss-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

RnJvbTogSnVsaWEgTGF3YWxsIDxKdWxpYS5MYXdhbGxAbGlwNi5mcj4KCkluaXRpYWxpemUgcmV0
IGJlZm9yZSByZXR1cm5pbmcgb24gZmFpbHVyZSwgYXMgZG9uZSBlbHNld2hlcmUgaW4gdGhlCmZ1
bmN0aW9uLgoKQSBzaW1wbGlmaWVkIHZlcnNpb24gb2YgdGhlIHNlbWFudGljIG1hdGNoIHRoYXQg
ZmluZHMgdGhpcyBwcm9ibGVtIGlzIGFzCmZvbGxvd3M6IChodHRwOi8vY29jY2luZWxsZS5saXA2
LmZyLykKCi8vIDxzbXBsPgooCmlmQHAxIChcKHJldCA8IDBcfHJldCAhPSAwXCkpCiB7IC4uLiBy
ZXR1cm4gcmV0OyB9CnwKcmV0QHAxID0gMAopCi4uLiB3aGVuICE9IHJldCA9IGUxCiAgICB3aGVu
ICE9ICZyZXQKKmlmKC4uLikKewogIC4uLiB3aGVuICE9IHJldCA9IGUyCiAgICAgIHdoZW4gZm9y
YWxsCiByZXR1cm4gcmV0Owp9CgovLyA8L3NtcGw+CgpTaWduZWQtb2ZmLWJ5OiBKdWxpYSBMYXdh
bGwgPEp1bGlhLkxhd2FsbEBsaXA2LmZyPgoKLS0tCiBzb3VuZC9wcGMvc25kX3BzMy5jIHwgICAg
MSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9zb3VuZC9w
cGMvc25kX3BzMy5jIGIvc291bmQvcHBjL3NuZF9wczMuYwppbmRleCAxYWE1MmVmLi45YjE4YjUy
IDEwMDY0NAotLS0gYS9zb3VuZC9wcGMvc25kX3BzMy5jCisrKyBiL3NvdW5kL3BwYy9zbmRfcHMz
LmMKQEAgLTEwNDAsNiArMTA0MCw3IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IHNuZF9wczNfZHJp
dmVyX3Byb2JlKHN0cnVjdCBwczNfc3lzdGVtX2J1c19kZXZpY2UgKmRldikKIAkJCQkgICBHRlBf
S0VSTkVMKTsKIAlpZiAoIXRoZV9jYXJkLm51bGxfYnVmZmVyX3N0YXJ0X3ZhZGRyKSB7CiAJCXBy
X2luZm8oIiVzOiBudWxsYnVmZmVyIGFsbG9jIGZhaWxlZFxuIiwgX19mdW5jX18pOworCQlyZXQg
PSAtRU5PTUVNOwogCQlnb3RvIGNsZWFuX3ByZWFsbG9jYXRlOwogCX0KIAlwcl9kZWJ1ZygiJXM6
IG51bGwgdmFkZHI9JXAgZG1hPSUjbGx4XG4iLCBfX2Z1bmNfXywKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QK
TGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xp
c3RpbmZvL2xpbnV4cHBjLWRldg==
