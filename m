From: =?UTF-8?Q?Johan_Aires_Rast=C3=A9n?= <johan@oljud.se>
Subject: usb-audio: check_input_term (mixer.c) iterating to
	clock selectors?
Date: Sat, 15 Nov 2014 16:57:05 +0100
Message-ID: <CAMFLXsAzbJ=TSV1rBhVp4fjqmiGwgarrXJb0NWOEM89yVH5VUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com
 [209.85.213.171])
 by alsa0.perex.cz (Postfix) with ESMTP id F2AF72605E4
 for <alsa-devel@alsa-project.org>; Sat, 15 Nov 2014 16:57:06 +0100 (CET)
Received: by mail-ig0-f171.google.com with SMTP id uq10so1267752igb.10
 for <alsa-devel@alsa-project.org>; Sat, 15 Nov 2014 07:57:05 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SGkgZXZlcnlib2R5ISBJJ3ZlIGp1c3Qgc3RhcnRlZCBsb29raW5nIGF0IEFMU0EgYmVjYXVzZSBJ
IHdhbnQgdG8gZ2V0IHRoZQptaWMgd29ya2luZyB3aXRoIG15IEFzdXMgWG9uYXIgVTcuIFNvbWUg
b2YgeW91IG1pZ2h0IGhhdmUgc2VlbiBtZSBvbiBJUkMgYXMKam9oYW5hci4KCkknbSB3b25kZXJp
bmcgYWJvdXQgY2hlY2tfaW5wdXRfdGVybSguLi4pIGluIHNvdW5kL3VzYi9taXhlci5jLCB3aGlj
aCBmb3IKY2FzZSBVQUNfSU5QVVRfVEVSTUlOQUwgYW5kIFVBQ19WRVJTSU9OXzIgd2lsbCByZWN1
cnNpdmVseSBnbyBpbnRvIHRoZQpjbG9jayBzb3VyY2UuIElzIHRoaXMgY29ycmVjdCBiZWhhdmlv
dXI/IEZvciBteSBjYXJkIGJvdGggbWljIGFuZCBsaW5lIHdpbGwKc2hvdyB1cCBhcyAiVW5pdCAy
MiIgd2hlbiBJIGNhbGwgImFtaXhlciBjb250ZW50cyIgc2luY2UgdGhlIHR3byBpbnB1dHMKaGF2
ZSB0aGUgc2FtZSB1bm5hbWVkIGNsb2NrIHNvdXJjZSAodGhleSBhbHNvIHNoYXJlIHBoeXNpY2Fs
IGNvbm5lY3RvcikuCkhvd2V2ZXIsIGlmIEkgY29tbWVudCBvdXQgdGhlIHJlY3Vyc2l2ZSBjYWxs
IHRoZXkgc2hvdyB1cCBhcyAibWljIiBhbmQKImxpbmUiIGFzIHRoZXkncmUgc3VwcG9zZWQgdG8u
CgpCdHcsIGlmIHRoaXMgaXMgY29ycmVjdCwgY291bGRuJ3Qgd2Ugc2V0IGlkID0gZC0+YkNTb3Vy
Y2VJRCBhbmQgYnJlYWs7IGluCnRoZSBzYW1lIHdheSB0aGF0IGNhc2UgVUFDX0ZFQVRVUkVfVU5J
VCBkb2VzPwoKLy9Kb2hhbiBSYXN0w6luCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGlu
Zm8vYWxzYS1kZXZlbAo=
