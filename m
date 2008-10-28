From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: Backported sbxfi driver, possible fix
Date: Tue, 28 Oct 2008 01:10:43 +0100
Message-ID: <5501535d0810271710y246926f2xdd8a3f31719c6af3@mail.gmail.com>
References: <4900A4FA.7020300@jasonline.co.uk> <s5hej24psn6.wl%tiwai@suse.de>
	<20081025194255.GA27872@rzle423.uni-duisburg.de>
	<s5hod18fntg.wl%tiwai@suse.de> <49038448.3090704@jasonline.co.uk>
	<5501535d0810251457k165cc4ceid2e34930a2bdc8ec@mail.gmail.com>
	<s5h7i7v22cl.wl%tiwai@suse.de> <ge3irb$knf$1@ger.gmane.org>
	<49055255.8030102@gmail.com> <s5h63ne1rh8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_75783_2331867.1225152644108"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 7616E24464
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 01:10:45 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so2154816rvb.32
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 17:10:44 -0700 (PDT)
In-Reply-To: <s5h63ne1rh8.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_75783_2331867.1225152644108
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Oct 27, 2008 at 07:28, Takashi Iwai <tiwai@suse.de> wrote:
> It'd be helpful if someone can summarize the working and non-working
> cases.  For example,
>
> global info:
> 1. sbxfi driver version (date & HEADs)
> 2. base_rate value
> 3. system details (x86-64, distro, kernel version, etc)
>
> for each app:
> A. Application name / version
> B. working or not-working, problem descriptions
> C. ALSA or OSS (you can see it in /proc/asound/card*/pcm0/sub0/hw_params)
> D. period_size and buffer_size (ditto, or in kernel message)
> E. any special options
>
> Maybe also nice on Wiki...
>
>
> thanks,
>
> Takashi
>

1. sbxfi driver version (date & HEADs)
	10/27/2008 05:55:00 PM

	./HEAD
	7d1c628613fa81595d145c897530e2eb0fbbf922 Merge commit 'stable/master'
	390dde1aeba0aec19bd121dfcb2147a1bc721756 jack - fix build with older kernels
	2e5fb80ee0cfed9c9ec4b977822b13d7a8d4790f Merge commit 'stable/master'
	d338c02cda2d5525e7ad3b35a2d51438c8fc8f08 x86 mach: test for
mach_apic.h to skip empty directories
	75b71fe1b618af2250692144205e71dede39aeb0 Merge commit 'stable/master'
	795b6cd7e0006e2c62a9c7004555b5b22c9e4329 alsa-info - Fix quoting
	8682b8b4ced855b01639d85098ca7de23db87c3d Merge branch 'topic/snd-hrtimer'
	46195d51d453ee7f1579028ba0407efafe03b3d4 snd-hrtimer - Add kernel
version dependency 2.6.24 or later
	058cbcd459dcfa90b40587932d4a2069497fa849 Merge branch 'topic/snd-hrtimer'
	8cadf99a5ca45aef2c4e7970e71bf1571163018d Merge branch 'topic/tools'

	./alsa-kernel/HEAD
	16fb0167b6a59608defbc164dad266613fae1fc5 Merge commit 'stable/master'
	58e5beb32b45cf7a09733886f600fe6442586cad Merge branch 'topic/fix/hda'
	e044c39ae258678d6ebb09fccb2a0fdf7ec51847 ALSA: hda - Restore default
pin configs for realtek codecs
	ec99a09ebe531c8d211b51d9e33d3a7341080e17 Merge branch 'topic/fix/misc'
	2f1e593d4209d0194f9639c5d11aa91171435963 sound: use a common working
email address
	07580a206c3755724fea57bc84a4a4064ee62c00 Merge commit 'stable/master'
	b69dffcb0a963ff7f0d9bad391c2c9bae37a837e Merge branch 'topic/hda-next'
	74aeaabc3e452b29bc1b9eac5aa48923569f8a4e ALSA: hda: add support for
jack detection on IDT codecs.
	50a9f7905fb3e6ae25e80ba443a14d878caef0c9 ALSA: hda: add
snd_hda_get_jack* functions
	282cd76ffca781013151344c4b0f9229e9ea3c35 ALSA: hda: dynamic jack id

2. base_rate value
	rate: 96000 (96000/1)

3. system details

	Gentoo Linux
	Portage 2.1.4.5 (default-linux/amd64/2007.0/desktop, gcc-4.1.2,
glibc-2.6.1-r0, 2.6.27.3-unpatched x86_64)
	=================================================================
	System uname: 2.6.27.3-unpatched x86_64 Intel(R) Core(TM)2 CPU 6600 @ 2.40GHz
	Timestamp of tree: Sun, 26 Oct 2008 16:18:01 +0000
	distcc 2.18.3 x86_64-pc-linux-gnu (protocols 1 and 2) (default port
3632) [disabled]


A)	MPlayer dev-SVN-r27725-4.1.2
B)	Working, but horrible, crackeling sound at samplingrate 11025Hz
22050Hz 44056 44100 47250 5000(less than the others) 50400 8000 88200
(3200, 48000 and 96000 are fine)
	checked with WindowsXP. In XP the sound is nice and clear. So the
files are good.
C)	OSS (see bug-mplayer file)
D)	See bug-mplayer file
E)	nothing

A)	Xine 0.99.5
B)	No samplingrate is clear, all is crackeling....
C) 	ALSA I guess (bug-mplayer file)
D)	See bug-xine file
E)	nothing


So one wired thing:
I first tested mplayer... all samplingrates except 3200, 48000 and
96000 were bad.
Then I tested xine... everything was bad.
Then I tested mplayer again to dump the info into the files (bug-mplayer)
suddenly all samplerates were fine.... testing again and all went bad again?
But basically you can say everything is crapy right now.

Kind regards
Bjoern

------=_Part_75783_2331867.1225152644108
Content-Type: application/octet-stream; name=bug-mplayer
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fmts7opx0
Content-Disposition: attachment; filename=bug-mplayer

YWNjZXNzOiBSV19JTlRFUkxFQVZFRApmb3JtYXQ6IFMxNl9MRQpzdWJmb3JtYXQ6IFNURApjaGFu
bmVsczogMgpyYXRlOiA5NjAwMCAoOTYwMDAvMSkKcGVyaW9kX3NpemU6IDQ0NDgKYnVmZmVyX3Np
emU6IDg4OTYKT1NTIGZvcm1hdDogUzE2X0xFCk9TUyBjaGFubmVsczogMgpPU1MgcmF0ZTogMTEw
MjUKT1NTIHBlcmlvZCBieXRlczogMjA0MApPU1MgcGVyaW9kczogMgpPU1MgcGVyaW9kIGZyYW1l
czogNDQ0OAphY2Nlc3M6IFJXX0lOVEVSTEVBVkVECmZvcm1hdDogUzE2X0xFCnN1YmZvcm1hdDog
U1RECmNoYW5uZWxzOiAyCnJhdGU6IDk2MDAwICg5NjAwMC8xKQpwZXJpb2Rfc2l6ZTogNDQ0OApi
dWZmZXJfc2l6ZTogODg5NgpPU1MgZm9ybWF0OiBTMTZfTEUKT1NTIGNoYW5uZWxzOiAyCk9TUyBy
YXRlOiAyMjA1MApPU1MgcGVyaW9kIGJ5dGVzOiA0MDg0Ck9TUyBwZXJpb2RzOiAyCk9TUyBwZXJp
b2QgZnJhbWVzOiA0NDQ4CmFjY2VzczogUldfSU5URVJMRUFWRUQKZm9ybWF0OiBTMTZfTEUKc3Vi
Zm9ybWF0OiBTVEQKY2hhbm5lbHM6IDIKcmF0ZTogOTYwMDAgKDk2MDAwLzEpCnBlcmlvZF9zaXpl
OiA2MTQ0CmJ1ZmZlcl9zaXplOiAxMjI4OApPU1MgZm9ybWF0OiBTMTZfTEUKT1NTIGNoYW5uZWxz
OiAyCk9TUyByYXRlOiAzMjAwMApPU1MgcGVyaW9kIGJ5dGVzOiA4MTk2Ck9TUyBwZXJpb2RzOiAy
Ck9TUyBwZXJpb2QgZnJhbWVzOiA2MTQ0CmFjY2VzczogUldfSU5URVJMRUFWRUQKZm9ybWF0OiBT
MTZfTEUKc3ViZm9ybWF0OiBTVEQKY2hhbm5lbHM6IDIKcmF0ZTogOTYwMDAgKDk2MDAwLzEpCnBl
cmlvZF9zaXplOiA0NDQ4CmJ1ZmZlcl9zaXplOiA4ODk2Ck9TUyBmb3JtYXQ6IFMxNl9MRQpPU1Mg
Y2hhbm5lbHM6IDIKT1NTIHJhdGU6IDQ0MDU2Ck9TUyBwZXJpb2QgYnl0ZXM6IDgxNjgKT1NTIHBl
cmlvZHM6IDIKT1NTIHBlcmlvZCBmcmFtZXM6IDQ0NDgKYWNjZXNzOiBSV19JTlRFUkxFQVZFRApm
b3JtYXQ6IFMxNl9MRQpzdWJmb3JtYXQ6IFNURApjaGFubmVsczogMgpyYXRlOiA5NjAwMCAoOTYw
MDAvMSkKcGVyaW9kX3NpemU6IDQ0NDgKYnVmZmVyX3NpemU6IDg4OTYKT1NTIGZvcm1hdDogUzE2
X0xFCk9TUyBjaGFubmVsczogMgpPU1MgcmF0ZTogNDQxMDAKT1NTIHBlcmlvZCBieXRlczogODE3
NgpPU1MgcGVyaW9kczogMgpPU1MgcGVyaW9kIGZyYW1lczogNDQ0OAphY2Nlc3M6IFJXX0lOVEVS
TEVBVkVECmZvcm1hdDogUzE2X0xFCnN1YmZvcm1hdDogU1RECmNoYW5uZWxzOiAyCnJhdGU6IDk2
MDAwICg5NjAwMC8xKQpwZXJpb2Rfc2l6ZTogNDE2MApidWZmZXJfc2l6ZTogODMyMApPU1MgZm9y
bWF0OiBTMTZfTEUKT1NTIGNoYW5uZWxzOiAyCk9TUyByYXRlOiA0NzI1MApPU1MgcGVyaW9kIGJ5
dGVzOiA4MTkyCk9TUyBwZXJpb2RzOiAyCk9TUyBwZXJpb2QgZnJhbWVzOiA0MTYwCmFjY2Vzczog
UldfSU5URVJMRUFWRUQKZm9ybWF0OiBTMTZfTEUKc3ViZm9ybWF0OiBTVEQKY2hhbm5lbHM6IDIK
cmF0ZTogOTYwMDAgKDk2MDAwLzEpCnBlcmlvZF9zaXplOiAyMDQ4CmJ1ZmZlcl9zaXplOiAxNjM4
NApPU1MgZm9ybWF0OiBTMTZfTEUKT1NTIGNoYW5uZWxzOiAyCk9TUyByYXRlOiA0ODAwMApPU1Mg
cGVyaW9kIGJ5dGVzOiA0MDk2Ck9TUyBwZXJpb2RzOiA4Ck9TUyBwZXJpb2QgZnJhbWVzOiAyMDQ4
CmFjY2VzczogUldfSU5URVJMRUFWRUQKZm9ybWF0OiBTMTZfTEUKc3ViZm9ybWF0OiBTVEQKY2hh
bm5lbHM6IDIKcmF0ZTogOTYwMDAgKDk2MDAwLzEpCnBlcmlvZF9zaXplOiAxOTUyCmJ1ZmZlcl9z
aXplOiAxNTYxNgpPU1MgZm9ybWF0OiBTMTZfTEUKT1NTIGNoYW5uZWxzOiAyCk9TUyByYXRlOiA1
MDAwMApPU1MgcGVyaW9kIGJ5dGVzOiA0MDY4Ck9TUyBwZXJpb2RzOiA4Ck9TUyBwZXJpb2QgZnJh
bWVzOiAxOTUyCmFjY2VzczogUldfSU5URVJMRUFWRUQKZm9ybWF0OiBTMTZfTEUKc3ViZm9ybWF0
OiBTVEQKY2hhbm5lbHM6IDIKcmF0ZTogOTYwMDAgKDk2MDAwLzEpCnBlcmlvZF9zaXplOiAxOTUy
CmJ1ZmZlcl9zaXplOiAxNTYxNgpPU1MgZm9ybWF0OiBTMTZfTEUKT1NTIGNoYW5uZWxzOiAyCk9T
UyByYXRlOiA1MDQwMApPU1MgcGVyaW9kIGJ5dGVzOiA0MTAwCk9TUyBwZXJpb2RzOiA4Ck9TUyBw
ZXJpb2QgZnJhbWVzOiAxOTUyCmFjY2VzczogUldfSU5URVJMRUFWRUQKZm9ybWF0OiBTMTZfTEUK
c3ViZm9ybWF0OiBTVEQKY2hhbm5lbHM6IDIKcmF0ZTogOTYwMDAgKDk2MDAwLzEpCnBlcmlvZF9z
aXplOiA2MTQ0CmJ1ZmZlcl9zaXplOiAxMjI4OApPU1MgZm9ybWF0OiBTMTZfTEUKT1NTIGNoYW5u
ZWxzOiAyCk9TUyByYXRlOiA4MDAwCk9TUyBwZXJpb2QgYnl0ZXM6IDIwNTIKT1NTIHBlcmlvZHM6
IDIKT1NTIHBlcmlvZCBmcmFtZXM6IDYxNDQKYWNjZXNzOiBSV19JTlRFUkxFQVZFRApmb3JtYXQ6
IFMxNl9MRQpzdWJmb3JtYXQ6IFNURApjaGFubmVsczogMgpyYXRlOiA5NjAwMCAoOTYwMDAvMSkK
cGVyaW9kX3NpemU6IDExMjAKYnVmZmVyX3NpemU6IDg5NjAKT1NTIGZvcm1hdDogUzE2X0xFCk9T
UyBjaGFubmVsczogMgpPU1MgcmF0ZTogODgyMDAKT1NTIHBlcmlvZCBieXRlczogNDExNgpPU1Mg
cGVyaW9kczogOApPU1MgcGVyaW9kIGZyYW1lczogMTEyMAphY2Nlc3M6IFJXX0lOVEVSTEVBVkVE
CmZvcm1hdDogUzE2X0xFCnN1YmZvcm1hdDogU1RECmNoYW5uZWxzOiAyCnJhdGU6IDk2MDAwICg5
NjAwMC8xKQpwZXJpb2Rfc2l6ZTogMTAyNApidWZmZXJfc2l6ZTogMTYzODQKT1NTIGZvcm1hdDog
UzE2X0xFCk9TUyBjaGFubmVsczogMgpPU1MgcmF0ZTogOTYwMDAKT1NTIHBlcmlvZCBieXRlczog
NDA5NgpPU1MgcGVyaW9kczogMTYKT1NTIHBlcmlvZCBmcmFtZXM6IDEwMjQK
------=_Part_75783_2331867.1225152644108
Content-Type: application/octet-stream; name=bug-xine
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fmts7xcc1
Content-Disposition: attachment; filename=bug-xine

YWNjZXNzOiBNTUFQX0lOVEVSTEVBVkVECmZvcm1hdDogUzE2X0xFCnN1YmZvcm1hdDogU1RECmNo
YW5uZWxzOiAyCnJhdGU6IDk2MDAwICg5NjAwMC8xKQpwZXJpb2Rfc2l6ZTogMjA0OApidWZmZXJf
c2l6ZTogMTYzODQKYWNjZXNzOiBNTUFQX0lOVEVSTEVBVkVECmZvcm1hdDogUzE2X0xFCnN1YmZv
cm1hdDogU1RECmNoYW5uZWxzOiAyCnJhdGU6IDk2MDAwICg5NjAwMC8xKQpwZXJpb2Rfc2l6ZTog
MjA0OApidWZmZXJfc2l6ZTogMTYzODQKYWNjZXNzOiBNTUFQX0lOVEVSTEVBVkVECmZvcm1hdDog
UzE2X0xFCnN1YmZvcm1hdDogU1RECmNoYW5uZWxzOiAyCnJhdGU6IDk2MDAwICg5NjAwMC8xKQpw
ZXJpb2Rfc2l6ZTogMjA0OApidWZmZXJfc2l6ZTogMTYzODQKYWNjZXNzOiBNTUFQX0lOVEVSTEVB
VkVECmZvcm1hdDogUzE2X0xFCnN1YmZvcm1hdDogU1RECmNoYW5uZWxzOiAyCnJhdGU6IDk2MDAw
ICg5NjAwMC8xKQpwZXJpb2Rfc2l6ZTogMjA0OApidWZmZXJfc2l6ZTogMTYzODQKYWNjZXNzOiBN
TUFQX0lOVEVSTEVBVkVECmZvcm1hdDogUzE2X0xFCnN1YmZvcm1hdDogU1RECmNoYW5uZWxzOiAy
CnJhdGU6IDk2MDAwICg5NjAwMC8xKQpwZXJpb2Rfc2l6ZTogMjA0OApidWZmZXJfc2l6ZTogMTYz
ODQKYWNjZXNzOiBNTUFQX0lOVEVSTEVBVkVECmZvcm1hdDogUzE2X0xFCnN1YmZvcm1hdDogU1RE
CmNoYW5uZWxzOiAyCnJhdGU6IDk2MDAwICg5NjAwMC8xKQpwZXJpb2Rfc2l6ZTogMjA0OApidWZm
ZXJfc2l6ZTogMTYzODQKYWNjZXNzOiBNTUFQX0lOVEVSTEVBVkVECmZvcm1hdDogUzE2X0xFCnN1
YmZvcm1hdDogU1RECmNoYW5uZWxzOiAyCnJhdGU6IDk2MDAwICg5NjAwMC8xKQpwZXJpb2Rfc2l6
ZTogMjA0OApidWZmZXJfc2l6ZTogMTYzODQKYWNjZXNzOiBNTUFQX0lOVEVSTEVBVkVECmZvcm1h
dDogUzE2X0xFCnN1YmZvcm1hdDogU1RECmNoYW5uZWxzOiAyCnJhdGU6IDk2MDAwICg5NjAwMC8x
KQpwZXJpb2Rfc2l6ZTogMjA0OApidWZmZXJfc2l6ZTogMTYzODQKYWNjZXNzOiBNTUFQX0lOVEVS
TEVBVkVECmZvcm1hdDogUzE2X0xFCnN1YmZvcm1hdDogU1RECmNoYW5uZWxzOiAyCnJhdGU6IDk2
MDAwICg5NjAwMC8xKQpwZXJpb2Rfc2l6ZTogMjA0OApidWZmZXJfc2l6ZTogMTYzODQKYWNjZXNz
OiBNTUFQX0lOVEVSTEVBVkVECmZvcm1hdDogUzE2X0xFCnN1YmZvcm1hdDogU1RECmNoYW5uZWxz
OiAyCnJhdGU6IDk2MDAwICg5NjAwMC8xKQpwZXJpb2Rfc2l6ZTogMjA0OApidWZmZXJfc2l6ZTog
MTYzODQKYWNjZXNzOiBNTUFQX0lOVEVSTEVBVkVECmZvcm1hdDogUzE2X0xFCnN1YmZvcm1hdDog
U1RECmNoYW5uZWxzOiAyCnJhdGU6IDk2MDAwICg5NjAwMC8xKQpwZXJpb2Rfc2l6ZTogMjA0OApi
dWZmZXJfc2l6ZTogMTYzODQKYWNjZXNzOiBNTUFQX0lOVEVSTEVBVkVECmZvcm1hdDogUzE2X0xF
CnN1YmZvcm1hdDogU1RECmNoYW5uZWxzOiAyCnJhdGU6IDk2MDAwICg5NjAwMC8xKQpwZXJpb2Rf
c2l6ZTogMjA0OApidWZmZXJfc2l6ZTogMTYzODQK
------=_Part_75783_2331867.1225152644108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_75783_2331867.1225152644108--
