From: =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 2/2] ASoC: fsl: Fix sound on mx31moboard
Date: Tue,  1 Oct 2013 14:36:11 +0200
Message-ID: <1380630971-11431-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: broonie@kernel.org
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, s.hauer@pengutronix.de, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Q29tbWl0IDQyODEwZCAoQVNvQzogaW14LW1jMTM3ODM6IEFkZCBhdWRtdXggc2V0dGluZ3MgZm9y
IG14MjdwZGspIGJyb2tlCnRoZSBzb3VuZCBvbiBteDMxbW9ib2FyZC4gUmVzdG9yZSBiYWNrIHRo
ZSBhdWRtdXggc2V0dGluZyBvbiBzdWNoIGJvYXJkcy4KClNpZ25lZC1vZmYtYnk6IFBoaWxpcHBl
IFLDqXRvcm5heiA8cGhpbGlwcGUucmV0b3JuYXpAZXBmbC5jaD4KLS0tCiBzb3VuZC9zb2MvZnNs
L2lteC1tYzEzNzgzLmMgfCAgICAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9zb2MvZnNsL2lteC1tYzEzNzgzLmMg
Yi9zb3VuZC9zb2MvZnNsL2lteC1tYzEzNzgzLmMKaW5kZXggYTNkNjBkNC4uYTJmZDczMiAxMDA2
NDQKLS0tIGEvc291bmQvc29jL2ZzbC9pbXgtbWMxMzc4My5jCisrKyBiL3NvdW5kL3NvYy9mc2wv
aW14LW1jMTM3ODMuYwpAQCAtMTEyLDcgKzExMiw3IEBAIHN0YXRpYyBpbnQgaW14X21jMTM3ODNf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAkJcmV0dXJuIHJldDsKIAl9CiAK
LQlpZiAobWFjaGluZV9pc19teDMxXzNkcygpKSB7CisJaWYgKG1hY2hpbmVfaXNfbXgzMV8zZHMo
KSB8fCBtYWNoaW5lX2lzX214MzFtb2JvYXJkKCkpIHsKIAkJaW14X2F1ZG11eF92Ml9jb25maWd1
cmVfcG9ydChNWDMxX0FVRE1VWF9QT1JUNF9TU0lfUElOU180LAogCQkJSU1YX0FVRE1VWF9WMl9Q
VENSX1NZTiwKIAkJCUlNWF9BVURNVVhfVjJfUERDUl9SWERTRUwoTVgzMV9BVURNVVhfUE9SVDFf
U1NJMCkgfAotLSAKMS43LjkuNQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
