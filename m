From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] pulseaudio - Add pa_alsa_dump when
	alsa-sink/alsa-source undderrun
Date: Fri, 6 May 2011 15:59:00 +0800
Message-ID: <BANLkTi=1Rc_GZntkDN32U5njr4S8BtMVxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001517448abada487704a296dc29
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 980FD103849
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 09:59:04 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2362884fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 06 May 2011 00:59:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Colin Guthrie <gmane@colin.guthr.ie>
List-Id: alsa-devel@alsa-project.org

--001517448abada487704a296dc29
Content-Type: text/plain; charset=ISO-8859-1

Add pa_alsa_dump when alsa-sink/alsa-source undderrun

--001517448abada487704a296dc29
Content-Type: application/octet-stream;
	name="0001-Add-pa_alsa_dump-when-alsa-sink-alsa-source-undderrun.patch"
Content-Disposition: attachment;
	filename="0001-Add-pa_alsa_dump-when-alsa-sink-alsa-source-undderrun.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnctzyzd0

RnJvbSAwNmRlYTUxYTk2NzYyYzRhYzJhOWIxYTU5ZmMxNTEwM2UyNjljN2Q0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBGcmksIDYgTWF5IDIwMTEgMTM6MjM6MDYgKzA4MDAKU3ViamVjdDogW1BBVENI
IHB1bHNlYXVkaW8gYWxzYSAxLzFdIEFkZCBwYV9hbHNhX2R1bXAgd2hlbiBhbHNhLXNpbmsvYWxz
YS1zb3VyY2UgdW5kZGVycnVuCgoKU2lnbmVkLW9mZi1ieTogUmF5bW9uZCBZYXUgPHN1cGVycXVh
ZC52b3J0ZXgyQGdtYWlsLmNvbT4KCmRpZmYgLS1naXQgYS9zcmMvbW9kdWxlcy9hbHNhL2Fsc2Et
c2luay5jIGIvc3JjL21vZHVsZXMvYWxzYS9hbHNhLXNpbmsuYwppbmRleCBjY2JjMDYyLi5mNmY2
MjVmIDEwMDY0NAotLS0gYS9zcmMvbW9kdWxlcy9hbHNhL2Fsc2Etc2luay5jCisrKyBiL3NyYy9t
b2R1bGVzL2Fsc2EvYWxzYS1zaW5rLmMKQEAgLTQzNCw3ICs0MzQsNyBAQCBzdGF0aWMgc2l6ZV90
IGNoZWNrX2xlZnRfdG9fcGxheShzdHJ1Y3QgdXNlcmRhdGEgKnUsIHNpemVfdCBuX2J5dGVzLCBw
YV9ib29sX3QgbwogICAgICAgICAvKiBXZSBnb3QgYSBkcm9wb3V0LiBXaGF0IGEgbWVzcyEgKi8K
ICAgICAgICAgbGVmdF90b19wbGF5ID0gMDsKICAgICAgICAgdW5kZXJydW4gPSBUUlVFOwotCisJ
cGFfYWxzYV9kdW1wKFBBX0xPR19FUlJPUiwgdS0+cGNtX2hhbmRsZSk7CiAjaWZkZWYgREVCVUdf
VElNSU5HCiAgICAgICAgIFBBX0RFQlVHX1RSQVA7CiAjZW5kaWYKZGlmZiAtLWdpdCBhL3NyYy9t
b2R1bGVzL2Fsc2EvYWxzYS1zb3VyY2UuYyBiL3NyYy9tb2R1bGVzL2Fsc2EvYWxzYS1zb3VyY2Uu
YwppbmRleCAzMzU1ZmJkLi5hMmNmMDYyIDEwMDY0NAotLS0gYS9zcmMvbW9kdWxlcy9hbHNhL2Fs
c2Etc291cmNlLmMKKysrIGIvc3JjL21vZHVsZXMvYWxzYS9hbHNhLXNvdXJjZS5jCkBAIC00MjMs
NyArNDIzLDcgQEAgc3RhdGljIHNpemVfdCBjaGVja19sZWZ0X3RvX3JlY29yZChzdHJ1Y3QgdXNl
cmRhdGEgKnUsIHNpemVfdCBuX2J5dGVzLCBwYV9ib29sX3QKICAgICAgICAgLyogV2UgZ290IGEg
ZHJvcG91dC4gV2hhdCBhIG1lc3MhICovCiAgICAgICAgIGxlZnRfdG9fcmVjb3JkID0gMDsKICAg
ICAgICAgb3ZlcnJ1biA9IFRSVUU7Ci0KKwlwYV9hbHNhX2R1bXAoUEFfTE9HX0VSUk9SLCB1LT5w
Y21faGFuZGxlKTsKICNpZmRlZiBERUJVR19USU1JTkcKICAgICAgICAgUEFfREVCVUdfVFJBUDsK
ICNlbmRpZgotLSAKMS42LjAuNgoK
--001517448abada487704a296dc29
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001517448abada487704a296dc29--
