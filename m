From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [RFC] ymfpci - re-enable legacy audio after suspend
	resume
Date: Thu, 8 Mar 2012 12:12:33 +0800
Message-ID: <CAN8ccibfK6Cpho5F5vk8jq_gbZQKp4_C3bMcZ6Ef4c+TU2=EBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6dd989642c4a104bab37c6b
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A8842414E
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 05:12:34 +0100 (CET)
Received: by wiax18 with SMTP id x18so43634wia.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 20:12:33 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

--0016e6dd989642c4a104bab37c6b
Content-Type: text/plain; charset=UTF-8

Since the Legacy Audio Control register is reset to default after
suspend resume cycle

need to enable the Legacy Audio Control Bit in order to use OPL3 FM Synth

however it is still need to use sbiload  instrument loader to reload
the instruments

--0016e6dd989642c4a104bab37c6b
Content-Type: application/octet-stream;
	name="ymfpci_reenable_legacy_audio.patch"
Content-Disposition: attachment;
	filename="ymfpci_reenable_legacy_audio.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS95bWZwY2kveW1mcGNpX21haW4uYyBiL3NvdW5kL3BjaS95
bWZwY2kveW1mcGNpX21haW4uYwppbmRleCAxMmE5YTJiLi44MzkyNmU2IDEwMDY0NAotLS0gYS9z
b3VuZC9wY2kveW1mcGNpL3ltZnBjaV9tYWluLmMKKysrIGIvc291bmQvcGNpL3ltZnBjaS95bWZw
Y2lfbWFpbi5jCkBAIC0yMzU4LDYgKzIzNTgsMTMgQEAgaW50IHNuZF95bWZwY2lfcmVzdW1lKHN0
cnVjdCBwY2lfZGV2ICpwY2kpCiAJCWNoaXAtPmFjdGl2ZV9iYW5rID0gc25kX3ltZnBjaV9yZWFk
bChjaGlwLCBZRFNYR1JfQ1RSTFNFTEVDVCk7CiAJCXNwaW5fdW5sb2NrX2lycSgmY2hpcC0+cmVn
X2xvY2spOwogCX0KKwkKKwlpZiAoY2hpcC0+Zm1fcmVzKSB7CisJCXBjaV9yZWFkX2NvbmZpZ193
b3JkKHBjaSwgUENJUl9EU1hHX0xFR0FDWSwgJmxlZ2FjeV9jdHJsKTsKKwkJbGVnYWN5X2N0cmwg
Jj0gfllNRlBDSV9MRUdBQ1lfTEFEOworCQlwY2lfd3JpdGVfY29uZmlnX3dvcmQocGNpLCBQQ0lS
X0RTWEdfTEVHQUNZLCBsZWdhY3lfY3RybCk7CisJfQorCiAJc25kX3Bvd2VyX2NoYW5nZV9zdGF0
ZShjYXJkLCBTTkRSVl9DVExfUE9XRVJfRDApOwogCXJldHVybiAwOwogfQo=
--0016e6dd989642c4a104bab37c6b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0016e6dd989642c4a104bab37c6b--
