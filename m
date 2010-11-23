From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: bug in alsa-lib/snd_pcm_plugin_delay for capture?
Date: Tue, 23 Nov 2010 08:55:07 -0600
Message-ID: <AANLkTikOfbwCpeJprOOsNNSnLzZmv__EujTeTKoM8nPz@mail.gmail.com>
References: <AANLkTi=in6g2YxRKwkCi7H_v0jmJ9tOouc2FK-Rg8iDt@mail.gmail.com>
	<alpine.LNX.2.00.1011180927310.21207@eeebox2.perex-int.cz>
	<AANLkTikihnQxQa-1RednpZSpx5Rn5XEcZYJfcShh6HW7@mail.gmail.com>
	<alpine.LNX.2.00.1011221451250.8433@eeebox2.perex-int.cz>
	<AANLkTimuizeF+p23wrBg9CQFouhRHj2x6g7tD3bQ8g4=@mail.gmail.com>
	<alpine.LNX.2.00.1011231119271.8433@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00221534d663fdbb360495b98e14
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C2EB6103A86
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 15:55:08 +0100 (CET)
Received: by iwn2 with SMTP id 2so9897222iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 06:55:07 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011231119271.8433@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, wim.taymans@collabora.co.uk
List-Id: alsa-devel@alsa-project.org

--00221534d663fdbb360495b98e14
Content-Type: text/plain; charset=ISO-8859-1

> After rethinking, I believe that the right fix should be to add the
> 'snd_pcm_mmap_capture_avail(pcm)' to the sd variable - delay(slave) - for
> the capture direction. You should not bother with avail_update or the slave
> avail values. The avail_update() capture loop just copied samples from the
> producer (slave) to the consumer (pcm). It means that the avail becomes
> lower for the producer (slave) and is increased for the consumer (pcm). The
> delay(slave) already contains the avail(slave) value.
>
> So, the result should be 'delay(slave) + mmap_capture_avail(pcm)'.

The attached patch implements your recoomendation and makes error
messages go away in PulseAudio.
It'd good to know if it improves the perfomance of echo cancellation.
Wim, can you try it out?
Thanks,
-Pierre

--00221534d663fdbb360495b98e14
Content-Type: application/octet-stream;
	name="0001-pcm_plugin-fix-delay.patch"
Content-Disposition: attachment; filename="0001-pcm_plugin-fix-delay.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gguwnstv0

RnJvbSA2Y2IwNThlZDM1MDNmMWM2MWE4N2ZjNzIzNzg3Y2Y5OTJjMmI2NjUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmUtTG91aXMgQm9zc2FydCA8cGllcnJlLWxvdWlzLmJv
c3NhcnRAaW50ZWwuY29tPgpEYXRlOiBUdWUsIDIzIE5vdiAyMDEwIDA4OjQ3OjA4IC0wNjAwClN1
YmplY3Q6IFtQQVRDSF0gcGNtX3BsdWdpbjogZml4IGRlbGF5CgpQdWxzZUF1ZGlvIEFMU0EgbW9k
dWxlcyByZXBvcnQgZXJyb3JzIGFmdGVyIGNhbGxpbmcKc25kX3BjbV9hdmFpbF9kZWxheSgpLCB3
aXRoIGEgZGVsYXkgbG93ZXIgdGhhbiB0aGUgbnVtYmVyIG9mIHNhbXBsZXMKYXZhaWxhYmxlLgoK
Q29ycmVjdCBkZWxheSB1c2luZyBKYXJvc2xhdidzIHJlY29tbWVuZGF0aW9uOgoidGhlIHJlc3Vs
dCBzaG91bGQgYmUgJ2RlbGF5KHNsYXZlKSArIG1tYXBfY2FwdHVyZV9hdmFpbChwY20pIgoKU2ln
bmVkLW9mZi1ieTogUGllcnJlLUxvdWlzIEJvc3NhcnQgPHBpZXJyZS1sb3Vpcy5ib3NzYXJ0QGlu
dGVsLmNvbT4KLS0tCiBzcmMvcGNtL3BjbV9wbHVnaW4uYyB8ICAgIDYgKysrKysrCiAxIGZpbGVz
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9z
cmMvcGNtL3BjbV9wbHVnaW4uYyBiL3NyYy9wY20vcGNtX3BsdWdpbi5jCmluZGV4IDE5ZDBkZWUu
LmQ4OGUxMTcgMTAwNjQ0Ci0tLSBhL3NyYy9wY20vcGNtX3BsdWdpbi5jCisrKyBiL3NyYy9wY20v
cGNtX3BsdWdpbi5jCkBAIC0xNDQsNiArMTQ0LDEyIEBAIHN0YXRpYyBpbnQgc25kX3BjbV9wbHVn
aW5fZGVsYXkoc25kX3BjbV90ICpwY20sIHNuZF9wY21fc2ZyYW1lc190ICpkZWxheXApCiAJaW50
IGVyciA9IHNuZF9wY21fZGVsYXkocGx1Z2luLT5nZW4uc2xhdmUsICZzZCk7CiAJaWYgKGVyciA8
IDApCiAJCXJldHVybiBlcnI7CisgICAgICAgIGlmIChwY20tPnN0cmVhbSA9PSBTTkRfUENNX1NU
UkVBTV9DQVBUVVJFICYmCisJICAgIHBjbS0+YWNjZXNzICE9IFNORF9QQ01fQUNDRVNTX1JXX0lO
VEVSTEVBVkVEICYmCisJICAgIHBjbS0+YWNjZXNzICE9IFNORF9QQ01fQUNDRVNTX1JXX05PTklO
VEVSTEVBVkVEKSB7CisgICAgICAgICAgICAgICAgc2QgKz0gc25kX3BjbV9tbWFwX2NhcHR1cmVf
YXZhaWwocGNtKTsKKyAgICAgICAgfSAgICAgICAgCisKIAkqZGVsYXlwID0gc2Q7CiAJcmV0dXJu
IDA7CiB9Ci0tIAoxLjcuMi4zCgo=
--00221534d663fdbb360495b98e14
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00221534d663fdbb360495b98e14--
