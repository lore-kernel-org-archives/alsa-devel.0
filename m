From: "Ivan N. Zlatev" <contact@i-nz.net>
Subject: Apple iMac pin configs
Date: Fri, 27 Apr 2007 21:07:32 +0100
Message-ID: <3db1ec7f0704271307y74caf74bk8ce98e4b245e567f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_125395_4108095.1177704452416"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.180])
	by alsa0.perex.cz (Postfix) with ESMTP id AB46124385
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2007 22:07:33 +0200 (CEST)
Received: by ik-out-1112.google.com with SMTP id c28so1015670ika
	for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2007 13:07:32 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_125395_4108095.1177704452416
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have a 20'' iMac machine with a hda-intel (SigmaTel 9221 A1 codec)
and I have successfully been using the mac mini pin config, but there
is one problem - the microphone doesn't work. The machine has a
built-in microphone, built-in speakers, 1 digitial out jack and 1 for
headphones. With the mac mini pin config I get 2 mics: "Front Mic" and
"Mic" but none of those works. (alsamixer-macmini.gz for info).

Today I spent some time on the search for the the correct pin
configuration and it should be this [1] according to the windows
drivers. This configuration causes amixer.gz, basically 1 "Mic" (which
again doesn't record), but also "Mic as Output" and "Line in as
output" (I don't have a line in as far as i know). I have also tried
the macbook-pro and macbook introduced with 1.0.14rc3, but the mic
doesn't work.

I have attached
  * cat /proc/asound/card0/codec#0
  * Mac OS X's complete dump of information of the audio driver -
imac20-ioreg-audio.gz
  * amixer with the below config and the one with the macmini pin config

Can you possible assist me to get the below pin config in tune, so
that everything works?

Regards.

[1] ==========

[HKR\Settings\pin]
[HKR\Settings\Pin\0A]
CfgDflt = dword: 0x0121E230
Action = hex: 01,0A,81,0C,81,10
[HKR\Settings\Pin\0B]
CfgDflt = dword: 0x90A70120
[HKR\Settings\Pin\0C]
CfgDflt = dword: 0x9017E110
[HKR\Settings\Pin\0D]
CfgDflt = dword: 0x400000FE
[HKR\Settings\Pin\0E]
CfgDflt = dword: 0x400000FD
Action = hex: 01,10,81,0A,81,0C
[HKR\Settings\Pin\0F]
CfgDflt = dword: 0x0181E02E
Action = hex: 09,0F
[HKR\Settings\Pin\10]
CfgDflt = dword: 0x1145E240
[HKR\Settings\Pin\11]
CfgDflt = dword: 0x500000FA
[HKR\Settings\Pin\15]
CfgDflt = dword: 0x400000FC
[HKR\Settings\Pin\1B]
CfgDflt = dword: 0x400000FB

-- 
Ivan N. Zlatev

Web: http://www.i-nZ.net
"It's all some kind of whacked out conspiracy."

------=_Part_125395_4108095.1177704452416
Content-Type: application/x-gzip; name=imac20-ioreg-audio.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1125g3g
Content-Disposition: attachment; filename="imac20-ioreg-audio.gz"

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
------=_Part_125395_4108095.1177704452416
Content-Type: application/x-gzip; name=amixer.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1129rg5
Content-Disposition: attachment; filename="amixer.gz"

H4sICFBUMkYAA2FtaXhlcgDlVU1vgkAQvfdXzKXhUpuFSP04lmhiAqkpR+IBca3bwi6B3db++w4K
aMwCmpjWpKeF2TfMe29nFp8laUwhYVuaQSS4zEQMhhfmkmbGA7kDcMI0XLKYSUbzMaSfIlYJhTT/
YjLa4P48Dr+XYfQB0SbknMYImmb4IXDpWkKvfHllbxuJaJclTCKkziIIMa0BbnmCizGuh+wjGEIg
MAm5X0BAHglZPeOD4IsavytwToKvVTx3vBa515Fp2XaXTIScsm5UqMPqxe3y/9Np+irLhOKrm9Js
PkEwMgsFveGjZXdrbkrQa3Yo75rZ/dp7F4zTVWVAtZZhvR+FsjO0H5O3a/Kj7gNzp5PbYd5H5qRk
Puiy3cXSMOMQ5vCiZKr0c3Y54RNWgVivmyh4LPrL8rOJM7KHv18Xa0mVUV3hqOybqJ7xEnzZiFdJ
u17pnwx2tVm0S3kzWWbLXdaJb3CX46GCL1QWaaVSrhIMziRN8K3oBWPflEYZJWW0qXnUtsXBazjX
ZNzBh37Dr64F+QMzFSSruAgAAA==
------=_Part_125395_4108095.1177704452416
Content-Type: application/x-gzip; name=codec-info.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1129rv0
Content-Disposition: attachment; filename="codec-info.gz"

H4sICFZUMkYAA2NvZGVjLWluZm8AzZdfj9o4EMDf+RTzXG3VceL8AWkfKLQ97m53Udm2D4iHkJhV
1OCgELr0Pv2NDZgEYqConG61Cokdz8xvZjye9PJExB0YpS/z6FlkMHru9tqOw6DLWt0kKcRy2QFs
fRUyyQsYJPSwDt2QB36IrdFquvy5LMV8O8HQn7IAsfVZ/EiXaS7NuMuRtfpiFq2yEoa9h04L6K+I
SrGEMa4DgZMOcM4QgYdI1zB06Nr21T0LfK5+2jSEeuE0LfU6QauYDw6Cw/XELC/m0WaO0RxpMlq7
88XbgYQ4WhBRPlve4xrxDiTZv9AP4g70ffqPUI/eHcxXpbhnNQlPq7ImIphVRKiHqgjHiHgkN4Ma
gXF3laQ5kJzFqpzAqxJGMwnG6FEcSlGIfKeJkOo6H991K2M/oozGtP/aoC4Tmhzmr6JQTkej1L2R
Uk8p9SxK+W2UzhxQF4tS70ZKuVLKLUr9ndKBrOlkCXqc7ZTW1wL0cilFXNImoRTWuauWBEZq8Bul
hkZqaHMQR4cZqdBPX9IyypT0/2Svepu9Ct2ea0xt2xzA0b3QVOYfmqqNvMosm2/3ezuC8TCV9Np8
kYl11bXIwlrEUklTOhwscGcdGDzC05dn+GMIfVGSis07sKs7qm44hM3o1fGfUfx9ol5VKRqV8GFd
wscil6W2SNkI98DehXd0n1HJvodPhRByI/JtXKqcxnWMna1KGxg6Bmx6HVhgwGxUDBn9O4bq71SK
KtdnERVWrPcZrTnAclDptCJxgxTfDClkLjq8jkTHzmVEK/FrQPvdktww+ShGlHx4XZiasg+xc0Ha
CTsS2pCU5wnIShKxNhU6Q/KQxhdBkBhLqu2MnV3h/8t2iI+MXef6pyKSL4cZdcr33g6HoR3Hxcbi
W0mrTW1pgOGeQ7vDwIyG/cHHUzRPizKNo6yWTD8PeLjRVmVyDVP4Rp+r6tI2eMyG56IfnsXDbZZ9
6A77tsipJKXoKVjqKo4Dt2k1DOkX+V3mr3JPuh1oDN5xD8JMXzkSGZmTF3smV9mRnO19mjpiXmtn
nWDbzmJjk4Rcl9jJQSQCEwltqPdms1v0saILsS5e6vg0MO7/AAa1t38DDPXB74VYwCchBTUmFNxv
afIiKg1NoFKFvsEecnmWyK0SuTUido5oYmzyTlRWtFXW3Ul02JlQSXUdbCqpp9uSszWVurLx1zxb
zQX8JfPpkd9UK6c2mPKbWROczJ02urXcGcitr8yH4f4TgIYq3tucSIf5sG8DzbHFwttYEKqMDI8y
cm+B6QUYdc7b73WKE9Wd5Mh1M+pRGsr4TkBk+0o4vexEn3j1oXHLOtrsx6j1LySEiakUEQAA
------=_Part_125395_4108095.1177704452416
Content-Type: application/x-gzip; name=amixer-macmini.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f112ifyl
Content-Disposition: attachment; filename="amixer-macmini.gz"

H4sICNJVMkYAA2FtaXhlci1tYWNtaW5pANVVTW+CMBi+71e8l4XLJC2DoR5HNDGRzIwj2QGhzm7Q
Emw39+9XPvyIoaCJWdyp0Pd52+ejlIBmeUogo1tSQMyZKHgKxsLzjQd0B+BFebSkKRWUbMaQf/FU
ZkTNL9LoZxnFnxCvI8ZIqorTQnXDnKwEDJqXV/q+Fgo9pxkVCrLvQgpiOY4q+ZzxsRoP3UcwPHyE
0LXu3yAcYNu0UfL8tsdWi/eBg1Z51QIdAiHffFMRr68jFFtur1ALQzhyKu626ZTUIeSsQ6yuoV1w
IIuCS5bclGZsKwmokjAyXaeWsFp1iNZ2tKv2CBOk6NRcj4MPThlJdhbsxma63ZFS2xnqj9k/Kfa4
Yj80rV728+nkv1IPaEJu66i5in99NbhnfV66Bk1UymuYMYg28CJFLtvvlssTOomhy/LZxBs5w7/f
V+0lZNGadtykHe/TbsCXhb1rqrK2TyLeFcubAaPqarCwibQJ9+I17jIVKgRcFnGrVMJkpiZngmTq
zfBpbDR/GaifyxNiNAg0Pq5pdvTltsPTa3ips/LgjI1qZ3QmtiB/AeTGvahPCAAA
------=_Part_125395_4108095.1177704452416
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_125395_4108095.1177704452416--
