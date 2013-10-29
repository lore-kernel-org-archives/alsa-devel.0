From: Vishal Agrawal <visagrawal@gmail.com>
Subject: [PATCH - alsa-lib] pcm/ioplug: Add mutex in
	snd_pcm_ioplug_hw_ptr_update
Date: Tue, 29 Oct 2013 15:52:16 +0530
Message-ID: <CAKGKwYpB0BHUnPWuBH3H_agG0xF=gFoGk-siw-segP8Zk1NMFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d044283c041592c04e9de971f
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
Cc: alsa-devel@alsa-project.org, Vishal Agrawal <visagrawal@gmail.com>
List-Id: alsa-devel@alsa-project.org

--f46d044283c041592c04e9de971f
Content-Type: text/plain; charset=ISO-8859-1

Function snd_pcm_ioplug_hw_ptr_update can be called from many threads, we
need to protect the hw_ptr. I came across this issue with GStreamer and
Jackd. Function will be called from the thread doing snd_pcm_write and
another would be to get the playback position for the track bar.

Change in itself is very minimum, but it took me a lot of time to debug.

Thanks,
Vishal Agrawal

--f46d044283c041592c04e9de971f
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-pcm-ioplug-Add-mutex-in-snd_pcm_ioplug_hw_ptr_update.patch"
Content-Disposition: attachment;
	filename="0001-pcm-ioplug-Add-mutex-in-snd_pcm_ioplug_hw_ptr_update.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hncz6v2p0

RnJvbSBiODI2YjFmMjhjNTBiZDRhNDE0Y2Y1MDc1MWJlNGFjNzRiNGU0MTc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBWaXNoYWwgQWdyYXdhbCA8dmlzYWdyYXdhbEBnbWFpbC5jb20+
CkRhdGU6IE1vbiwgMjggT2N0IDIwMTMgMTg6MDE6MTQgKzA1MzAKU3ViamVjdDogW1BBVENIIC0g
YWxzYS1saWJdIHBjbS9pb3BsdWc6IEFkZCBtdXRleCBpbgogc25kX3BjbV9pb3BsdWdfaHdfcHRy
X3VwZGF0ZQoKc25kX3BjbV9pb3BsdWdfaHdfcHRyX3VwZGF0ZSgpIGNhbiBiZSBjYWxsZWQgZnJv
bSBkaWZmZXJlbnQKdGhyZWFkcywgaXQgbmVlZHMgdG8gYmUgcHJvdGVjdGVkIGJ5IG11dGV4CgpT
aWduZWQtb2ZmLWJ5OiBWaXNoYWwgQWdyYXdhbCA8dmlzYWdyYXdhbEBnbWFpbC5jb20+CgpkaWZm
IC0tZ2l0IGEvc3JjL3BjbS9wY21faW9wbHVnLmMgYi9zcmMvcGNtL3BjbV9pb3BsdWcuYwppbmRl
eCBhOTBjODQ0Li4yM2RiZWUzIDEwMDY0NAotLS0gYS9zcmMvcGNtL3BjbV9pb3BsdWcuYworKysg
Yi9zcmMvcGNtL3BjbV9pb3BsdWcuYwpAQCAtMjYsNiArMjYsNyBAQAogICoKICAqLwogICAKKyNp
bmNsdWRlIDxwdGhyZWFkLmg+CiAjaW5jbHVkZSAicGNtX2xvY2FsLmgiCiAjaW5jbHVkZSAicGNt
X2lvcGx1Zy5oIgogI2luY2x1ZGUgInBjbV9leHRfcGFybS5oIgpAQCAtNDcsMTIgKzQ4LDE1IEBA
IHR5cGVkZWYgc3RydWN0IHNuZF9wY21faW9wbHVnX3ByaXYgewogCXNuZF9odGltZXN0YW1wX3Qg
dHJpZ2dlcl90c3RhbXA7CiB9IGlvcGx1Z19wcml2X3Q7CiAKK3N0YXRpYyBwdGhyZWFkX211dGV4
X3QgaHdfcHRyX211dGV4ID0gUFRIUkVBRF9NVVRFWF9JTklUSUFMSVpFUjsKKwogLyogdXBkYXRl
IHRoZSBodyBwb2ludGVyICovCiBzdGF0aWMgdm9pZCBzbmRfcGNtX2lvcGx1Z19od19wdHJfdXBk
YXRlKHNuZF9wY21fdCAqcGNtKQogewogCWlvcGx1Z19wcml2X3QgKmlvID0gcGNtLT5wcml2YXRl
X2RhdGE7CiAJc25kX3BjbV9zZnJhbWVzX3QgaHc7CiAKKwlwdGhyZWFkX211dGV4X2xvY2soJmh3
X3B0cl9tdXRleCk7CiAJaHcgPSBpby0+ZGF0YS0+Y2FsbGJhY2stPnBvaW50ZXIoaW8tPmRhdGEp
OwogCWlmIChodyA+PSAwKSB7CiAJCXVuc2lnbmVkIGludCBkZWx0YTsKQEAgLTY0LDYgKzY4LDcg
QEAgc3RhdGljIHZvaWQgc25kX3BjbV9pb3BsdWdfaHdfcHRyX3VwZGF0ZShzbmRfcGNtX3QgKnBj
bSkKIAkJaW8tPmxhc3RfaHcgPSBodzsKIAl9IGVsc2UKIAkJaW8tPmRhdGEtPnN0YXRlID0gU05E
UlZfUENNX1NUQVRFX1hSVU47CisJcHRocmVhZF9tdXRleF91bmxvY2soJmh3X3B0cl9tdXRleCk7
CiB9CiAKIHN0YXRpYyBpbnQgc25kX3BjbV9pb3BsdWdfaW5mbyhzbmRfcGNtX3QgKnBjbSwgc25k
X3BjbV9pbmZvX3QgKmluZm8pCi0tIAoxLjcuOS41Cgo=
--f46d044283c041592c04e9de971f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--f46d044283c041592c04e9de971f--
