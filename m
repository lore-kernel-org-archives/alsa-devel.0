From: Martin Tarenskeen <m.tarenskeen@zonnet.nl>
Subject: amidi.c.patch review request
Date: Sun, 20 Mar 2016 17:15:35 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603201658110.27665@mylaptop>
Reply-To: m.tarenskeen@zonnet.nl
Mime-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="-1463810558-47762958-1458490539=:28736"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpsmtpb-ews02.kpnxchange.com (cpsmtpb-ews02.kpnxchange.com
 [213.75.39.5]) by alsa0.perex.cz (Postfix) with ESMTP id 01815261299
 for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2016 17:15:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel mailinglist <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810558-47762958-1458490539=:28736
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hi,

I improved my own patch to amidi.c

As a result I can now succesfully fetch a SysEx dump from my Yamaha Reface 
DX, and it exits succesfully after the timeout that I specify using the 
-t option.

Problem: My synth sends continuously not only 0xFE (Active Sensing) but 
also 0xF8 (Timing Clock). 24 times per quarter note to be exactly. With a 
fast tempo like 250 BPM this gives a 0xF8 byte every 10 ms. Until now when 
I tried to fetch a SysEx dump from my synth using amidi the data were 
polluted with lots of 0xF8 bytes and the -t option would not work. A bug I 
would say.

The attached patch seems to solve this issue, but please comment and 
improve where needed. Please try with other synths also.

Can someone submit my patch to the official sources? I don't know how to.
See attached.

-- 

Martin
---1463810558-47762958-1458490539=:28736
Content-Type: text/plain; charset=US-ASCII; name=amidi.c.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.LFD.2.20.1603201715350.28736@mylaptop>
Content-Description: 
Content-Disposition: attachment; filename=amidi.c.patch

LS0tIGFtaWRpLmMub3JpZwkyMDE1LTExLTIwIDIzOjEwOjIxLjIzMDUwMjU0
NyArMDEwMA0KKysrIGFtaWRpLmMJMjAxNi0wMy0yMCAxNjo1Mjo1NS4zNjYw
NjY0NzYgKzAxMDANCkBAIC01NTksNyArNTU5LDcgQEANCiAJCQlpbnQgaSwg
bGVuZ3RoOw0KIAkJCXVuc2lnbmVkIHNob3J0IHJldmVudHM7DQogDQotCQkJ
ZXJyID0gcG9sbChwZmRzLCBucGZkcywgMjAwKTsNCisJCQllcnIgPSBwb2xs
KHBmZHMsIG5wZmRzLCA1KTsNCiAJCQlpZiAoc3RvcCB8fCAoZXJyIDwgMCAm
JiBlcnJubyA9PSBFSU5UUikpDQogCQkJCWJyZWFrOw0KIAkJCWlmIChlcnIg
PCAwKSB7DQpAQCAtNTY3LDcgKzU2Nyw3IEBADQogCQkJCWJyZWFrOw0KIAkJ
CX0NCiAJCQlpZiAoZXJyID09IDApIHsNCi0JCQkJdGltZSArPSAyMDA7DQor
CQkJCXRpbWUgKz0gNTsNCiAJCQkJaWYgKHRpbWVvdXQgJiYgdGltZSA+PSB0
aW1lb3V0KQ0KIAkJCQkJYnJlYWs7DQogCQkJCWNvbnRpbnVlOw0KQEAgLTU4
OSw3ICs1ODksNyBAQA0KIAkJCX0NCiAJCQlsZW5ndGggPSAwOw0KIAkJCWZv
ciAoaSA9IDA7IGkgPCBlcnI7ICsraSkNCi0JCQkJaWYgKCFpZ25vcmVfYWN0
aXZlX3NlbnNpbmcgfHwgYnVmW2ldICE9IDB4ZmUpDQorCQkJCWlmICghaWdu
b3JlX2FjdGl2ZV9zZW5zaW5nIHx8IGJ1ZltpXSA8IDB4ZjgpDQogCQkJCQli
dWZbbGVuZ3RoKytdID0gYnVmW2ldOw0KIAkJCWlmIChsZW5ndGggPT0gMCkN
CiAJCQkJY29udGludWU7DQo=

---1463810558-47762958-1458490539=:28736
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


---1463810558-47762958-1458490539=:28736--
