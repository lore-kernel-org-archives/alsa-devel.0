From: =?UTF-8?q?Johan=20Rast=C3=A9n?= <johan@oljud.se>
Subject: [PATCH 1/1] usb-audio: Set correct type for some UAC2
	mixer controls.
Date: Thu, 11 Jun 2015 10:04:51 +0200
Message-ID: <1434009891-16276-1-git-send-email-johan@oljud.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, =?UTF-8?q?Johan=20Rast=C3=A9n?= <johan@oljud.se>
List-Id: alsa-devel@alsa-project.org

Q2hhbmdlZCBjdGwgdHlwZSBmb3IgSW5wdXQgR2FpbiBDb250cm9sIGFuZCBJbnB1dCBHYWluIFBh
ZCBDb250cm9sIHRvClVTQl9NSVhFUl9TMTYgYXMgcGVyIHNlY3Rpb24gNS4yLjUuNy4xMS0xMiBp
biB0aGUgVVNCIEF1ZGlvIENsYXNzIDIuMApkZWZpbml0aW9uLgoKU2lnbmVkLW9mZi1ieTogSm9o
YW4gUmFzdMOpbiA8am9oYW5Ab2xqdWQuc2U+CgpkaWZmIC0tZ2l0IGEvc291bmQvdXNiL21peGVy
LmMgYi9zb3VuZC91c2IvbWl4ZXIuYwppbmRleCA4YjdlMzkxLi42YjNhY2JhIDEwMDY0NAotLS0g
YS9zb3VuZC91c2IvbWl4ZXIuYworKysgYi9zb3VuZC91c2IvbWl4ZXIuYwpAQCAtODA5LDEyICs4
MDksMTIgQEAgc3RhdGljIHN0cnVjdCB1c2JfZmVhdHVyZV9jb250cm9sX2luZm8gYXVkaW9fZmVh
dHVyZV9pbmZvW10gPSB7CiAJeyAiVG9uZSBDb250cm9sIC0gVHJlYmxlIiwJVVNCX01JWEVSX1M4
IH0sCiAJeyAiR3JhcGhpYyBFcXVhbGl6ZXIiLAkJVVNCX01JWEVSX1M4IH0sIC8qIEZJWE1FOiBu
b3QgaW1wbGVtZXRlZCB5ZXQgKi8KIAl7ICJBdXRvIEdhaW4gQ29udHJvbCIsCQlVU0JfTUlYRVJf
Qk9PTEVBTiB9LAotCXsgIkRlbGF5IENvbnRyb2wiLAkJVVNCX01JWEVSX1UxNiB9LAorCXsgIkRl
bGF5IENvbnRyb2wiLAkJVVNCX01JWEVSX1UxNiB9LCAvKiBGSVhNRTogVTMyIGluIFVBQzIgKi8K
IAl7ICJCYXNzIEJvb3N0IiwJCQlVU0JfTUlYRVJfQk9PTEVBTiB9LAogCXsgIkxvdWRuZXNzIiwJ
CQlVU0JfTUlYRVJfQk9PTEVBTiB9LAogCS8qIFVBQzIgc3BlY2lmaWMgKi8KLQl7ICJJbnB1dCBH
YWluIENvbnRyb2wiLAkJVVNCX01JWEVSX1UxNiB9LAotCXsgIklucHV0IEdhaW4gUGFkIENvbnRy
b2wiLAlVU0JfTUlYRVJfQk9PTEVBTiB9LAorCXsgIklucHV0IEdhaW4gQ29udHJvbCIsCQlVU0Jf
TUlYRVJfUzE2IH0sCisJeyAiSW5wdXQgR2FpbiBQYWQgQ29udHJvbCIsCVVTQl9NSVhFUl9TMTYg
fSwKIAl7ICJQaGFzZSBJbnZlcnRlciBDb250cm9sIiwJVVNCX01JWEVSX0JPT0xFQU4gfSwKIH07
CiAKLS0gCjIuMS40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcK
aHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
