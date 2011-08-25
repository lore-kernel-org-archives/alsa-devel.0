From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] alsa-plugins: Pulse: only underrun if no
 more data has been written
Date: Thu, 25 Aug 2011 14:25:56 +0800
Message-ID: <CAN8ccibi-g_bXU3+FvmWF=FGx+w7hSzTfTAk7WmHgkgqhJ=zmA@mail.gmail.com>
References: <4E4D2A67.9050507@canonical.com> <s5hobzllubm.wl%tiwai@suse.de>
	<4E4E31A5.2090100@canonical.com> <s5hliup7emd.wl%tiwai@suse.de>
	<4E53958A.5050602@canonical.com> <s5hbovgp7p4.wl%tiwai@suse.de>
	<CAN8cciZ046qj=2aaa0ETgCXtrOhu5Z8+p_dFNPjJ199vXtA7RQ@mail.gmail.com>
	<4E55E8ED.8010106@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B2FA10380B
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 08:25:57 +0200 (CEST)
Received: by fxh10 with SMTP id 10so1547727fxh.38
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2011 23:25:57 -0700 (PDT)
In-Reply-To: <4E55E8ED.8010106@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/8/25 David Henningsson <david.henningsson@canonical.com>:
> On 08/25/2011 07:53 AM, Raymond Yau wrote:
>>
>> 2011/8/23 Takashi Iwai<tiwai@suse.de>:
>> =A0be enough just to have a
>>>
>>> boolean for underrun_detect yes/no.
>>>
>>> So, the patch would be like below.
>>>
>>> What do you think?
>>>
>>>
>>> Takashi
>>>
>>> ---
>>> diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
>>> index d6c6792..b0e52ab 100644
>>> --- a/pulse/pcm_pulse.c
>>> +++ b/pulse/pcm_pulse.c
>>> @@ -42,6 +42,7 @@ typedef struct snd_pcm_pulse {
>>> =A0 =A0 =A0 =A0int handle_underrun;
>>>
>>> =A0 =A0 =A0 =A0size_t offset;
>>> + =A0 =A0 =A0 int64_t written;
>>>
>>> =A0 =A0 =A0 =A0pa_stream *stream;
>>>
>>> @@ -460,6 +461,7 @@ static snd_pcm_sframes_t pulse_write(snd_pcm_ioplug=
_t
>>> * io,
>>>
>>> =A0 =A0 =A0 =A0/* Make sure the buffer pointer is in sync */
>>> =A0 =A0 =A0 =A0pcm->last_size -=3D writebytes;
>>> + =A0 =A0 =A0 pcm->written +=3D writebytes;
>>> =A0 =A0 =A0 =A0ret =3D update_ptr(pcm);
>>> =A0 =A0 =A0 =A0if (ret< =A00)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto finish;
>>> @@ -585,6 +587,15 @@ static void stream_request_cb(pa_stream * p, size_t
>>> length, void *userdata)
>>> =A0 =A0 =A0 =A0update_active(pcm);
>>> =A0}
>>>
>>> +#if defined(PA_CHECK_VERSION)&& =A0PA_CHECK_VERSION(0,99,0)
>>
>> compile fail at these line since PA_CHECK_VERSION is not defined in
>> pulseaudio 0.9.14
>
> I don't have PA 0.9.14 available, but that's why the line starts with "if
> defined(PA_CHECK_VERSION)" so that the second part should never be
> evaluated.


/bin/sh ../libtool --tag=3DCC   --mode=3Dcompile gcc -DHAVE_CONFIG_H -I.
-I..    -Wall -g -I/usr/include/alsa    -D_REENTRANT   -D_GNU_SOURCE
-O2 -Wall -W -pipe -g -MT pcm_pulse.lo -MD -MP -MF .deps/pcm_pulse.Tpo
-c -o pcm_pulse.lo pcm_pulse.c
 gcc -DHAVE_CONFIG_H -I. -I.. -Wall -g -I/usr/include/alsa
-D_REENTRANT -D_GNU_SOURCE -O2 -Wall -W -pipe -g -MT pcm_pulse.lo -MD
-MP -MF .deps/pcm_pulse.Tpo -c pcm_pulse.c  -fPIC -DPIC -o
.libs/pcm_pulse.o
pcm_pulse.c: In function =91stream_success_cb=92:
pcm_pulse.c:192: warning: unused parameter =91p=92
pcm_pulse.c:192: warning: unused parameter =91success=92
pcm_pulse.c: In function =91stream_request_cb=92:
pcm_pulse.c:578: warning: unused parameter =91p=92
pcm_pulse.c:578: warning: unused parameter =91length=92
pcm_pulse.c:590:50: error: missing binary operator before token "("
pcm_pulse.c: In function =91stream_underrun_cb=92:
pcm_pulse.c:599: warning: unused parameter =91p=92
pcm_pulse.c: In function =91stream_latency_cb=92:
pcm_pulse.c:612: warning: unused parameter =91p=92
pcm_pulse.c: In function =91pulse_pcm_poll_revents=92:
pcm_pulse.c:624: warning: unused parameter =91pfd=92
pcm_pulse.c:624: warning: unused parameter =91nfds=92
pcm_pulse.c: In function =91pulse_hw_params=92:
pcm_pulse.c:768: warning: unused parameter =91params=92
make: *** [pcm_pulse.lo] Error 1
