From: Chris Coleman <chris.coleman83@gmail.com>
Subject: Re: [PATCH] pyalsa: fix integer overflow in alsaseq.c
Date: Thu, 20 Aug 2009 20:13:45 +0100
Message-ID: <2dca5a2a0908201213o20a4d695g9852624659f778cf@mail.gmail.com>
References: <2dca5a2a0908181436t3147cc2ax82a23e93fe27e8f1@mail.gmail.com>
	<2dca5a2a0908181437m7e9e8968x93e7601c5d0a949b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c10d0f43d770471978c7f
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 446F51037F9
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 21:13:46 +0200 (CEST)
Received: by ewy20 with SMTP id 20so146624ewy.46
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2009 12:13:45 -0700 (PDT)
In-Reply-To: <2dca5a2a0908181437m7e9e8968x93e7601c5d0a949b@mail.gmail.com>
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

--0015174c10d0f43d770471978c7f
Content-Type: text/plain; charset=ISO-8859-1

I just noticed that `PyString_FromFormat` in Python 2.6 doesn't handle
`%lx` in format strings, so my patch breaks `repr(Constant)`.

In addition to that, it was not necessary to change the signedness of `value`.

With those two things in mind, the patch perhaps ought to look like
this (see attached).

Signed-off-by: Chris Coleman <chris.coleman83 at gmail.com>

2009/8/18 Chris Coleman <chris.coleman83@gmail.com>:
> Sorry, here's the patch.
>
> Signed-off-by: Chris Coleman <chris.coleman83 at gmail.com>
>
> 2009/8/18 Chris Coleman <chris.coleman83@gmail.com>:
>> Hello alsa-devel,
>>
>> I've been using the alsaseq python module and I found a bug. Sometimes
>> the SEQ_* constants have extremely large and incorrect values. For
>> example, 25769803811 instead of 35. The lower 32-bits are always
>> correct.
>>
>> Obviously, I'm running a 64-bit operating system.
>>
>> The problem is that the `value` member of the `ConstantObject`
>> structure is an `unsigned int` whereas it should be a `long`. I've
>> attached a patch. It's against the latest released version, 1.0.20.
>>
>> Regards,
>> Chris Coleman
>>
>> Signed-off-by: Chris Coleman <chris.coleman83 at gmail.com>
>>
>

--0015174c10d0f43d770471978c7f
Content-Type: text/x-patch; charset=US-ASCII; name="pyalsa-1.0.20-alsaseq.patch"
Content-Disposition: attachment; filename="pyalsa-1.0.20-alsaseq.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fylvdyzw1

LS0tIHB5YWxzYS0xLjAuMjAub3JpZy9weWFsc2EvYWxzYXNlcS5jCTIwMDktMDUtMDYgMDg6MDc6
MjguMDAwMDAwMDAwICswMTAwCisrKyBweWFsc2EtMS4wLjIwL3B5YWxzYS9hbHNhc2VxLmMJMjAw
OS0wOC0yMCAxOTo0OTowNC4wMDQ2NDgyNjUgKzAxMDAKQEAgLTQzOSw3ICs0MzksNyBAQCB0eXBl
ZGVmIHN0cnVjdCB7CiAgIDsKIAogICAvKiB2YWx1ZSBvZiBjb25zdGFudCAqLwotICB1bnNpZ25l
ZCBpbnQgdmFsdWU7CisgIHVuc2lnbmVkIGxvbmcgaW50IHZhbHVlOwogICAvKiBuYW1lIG9mIGNv
bnN0YW50ICovCiAgIGNvbnN0IGNoYXIgKm5hbWU7CiAgIC8qIHR5cGUgb2YgY29uc3RhbnQgKi8K
QEAgLTQ3MCw3ICs0NzAsNyBAQCBzdGF0aWMgUHlPYmplY3QgKgogQ29uc3RhbnRfcmVwcihDb25z
dGFudE9iamVjdCAqc2VsZikgewogICByZXR1cm4gUHlTdHJpbmdfRnJvbUZvcm1hdCgiJXMoMHgl
eCkiLAogCQkJICAgICBzZWxmLT5uYW1lLAotCQkJICAgICBzZWxmLT52YWx1ZSk7CisJCQkgICAg
ICh1bnNpZ25lZCBpbnQpc2VsZi0+dmFsdWUpOwogfQogCiAvKiogYWxzYXNlcS5Db25zdGFudCB0
cF9zdHIgKi8K
--0015174c10d0f43d770471978c7f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0015174c10d0f43d770471978c7f--
