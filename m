From: Daniel Chen <seven.steps@gmail.com>
Subject: [PATCH] ALSA: pcm: Properly close timer when freeing
	slaves
Date: Sun, 20 Dec 2009 15:27:08 -0500
Message-ID: <604760770912201227g60e71a3alb86f36c2a4da3d4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0a4ec07c635047b2ecc47
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f183.google.com (mail-px0-f183.google.com
	[209.85.216.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CE8110380D
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 21:27:10 +0100 (CET)
Received: by pxi13 with SMTP id 13so3180344pxi.24
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 12:27:08 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001636e0a4ec07c635047b2ecc47
Content-Type: text/plain; charset=UTF-8

Hi,

Here's a patch originally from Dan McCombs against alsa-lib.git HEAD
fixing a fairly nasty fd leak for timers.

Thanks,
Dan

--001636e0a4ec07c635047b2ecc47
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-ALSA-pcm-Properly-close-timer-when-freeing-slaves.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-pcm-Properly-close-timer-when-freeing-slaves.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g3g9qcyv0

RnJvbSBmMzEwOWU3YTEyMDJjYTgxZDU0NWJlZDQ1ZDk4NDkyNjQ5NWY2Njk5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5pZWwgVCBDaGVuIDxjcmltc3VuQHVidW50dS5jb20+CkRh
dGU6IFN1biwgMjAgRGVjIDIwMDkgMTU6MTM6MzkgLTA1MDAKU3ViamVjdDogW1BBVENIXSBBTFNB
OiBwY206IFByb3Blcmx5IGNsb3NlIHRpbWVyIHdoZW4gZnJlZWluZyBzbGF2ZXMKCkJ1Z0xpbms6
IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L2J1Z3MvNDUxODkzCgpEYW4gTWNDb21icyBkaXNj
b3ZlcmVkIHRoYXQgc25kX3BjbV9jbG9zZSgpIGludm9jYXRpb25zIGFyZSBub3QgbGVhZGluZwp0
byBhc3NvY2lhdGVkIHRpbWVycyBiZWluZyBjbG9zZWQsIHdoaWNoIHJlc3VsdHMgaW4gc3VjY2Vz
c2l2ZWx5IG1vcmUKdGltZXJzIGJlaW5nIGNyZWF0ZWQgYnV0IG5vdCBmcmVlZC4KClNpZ25lZC1v
ZmYtYnk6IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNvbT4KLS0tCiBzcmMvcGNtL3Bj
bV9ody5jIHwgICAxNyArKysrKysrKystLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL3BjbS9wY21faHcuYyBi
L3NyYy9wY20vcGNtX2h3LmMKaW5kZXggMjA5NWIwMS4uOTQ0NGE2MSAxMDA2NDQKLS0tIGEvc3Jj
L3BjbS9wY21faHcuYworKysgYi9zcmMvcGNtL3BjbV9ody5jCkBAIC0zMzgsOSArMzM4LDE4IEBA
IHN0YXRpYyBpbnQgc25kX3BjbV9od19od19wYXJhbXMoc25kX3BjbV90ICpwY20sIHNuZF9wY21f
aHdfcGFyYW1zX3QgKiBwYXJhbXMpCiAJcmV0dXJuIDA7CiB9CiAKK3N0YXRpYyB2b2lkIHNuZF9w
Y21faHdfY2xvc2VfdGltZXIoc25kX3BjbV9od190ICpodykKK3sKKwlpZiAoaHctPnBlcmlvZF90
aW1lcikgeworCQlzbmRfdGltZXJfY2xvc2UoaHctPnBlcmlvZF90aW1lcik7CisJCWh3LT5wZXJp
b2RfdGltZXIgPSBOVUxMOworCX0KK30KKwogc3RhdGljIGludCBzbmRfcGNtX2h3X2h3X2ZyZWUo
c25kX3BjbV90ICpwY20pCiB7CiAJc25kX3BjbV9od190ICpodyA9IHBjbS0+cHJpdmF0ZV9kYXRh
OworCXNuZF9wY21faHdfY2xvc2VfdGltZXIoaHcpOwogCWludCBmZCA9IGh3LT5mZCwgZXJyOwog
CWlmIChpb2N0bChmZCwgU05EUlZfUENNX0lPQ1RMX0hXX0ZSRUUpIDwgMCkgewogCQllcnIgPSAt
ZXJybm87CkBAIC0zNTAsMTQgKzM1OSw2IEBAIHN0YXRpYyBpbnQgc25kX3BjbV9od19od19mcmVl
KHNuZF9wY21fdCAqcGNtKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMgdm9pZCBzbmRfcGNtX2h3
X2Nsb3NlX3RpbWVyKHNuZF9wY21faHdfdCAqaHcpCi17Ci0JaWYgKGh3LT5wZXJpb2RfdGltZXIp
IHsKLQkJc25kX3RpbWVyX2Nsb3NlKGh3LT5wZXJpb2RfdGltZXIpOwotCQlody0+cGVyaW9kX3Rp
bWVyID0gTlVMTDsKLQl9Ci19Ci0KIHN0YXRpYyBpbnQgc25kX3BjbV9od19jaGFuZ2VfdGltZXIo
c25kX3BjbV90ICpwY20sIGludCBlbmFibGUpCiB7CiAJc25kX3BjbV9od190ICpodyA9IHBjbS0+
cHJpdmF0ZV9kYXRhOwotLSAKMS42LjUKCg==
--001636e0a4ec07c635047b2ecc47
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636e0a4ec07c635047b2ecc47--
