From: Paulo Cavalcanti <promac@gmail.com>
Subject: idt blue jack patch
Date: Mon, 16 Feb 2009 06:13:35 -0300
Message-ID: <68720af30902160113t5c0f206di4c63ecf801ce74ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00151748dcc6f7bb7b04630599e7
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 02DC32442A
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 10:13:36 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so1154950ywa.2
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 01:13:36 -0800 (PST)
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

--00151748dcc6f7bb7b04630599e7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I received a patch form Fengguang that
made my Intel DG45ID (snd-hda-intel, codec IDT 92HD73E1X5)
behave the way it should, in my opinion.

It just makes the blue jack behave as an input source by default (in alsa
1.0.19 it is
an output jack).

It is widespread that the green jack is output, the blue input and the pink
is mic.
Some cards allow reconfiguring the jacks in alsamixer, but the DG45ID
already has
an orange and black jacks for rear and center speakers, and a digital
output.

Other people have also raised this problem some time ago:

https://fcp.surfsite.org/modules/newbb/viewtopic.php?viewmode=threaded&order=ASC&topic_id=62855&forum=12&move=prev&topic_time=1224179600

Fengguang suggested me to direct my request to the development list,
so the other developers could decide what to do.

I would like to add that I can use the input source and the mic just fine
now
(the mic could be a bit louder, but it works fine with skype).

The patch is very simple and is attached. This would conclude the fix
for this card, Takashi started with me some time ago (I just made the
tests).

Thanks.

-- 
Paulo Roma Cavalcanti
LCG - UFRJ

--00151748dcc6f7bb7b04630599e7
Content-Type: application/octet-stream; name="idt-blue-linein.patch"
Content-Disposition: attachment; filename="idt-blue-linein.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fr8wu70g0

ZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfc2lnbWF0ZWwuYyBiL3NvdW5kL3BjaS9o
ZGEvcGF0Y2hfc2lnbWF0ZWwuYwppbmRleCBhN2RmODFlLi5hZmRiNjU1IDEwMDY0NAotLS0gYS9z
b3VuZC9wY2kvaGRhL3BhdGNoX3NpZ21hdGVsLmMKKysrIGIvc291bmQvcGNpL2hkYS9wYXRjaF9z
aWdtYXRlbC5jCkBAIC00NzkzLDYgKzQ3OTMsMTAgQEAgYWdhaW46CiAJCXNwZWMtPm51bV9zbXV4
ZXMgPSBBUlJBWV9TSVpFKHN0YWM5MmhkNzN4eF9zbXV4X25pZHMpOwogCQlzcGVjLT5lYXBkX3N3
aXRjaCA9IDE7CiAJfQorCisJLyogd2FzIDB4MDExMTMwMTQgKi8KKwlzdGFjOTJ4eF9zZXRfY29u
ZmlnX3JlZyhjb2RlYywgMHgwYywgMHgwMTgxMzAyMSk7CisKIAlpZiAoc3BlYy0+Ym9hcmRfY29u
ZmlnID4gU1RBQ185MkhENzNYWF9SRUYpIHsKIAkJLyogR1BJTzAgSGlnaCA9IEVuYWJsZSBFQVBE
ICovCiAJCXNwZWMtPmVhcGRfbWFzayA9IHNwZWMtPmdwaW9fbWFzayA9IHNwZWMtPmdwaW9fZGly
ID0gMHgxOwo=
--00151748dcc6f7bb7b04630599e7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--00151748dcc6f7bb7b04630599e7--
