From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] ALSA-LIB - remove Logitech Web Camera from
	blacklist
Date: Tue, 19 Jun 2012 14:29:52 +0800
Message-ID: <CAN8cciaZ_9ng6XtKBk=0At3Oi42kajS8jjab4egyNW+SZATXmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d7eaed04415604c2cd6958
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 46E5B24500
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 08:29:53 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so4527807wgb.20
	for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2012 23:29:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

--0016e6d7eaed04415604c2cd6958
Content-Type: text/plain; charset=UTF-8

 - the commit which add Logitech Web Camera to the
 blacklist  is redundant since Web Camera does not
 has any playback device and Pulseaudio does not
 support digital capture

--0016e6d7eaed04415604c2cd6958
Content-Type: application/octet-stream;
	name="0001-ALSA-LIB-remove-Logitech-Web-Camera-from-blacklist.patch"
Content-Disposition: attachment;
	filename="0001-ALSA-LIB-remove-Logitech-Web-Camera-from-blacklist.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3mlb4eg0

RnJvbSBkMDMxMTE2Yjc1NzJmMWQ0ZDJkZDU1N2E3ZjFhNWQzZTBmZjRjMmFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBUdWUsIDE5IEp1biAyMDEyIDE0OjA3OjMyICswODAwClN1YmplY3Q6IFtQQVRD
SCAxLzFdIEFMU0EtTElCIC0gcmVtb3ZlIExvZ2l0ZWNoIFdlYiBDYW1lcmEgZnJvbSBibGFja2xp
c3QgICAKIC0gdGhlIGNvbW1pdCB3aGljaCBhZGQgTG9naXRlY2ggV2ViIENhbWVyYSB0byB0aGUK
IGJsYWNrbGlzdCBpcyByZWR1bmRhbnQgc2luY2UgV2ViIENhbWVyYSBkb2VzIG5vdAogaGFzIGFu
eSBwbGF5YmFjayBkZXZpY2UgYW5kIFB1bHNlYXVkaW8gZG9lcyBub3QgICAgIAogc3VwcG9ydCBk
aWdpdGFsIGNhcHR1cmUKCgpTaWduZWQtb2ZmLWJ5OiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZv
cnRleDJAZ21haWwuY29tPgoKZGlmZiAtLWdpdCBhL3NyYy9jb25mL2NhcmRzL1VTQi1BdWRpby5j
b25mIGIvc3JjL2NvbmYvY2FyZHMvVVNCLUF1ZGlvLmNvbmYKaW5kZXggMTc3YTdhZi4uYmM2ODA3
ZCAxMDA2NDQKLS0tIGEvc3JjL2NvbmYvY2FyZHMvVVNCLUF1ZGlvLmNvbmYKKysrIGIvc3JjL2Nv
bmYvY2FyZHMvVVNCLUF1ZGlvLmNvbmYKQEAgLTQ3LDcgKzQ3LDYgQEAgVVNCLUF1ZGlvLnBjbS5p
ZWM5NThfZGV2aWNlIHsKIAkiUGxhbnRyb25pY3MgV2lyZWxlc3MgQXVkaW8iIDk5OQogCSJTQiBX
b1cgSGVhZHNldCIgOTk5CiAJIlNlbm5oZWlzZXIgVVNCIGhlYWRzZXQiIDk5OQotCSJVU0IgRGV2
aWNlIDB4NDZkOjB4OTkyIiA5OTkKIH0KIAogCi0tIAoxLjcuOS41Cgo=
--0016e6d7eaed04415604c2cd6958
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0016e6d7eaed04415604c2cd6958--
