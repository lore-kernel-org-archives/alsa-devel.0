From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: [PATCH] Fix regression in emu1010 firmware loading
Date: Thu, 21 Feb 2013 21:06:14 +0000
Message-ID: <CAD-m0i87HKAb-2DM1tWBtCTneUh9eUm2J71z3FimfD4Gwyeyiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502c72ef8c2df04d6427110
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f171.google.com (mail-qc0-f171.google.com
 [209.85.216.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EE5F26525B
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 22:06:16 +0100 (CET)
Received: by mail-qc0-f171.google.com with SMTP id d1so431166qca.16
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2013 13:06:13 -0800 (PST)
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

--00504502c72ef8c2df04d6427110
Content-Type: text/plain; charset=ISO-8859-1

This patch fix regression in emu1010 firmware loading after
http://git.alsa-project.org/?p=alsa-kprivate.git;a=commitdiff;h=b209c4dfcd960ab176d4746ab7dc442a3edb4575

I just revert small part of this commit. Tested on emu1212m pci.

--00504502c72ef8c2df04d6427110
Content-Type: application/octet-stream;
	name="kernel-fix_emu_firmware_load.patch"
Content-Disposition: attachment;
	filename="kernel-fix_emu_firmware_load.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

LS0tIGxpbnV4LTMuOC9zb3VuZC9wY2kvZW11MTBrMS9lbXUxMGsxX21haW4uYworKysgbGludXgt
My44LTEvc291bmQvcGNpL2VtdTEwazEvZW11MTBrMV9tYWluLmMKQEAgLTg2MCw2ICs4NjAsMTEg
QEAKIAkJfQogCQlzbmRfcHJpbnRrKEtFUk5fSU5GTyAiZW11MTAxMDogZmlybXdhcmUgZmlsZSA9
ICVzLCBzaXplID0gMHglenhcbiIsCiAJCQkgICBmaWxlbmFtZSwgZW11LT5maXJtd2FyZS0+c2l6
ZSk7CisJCWVyciA9IHNuZF9lbXUxMDEwX2xvYWRfZmlybXdhcmUoZW11KTsKKwkJaWYgKGVyciAh
PSAwKSB7CisJCQlzbmRfcHJpbnRrKEtFUk5fSU5GTyAiZW11MTAxMDogTG9hZGluZyBGaXJtd2Fy
ZSBmaWxlICVzIGZhaWxlZFxuIiwgZmlsZW5hbWUpOworCQkJcmV0dXJuIGVycjsKKwkJfQogCX0K
IAogCS8qIElELCBzaG91bGQgcmVhZCAmIDB4N2YgPSAweDU1IHdoZW4gRlBHQSBwcm9ncmFtbWVk
LiAqLwo=
--00504502c72ef8c2df04d6427110
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--00504502c72ef8c2df04d6427110--
