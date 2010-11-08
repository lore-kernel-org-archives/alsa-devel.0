From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH] ALSA: add support for disabling period irq
Date: Mon, 8 Nov 2010 14:52:38 -0600
Message-ID: <AANLkTimCOOpV7fe1sbaWqY3ZpWQ3eZOkOi6pxyJVFo55@mail.gmail.com>
References: <1288649573-31545-1-git-send-email-pierre-louis.bossart@intel.com>
	<s5h8w1c18no.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020850550.29422@eeebox2.perex-int.cz>
	<s5h4oc016eq.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020923430.29422@eeebox2.perex-int.cz>
	<s5h1v7415ih.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020957590.29422@eeebox2.perex-int.cz>
	<s5hy69cytmn.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011021020550.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0023547c913df69bf9049490cdda
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F8C8243DF
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 21:52:41 +0100 (CET)
Received: by gwaa20 with SMTP id a20so4313854gwa.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Nov 2010 12:52:38 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011021020550.29422@eeebox2.perex-int.cz>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

--0023547c913df69bf9049490cdda
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

>>>>>> I feel that some bottom-line check is needed if we keep the linear
>>>>>> position over the buffer size even without the period irq.
>>>>>> If the app doesn't care, OK fine, the driver shouldn't care, too.
>>>>>> But then it doesn't make sense to keep the linear position, either.
>>>>>
>>>>> But if we can keep the linear position using the light-weight jiffies
>>>>> check, it's probably OK to keep it rather than changing the hw_ptr
>>>>> behaviour.
>>>>
>>>> Well, but the point of the patch is to avoid wakeups as much as
>>>> possible. =A0The jiffies-check adds an unconditional wakeup for each
>>>> buffer size, thus it's against the purpose of the patch.
>>>
>>> I don't see any wakeup.
>>
>> The CPU is woken up. =A0This is to be avoided.
>
> Nope. No timers are used. The jiffies check and hw_ptr correction should =
be
> done from the avail_update call invoked from an application.

ok, so I re-implemented all the points found in the reviews except for
this thread. There's already some code to see if we go beyond the
buffer boundaries, so I am not sure what the 'linear position' means.
Do I need to implement anything specific to check the validity of the
hw_ptr values? I am not clear if I need to do anything beyond the fix
attached, and I don't honestly understand all these checks with
jiffies.
Thanks.
-Pierre

--0023547c913df69bf9049490cdda
Content-Type: application/octet-stream; name="pcm_lib.patch"
Content-Disposition: attachment; filename="pcm_lib.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gg9ttkqi0

ZGlmZiAtLWdpdCBhL2NvcmUvcGNtX2xpYi5jIGIvY29yZS9wY21fbGliLmMKaW5kZXggYTE3MDdj
Yy4uMWNjZWE0YyAxMDA2NDQKLS0tIGEvY29yZS9wY21fbGliLmMKKysrIGIvY29yZS9wY21fbGli
LmMKQEAgLTM3Myw2ICszNzMsMTAgQEAgc3RhdGljIGludCBzbmRfcGNtX3VwZGF0ZV9od19wdHIw
KHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLAogCQkJICAgKHVuc2lnbmVkIGxv
bmcpbmV3X2h3X3B0ciwKIAkJCSAgICh1bnNpZ25lZCBsb25nKXJ1bnRpbWUtPmh3X3B0cl9iYXNl
KTsKIAl9CisKKyAgICAgICAgaWYgKHJ1bnRpbWUtPm5vX3BlcmlvZF93YWtldXApCisgICAgICAg
ICAgICAgICAgZ290byBub19qaWZmaWVzX2NoZWNrX2lmX25vX3BlcmlvZF93YWtldXA7CisKIAkv
KiBzb21ldGhpbmcgbXVzdCBiZSByZWFsbHkgd3JvbmcgKi8KIAlpZiAoZGVsdGEgPj0gcnVudGlt
ZS0+YnVmZmVyX3NpemUgKyBydW50aW1lLT5wZXJpb2Rfc2l6ZSkgewogCQlod19wdHJfZXJyb3Io
c3Vic3RyZWFtLApAQCAtNDQyLDYgKzQ0Niw3IEBAIHN0YXRpYyBpbnQgc25kX3BjbV91cGRhdGVf
aHdfcHRyMChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwKIAkJCSAgICAgKGxv
bmcpb2xkX2h3X3B0cik7CiAJfQogCisgbm9famlmZmllc19jaGVja19pZl9ub19wZXJpb2Rfd2Fr
ZXVwOgogCWlmIChydW50aW1lLT5zdGF0dXMtPmh3X3B0ciA9PSBuZXdfaHdfcHRyKQogCQlyZXR1
cm4gMDsKIAo=
--0023547c913df69bf9049490cdda
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0023547c913df69bf9049490cdda--
