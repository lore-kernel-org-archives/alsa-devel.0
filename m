From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH 4/4] alsa-driver: schedule_timeout() fixes.
Date: Tue, 18 Sep 2007 19:05:13 +0200
Message-ID: <46F00549.7050005@gmail.com>
References: <46E58D01.9080809@gmail.com>	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>	<46EF18FF.7070906@gmail.com>	<46EF3097.7060300@gmail.com>	<46EF52E4.90401@gmail.com>	<s5habrkchpa.wl%tiwai@suse.de>	<46EFE206.3090900@gmail.com>
	<s5hodfzsz3h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070703070704050901060502"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id C980810380E
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 19:06:17 +0200 (CEST)
In-Reply-To: <s5hodfzsz3h.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070703070704050901060502
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 09/18/2007 06:44 PM, Takashi Iwai wrote:

>> Speaking about that msnd one -- I believe I've seen that driver sittin=
g in=20
>> isa/ in alsa-drivers ages ago already. Is someone still working on tha=
t?=20
>> (no, I don't have the hardware).
>>
>> Signed-off-by: Rene Herman <rene.herman@gmail.com>
>=20
> Got a compiler error.
>=20
> alsa-driver/isa/msnd/msnd_pinnacle.c: In function =E2=80=98snd_msnd_cal=
ibrate_adc=E2=80=99:
> alsa-driver/isa/msnd/msnd_pinnacle.c:692: error: implicit declaration o=
f function =E2=80=98msecs_to_jiffiies=E2=80=99

What an amazingly perfect example of the problem with noisy builds ;-/

For me, it's a warning, buried just above a string of other warnings:

   CC [M]  /home/rene/src/alsa/alsa-driver/isa/msnd/msnd.o
   CC [M]  /home/rene/src/alsa/alsa-driver/isa/msnd/msnd_pinnacle.o
/home/rene/src/alsa/alsa-driver/isa/msnd/msnd_pinnacle.c: In function=20
'snd_msnd_calibrate_adc':
/home/rene/src/alsa/alsa-driver/isa/msnd/msnd_pinnacle.c:692: warning:=20
implicit declaration of function 'msecs_to_jiffiies'
include/asm/io.h: In function 'memcpy_toio':
include/asm/io.h:208: warning: passing argument 1 of '__memcpy' discards=20
qualifiers from pointer target type
include/asm/io.h: In function 'memset_io':
include/asm/io.h:200: warning: passing argument 1 of=20
'__constant_c_and_count_memset' discards qualifiers from pointer target t=
ype
include/asm/io.h:200: warning: passing argument 1 of '__constant_c_memset=
'=20
discards qualifiers from pointer target type
include/asm/io.h:200: warning: passing argument 1 of '__memset_generic'=20
discards qualifiers from pointer target type
include/asm/io.h:200: warning: passing argument 1 of '__memset_generic'=20
discards qualifiers from pointer target type
   CC [M]  /home/rene/src/alsa/alsa-driver/isa/msnd/msnd_pinnacle_mixer.o
   CC [M]  /home/rene/src/alsa/alsa-driver/isa/msnd/msnd_midi.o
   LD [M]  /home/rene/src/alsa/alsa-driver/isa/msnd/snd-msnd-pinnacle.o
   CC [M]  /home/rene/src/alsa/alsa-driver/isa/opti9xx/miro.o

(and I'm still getting used to this mercurial environment and just buildi=
ng=20
everything with ./hgcompile meaning it's a lot of output).

Anyways, s/jiffiies/jiffies/ and sorry for not noticing. Updated patch=20
attached. Changelog:

=3D=3D=3D
alsa-driver: use schedule_timeout_{,un}interruptible.

Replace 3 open-coded implementations of schedule_timout_{,un}interruptibl=
e=20
and use {u,m}secs_to_jiffies.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
=3D=3D=3D

Rene.

--------------070703070704050901060502
Content-Type: text/plain;
 name="schedule_timeout-alsa_driver.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="schedule_timeout-alsa_driver.diff"

ZGlmZiAtciAzZmVmYWNkNWQ3NmMgaXNhL21zbmQvbXNuZF9waW5uYWNsZS5jCi0tLSBhL2lz
YS9tc25kL21zbmRfcGlubmFjbGUuYwlNb24gU2VwIDE3IDE5OjA0OjQwIDIwMDcgKzAyMDAK
KysrIGIvaXNhL21zbmQvbXNuZF9waW5uYWNsZS5jCVR1ZSBTZXAgMTggMTg6NTE6MzkgMjAw
NyArMDIwMApAQCAtMjM5LDEwICsyMzksOCBAQCBzdGF0aWMgdm9pZCBkc3Bfd3JpdGVfZmx1
c2godm9pZCkKIAkJJmRldi53cml0ZWZsdXNoLAogCQlnZXRfcGxheV9kZWxheV9qaWZmaWVz
KGRldi5EQVBGLmxlbikpOyovCiAJY2xlYXJfYml0KEZfV1JJVEVGTFVTSCwgJmRldi5mbGFn
cyk7Ci0JaWYgKCFzaWduYWxfcGVuZGluZyhjdXJyZW50KSkgewotCQljdXJyZW50LT5zdGF0
ZSA9IFRBU0tfSU5URVJSVVBUSUJMRTsKLQkJc2NoZWR1bGVfdGltZW91dChnZXRfcGxheV9k
ZWxheV9qaWZmaWVzKCBkZXYucGxheV9wZXJpb2RfYnl0ZXMpKTsKLQl9CisJaWYgKCFzaWdu
YWxfcGVuZGluZyhjdXJyZW50KSkgCisJCXNjaGVkdWxlX3RpbWVvdXRfaW50ZXJydXB0aWJs
ZShnZXRfcGxheV9kZWxheV9qaWZmaWVzKGRldi5wbGF5X3BlcmlvZF9ieXRlcykpOwogCWNs
ZWFyX2JpdChGX1dSSVRJTkcsICZkZXYuZmxhZ3MpOwogfQogCkBAIC02OTEsOCArNjg5LDcg
QEAgc3RhdGljIGludCBfX2luaXQgc25kX21zbmRfY2FsaWJyYXRlX2FkYwogCQkgICAgICAg
JiB+MHgwMDAxLCBkZXYuU01BICsgU01BX3dDdXJySG9zdFN0YXR1c0ZsYWdzKTsKIAlpZiAo
c25kX21zbmRfc2VuZF93b3JkKCZkZXYsIDAsIDAsIEhERVhBUl9DQUxfQV9UT19EKSA9PSAw
ICYmCiAJICAgIHNuZF9tc25kX3NlbmRfZHNwX2NtZF9jaGsoJmRldiwgSERFWF9BVVhfUkVR
KSA9PSAwKSB7Ci0JCWN1cnJlbnQtPnN0YXRlID0gVEFTS19JTlRFUlJVUFRJQkxFOwotCQlz
Y2hlZHVsZV90aW1lb3V0KEhaIC8gMyk7CisJCXNjaGVkdWxlX3RpbWVvdXRfaW50ZXJydXB0
aWJsZShtc2Vjc190b19qaWZmaWVzKDMzMykpOwogCQlyZXR1cm4gMDsKIAl9CiAJcHJpbnRr
KEtFUk5fV0FSTklORyBMT0dOQU1FICI6IEFEQyBjYWxpYnJhdGlvbiBmYWlsZWRcbiIpOwpk
aWZmIC1yIDNmZWZhY2Q1ZDc2YyBwY2kvYXNpaHBpL2hwaW9zX2xpbnV4X2tlcm5lbC5jCi0t
LSBhL3BjaS9hc2locGkvaHBpb3NfbGludXhfa2VybmVsLmMJTW9uIFNlcCAxNyAxOTowNDo0
MCAyMDA3ICswMjAwCisrKyBiL3BjaS9hc2locGkvaHBpb3NfbGludXhfa2VybmVsLmMJVHVl
IFNlcCAxOCAxODo1MTozOSAyMDA3ICswMjAwCkBAIC0zOCw4ICszOCw3IEBAIGFuZCB0aGUg
dGFzayByZWNlaXZlcyBhIHNpZ25hbC4KIGFuZCB0aGUgdGFzayByZWNlaXZlcyBhIHNpZ25h
bC4KIFNldHRpbmcgdGhlIHN0YXRlIHRvIFVOSU5URVJSVVBUSUJMRSBzdG9wcyBpdCBmcm9t
IHJldHVybmluZyBlYXJseS4KICovCi0JCXNldF9jdXJyZW50X3N0YXRlKFRBU0tfVU5JTlRF
UlJVUFRJQkxFKTsKLQkJc2NoZWR1bGVfdGltZW91dCgoSFogKiBkd051bU1pY3JvU2VjICsg
KEhaIC0gMSkpIC8gMTAwMDAwMCk7CisJCXNjaGVkdWxlX3RpbWVvdXRfdW5pbnRlcnJ1cHRp
YmxlKHVzZWNzX3RvX2ppZmZpZXMoZHdOdW1NaWNyb1NlYykpOwogCX0gZWxzZSBpZiAoZHdO
dW1NaWNyb1NlYyA8PSAyMDAwKQogCQl1ZGVsYXkoZHdOdW1NaWNyb1NlYyk7CiAJZWxzZQo=
--------------070703070704050901060502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070703070704050901060502--
