From: Tim Goetze <tim@quitte.de>
Subject: Re: snd_pcm_close hangs
Date: Sat, 1 Jun 2002 01:49:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0206010052450.668-200000@summer.quitte>
References: <Pine.LNX.4.21.0205311822540.882-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1121280059-1022888940=:668"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA10392
	for <alsa-devel@alsa-project.org>; Sat, 1 Jun 2002 01:49:07 +0200
In-Reply-To: <Pine.LNX.4.21.0205311822540.882-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1121280059-1022888940=:668
Content-Type: TEXT/PLAIN; charset=US-ASCII

me wrote:

>Takashi Iwai wrote:
>
>>At Thu, 30 May 2002 17:14:03 +0200 (CEST),
>>Tim Goetze wrote:
>>> 
>>> hi all,
>>> 
>>> both emu8k and ice1712 pcm drivers hang forever in ioctl(2) when
>>> closing a playback stream if the stream has been linked to the 
>>> same card's capture, has been prepared and written data to, but was
>>> never started:
>>> 
>>> Program received signal SIGINT, Interrupt.
>>> 0x403b8fa4 in ioctl () from /lib/libc.so.6
>>> (gdb) bt
>>> #0  0x403b8fa4 in ioctl () from /lib/libc.so.6
>>> #1  0x40580abc in __DTOR_END__ () from /usr/lib/libasound.so.2
>>> #2  0x4053bde9 in snd_pcm_drain (pcm=0x81c6ae8) at pcm.c:813
>>> #3  0x4053b649 in snd_pcm_close (pcm=0x81c6ae8) at pcm.c:552
>>> #4  0x40462d79 in AlsaStream::~AlsaStream (this=0x81bf6a8,
>>> __in_chrg=0)
>>>     at AlsaStream.cc:41
>>> #5  0x4049ef01 in AlsaOut::~AlsaOut (this=0x81bf6a8, __in_chrg=3)
>>>     at PyType.h:110
>>
>>it seems stalling at drain ioctl.  can you figure out which stream is?
>
>playback. 

a playback stream not linked to any other stream behaves the same.

before calling snd_pcm_close(), i get

[~] cat /proc/asound/ice/pcm0p/sub0/status 
state: PREPARED
trigger_time: 0.000000
tstamp      : 1022886544.305384
delay       : -1053620964
avail       : 0
avail_max   : 0

this is what happens in snd_pcm_playback_drain() when i call
snd_pcm_close() now:

the stream is started ok. the stream state is then switched to
SNDRV_PCM_STATE_DRAINING and then the interruptible loop waiting for
the stream to go to a different state is running forever because
stream->state remains 5 = SNDRV_PCM_STATE_DRAINING. 

at this point, i get

[~] cat /proc/asound/ice/pcm0p/sub0/status 
state: <NULL>
trigger_time: 1022886587.196499
tstamp      : 1022886605.224624
delay       : -790953
avail       : 795049
avail_max   : 795049

and a little later

[~] cat /proc/asound/ice/pcm0p/sub0/status 
state: <NULL>
trigger_time: 1022886587.196499
tstamp      : 1022886607.877699
delay       : -907955
avail       : 912051
avail_max   : 912051

and so on, so the card is firing irqs (a fact cat /proc/interrupts
confirms). 

if i haven't run my code under gdb i then need to reboot the box to
work with the card because the module is claimed 'busy'.

tim

ps: i think "state: <NULL>" in the output from /proc above suggests
that "char * snd_pcm_state_names[]" (in kernel/pcm.c:139) needs a
revision. a patch is attached.
 
pps: please, please, please somebody of you authors of alsa-driver/*,
do add some comments around the code. i have absolutely no clue why
a stream that is about to be closed needs draining in the first place.

--8323328-1121280059-1022888940=:668
Content-Type: TEXT/plain; name="state-names.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0206010149000.668@summer.quitte>
Content-Description: 
Content-Disposition: attachment; filename="state-names.diff"

SW5kZXg6IGFsc2EtZHJpdmVyL2tlcm5lbC9wY20uYw0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnNyb290L2Fsc2EvYWxzYS1kcml2
ZXIva2VybmVsL0F0dGljL3BjbS5jLHYNCnJldHJpZXZpbmcgcmV2aXNpb24g
MS4xMjANCmRpZmYgLXUgLXIxLjEyMCBwY20uYw0KLS0tIGFsc2EtZHJpdmVy
L2tlcm5lbC9wY20uYwkxMiBPY3QgMjAwMSAxMDo0MzoxOCAtMDAwMAkxLjEy
MA0KKysrIGFsc2EtZHJpdmVyL2tlcm5lbC9wY20uYwkzMSBNYXkgMjAwMiAy
Mzo0NTo1NCAtMDAwMA0KQEAgLTE0MSw3ICsxNDEsOSBAQA0KIAlTVEFURShQ
UkVQQVJFRCksDQogCVNUQVRFKFJVTk5JTkcpLA0KIAlTVEFURShYUlVOKSwN
CisJU1RBVEUoRFJBSU5JTkcpLA0KIAlTVEFURShQQVVTRUQpLA0KKwlTVEFU
RShTVVNQRU5ERUQpLA0KIH07DQogDQogY2hhciAqc25kX3BjbV9hY2Nlc3Nf
bmFtZXNbXSA9IHsNCg==
--8323328-1121280059-1022888940=:668--

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
