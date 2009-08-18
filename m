From: Chris Coleman <chris.coleman83@gmail.com>
Subject: Re: [PATCH] pyalsa: fix integer overflow in alsaseq.c
Date: Tue, 18 Aug 2009 22:37:58 +0100
Message-ID: <2dca5a2a0908181437m7e9e8968x93e7601c5d0a949b@mail.gmail.com>
References: <2dca5a2a0908181436t3147cc2ax82a23e93fe27e8f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c0ca0093b9d0471715538
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id B5B0C1037FE
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 23:38:00 +0200 (CEST)
Received: by ewy20 with SMTP id 20so3929098ewy.46
	for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2009 14:37:58 -0700 (PDT)
In-Reply-To: <2dca5a2a0908181436t3147cc2ax82a23e93fe27e8f1@mail.gmail.com>
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

--0015174c0ca0093b9d0471715538
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Sorry, here's the patch.

Signed-off-by: Chris Coleman <chris.coleman83 at gmail.com>

2009/8/18 Chris Coleman <chris.coleman83@gmail.com>:
> Hello alsa-devel,
>
> I've been using the alsaseq python module and I found a bug. Sometimes
> the SEQ_* constants have extremely large and incorrect values. For
> example, 25769803811 instead of 35. The lower 32-bits are always
> correct.
>
> Obviously, I'm running a 64-bit operating system.
>
> The problem is that the `value` member of the `ConstantObject`
> structure is an `unsigned int` whereas it should be a `long`. I've
> attached a patch. It's against the latest released version, 1.0.20.
>
> Regards,
> Chris Coleman
>
> Signed-off-by: Chris Coleman <chris.coleman83 at gmail.com>
>

--0015174c0ca0093b9d0471715538
Content-Type: text/x-patch; charset=US-ASCII; name="pyalsa-1.0.20-alsaseq.patch"
Content-Disposition: attachment; filename="pyalsa-1.0.20-alsaseq.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fyj5or0m0

LS0tIHB5YWxzYS0xLjAuMjAub3JpZy9weWFsc2EvYWxzYXNlcS5jCTIwMDktMDUtMDYgMDg6MDc6
MjguMDAwMDAwMDAwICswMTAwCisrKyBweWFsc2EtMS4wLjIwL3B5YWxzYS9hbHNhc2VxLmMJMjAw
OS0wOC0xOCAwNzowODoyMS41MDQ2MjgxNjggKzAxMDAKQEAgLTQzOSw3ICs0MzksNyBAQCB0eXBl
ZGVmIHN0cnVjdCB7CiAgIDsKIAogICAvKiB2YWx1ZSBvZiBjb25zdGFudCAqLwotICB1bnNpZ25l
ZCBpbnQgdmFsdWU7CisgIGxvbmcgdmFsdWU7CiAgIC8qIG5hbWUgb2YgY29uc3RhbnQgKi8KICAg
Y29uc3QgY2hhciAqbmFtZTsKICAgLyogdHlwZSBvZiBjb25zdGFudCAqLwpAQCAtNDY4LDcgKzQ2
OCw3IEBAIENvbnN0YW50X2NyZWF0ZShjb25zdCBjaGFyICpuYW1lLCBsb25nIHYKIC8qKiBhbHNh
c2VxLkNvbnN0YW50IHRwX3JlcHIgKi8KIHN0YXRpYyBQeU9iamVjdCAqCiBDb25zdGFudF9yZXBy
KENvbnN0YW50T2JqZWN0ICpzZWxmKSB7Ci0gIHJldHVybiBQeVN0cmluZ19Gcm9tRm9ybWF0KCIl
cygweCV4KSIsCisgIHJldHVybiBQeVN0cmluZ19Gcm9tRm9ybWF0KCIlcygweCVseCkiLAogCQkJ
ICAgICBzZWxmLT5uYW1lLAogCQkJICAgICBzZWxmLT52YWx1ZSk7CiB9Cg==
--0015174c0ca0093b9d0471715538
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0015174c0ca0093b9d0471715538--
