From: Brent Weatherall <brentweatherall@gmail.com>
Subject: Re: PandaBoard ES Audio Problems
Date: Thu, 31 Jan 2013 11:24:04 -0800
Message-ID: <CAAo96ZDNUY8Sp=kmjGXy5Ro0q7x22XVtO3Uv0VhhJBugUvOfTw@mail.gmail.com>
References: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
 <510AA9A0.4060009@ladisch.de> <1359656599.10392.13.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 20EB6264EFF
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 20:24:05 +0100 (CET)
Received: by mail-pa0-f54.google.com with SMTP id fa10so225639pad.27
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 11:24:04 -0800 (PST)
In-Reply-To: <1359656599.10392.13.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Clemens/Liam,

     Liam, I address your question below.  Clemens, stepping through the
ALSA code, it seems the error *might* be in the ALSA code, but I am
probably reading the code incorrectly:

pcm/interval.c:

105 int snd_interval_refine_min(snd_interval_t *i, unsigned int min, int
openmin)
106 {
107         int changed = 0;
108         if (snd_interval_empty(i))
109                 return -ENOENT;
110         if (i->min < min) {
111                 i->min = min;  <-- Is this statement reversed or do I
not understand the code well enough?
112                 i->openmin = openmin;
113                 changed = 1;
114         } else if (i->min == min && !i->openmin && openmin) {
115                 i->openmin = 1;
116                 changed = 1;
117         }
118         if (i->integer) {
119                 if (i->openmin) {
120                         i->min++;
121                         i->openmin = 0;
122                 }
123         }
124         if (snd_interval_checkempty(i)) {
125                 snd_interval_none(i);
126
127         }
128         return changed;
129 }
130

Lines 110 - 113 appear to check if the hw params returned structure's
minimum value (i->min) is less than the current min value (which is set to
the requested rate in pcm.c:827  min = max = best).  Then if true, it
appears to set the hardware reported min value to the current min, instead
of the other way around.  Maybe I am misunderstanding the code, but that
appears to be what is happening.  I haven't stepped past the
'snd_interval_refine_min' function just yet.  Another GDB session snippet.
 I left out GDB portions that were not important:

pcm_params.c:'snd_pcm_hw_param_set_near':815:
 825         if (best > INT_MAX)
 826                 best = INT_MAX;
 827         min = max = best;

GDB session:
_snd_pcm_hw_param_set_min (params=0x13248, var=SNDRV_PCM_HW_PARAM_RATE,
val=44100, dir=0) at pcm_params.c:412
412             else if (hw_is_interval(var))
_snd_pcm_hw_param_set_min (params=0x13248, var=SNDRV_PCM_HW_PARAM_RATE,
val=44100, dir=0) at pcm_params.c:412
413                     changed =
snd_interval_refine_min(hw_param_interval(params,
var), val, openmin);
snd1_interval_refine_min (i=0x13370, min=44100, openmin=0) at interval.c:106
(gdb) p {snd_interval_t} i <-- I interpreted this to be from the device.
 Correct or no?
$24 = {min = 4000, max = 4294967295, openmin = 0, openmax = 1, integer = 0,
empty = 0}
(gdb) s
snd1_interval_refine_min (i=0x13370, min=44100, openmin=0) at interval.c:108
108             if (snd_interval_empty(i))
(gdb) s
110             if (i->min < min) {
(gdb) p min
$25 = 44100
(gdb) s
112                     i->openmin = openmin;
(gdb) p i->min
$26 = 4000
(gdb) p min
$27 = 44100
(gdb) s
111                     i->min = min;
(gdb) s
112                     i->openmin = openmin;
(gdb) p i->min
$28 = 44100
(gdb)

I just seems like it's setting the min value to what was requested instead
of what was in the snd_interval_t structure.  But maybe that is intended.
 Maybe I missed something higher in the calling tree.

Liam,

     Thank you for the information.

>Can you check you have enabled a valid playback path with
>alsaucm/alsamixer and then test with aplay. This should help narrow down
>the issue.

When I started this project, I used the alsamixer to verify the sound
devices and so forth.  There appears to be nothing abnormal as far as I can
tell.  Several devices exist and have changeable values.  There are PandaES
devices and HDMI devices (as also seen with aplay/acrecord -L).  I was able
to record and play back all the following wav files with arecord/aplay:

11025_capt.wav  12000_capt.wav  16000_capt.wav  22050_capt.wav
 24000_capt.wav  32000_capt.wav  44100_capt.wav  48000_capt.wav
 8000_capt.wav with the 'default' device at card 0, device 0.

The number in the file name being the rate it was recorded at.

I found the current issue when I tried to use the Bellagio OpenMax-ALSA
component to playback audio.  I ran the 'omxcapnplay' test routine (from
the libomxalsa library 'test' directory) and it kept failing with 'invalid
argument'.  After digging into the details I found the OMX constructor sets
a default rate of 44100.  I wrote test code to recreate the problem and
found the current issue (asking for 44100 with set_rate_near succeeds, but
when the params are committed it fails).  Then you cannot re-configure
without closing the device.

I also found that 'aplay' can playback any rate I want, BUT when I use code
to open the PCM device I can ONLY open it with rates of 8000, 12000, 16000,
24000 and 48000 AND this is only if use the 'set_buffer_time_near' call
before trying to commit.  Otherwise I can ONLY set 8000 when using the
minimum number of 'snd_pcm*' configuration calls (see OpenMax
ALSA component SetParams function for reference).  Oddly enough
'speaker-test' cannot playback 48000 Hz even though I can open the device
with a rate of 48000 Hz.

Also, alsaloop works without issues.

If it would be helpful, I can post my test program source and the various
outputs I get when running with the rates I mentioned above.
For playback I am using 'default' which is card 0, device 0.

Thank you for taking the time to look this over.  Is there an aplay command
that might uncover if there is a valid path to the device, or does the
ability to play sound with aplay demonstrate the presence of the path?

Regards,

Brent

On Thu, Jan 31, 2013 at 10:23 AM, Liam Girdwood <
liam.r.girdwood@linux.intel.com> wrote:

> On Thu, 2013-01-31 at 18:28 +0100, Clemens Ladisch wrote:
> > Brent Weatherall wrote:
> > > At a high level, when configuring the built in audio device (3.5 mm
> jack),
> > > the device accepts ANY rate requested (via snd_pcm_set_rate_near).  it
> > > accepts unsupported rates without alteration.  If the rate is actually
> not
> > > supported, then 'snd_pcm_hw_params' fails with error '-22'.
> >
> > This sounds as if the driver published incorrect constraints.
> >
> > Do you have a pointer to the driver's source code?
> >
>
> The OMAP4 ABE driver doesn't actually know the exact constraints if
> there is not a valid playback path between source PCM and sink (it will
> still throw out anything insane though). This is because it can route
> audio from most of it's PCMs to most of it's components, e.g. HS, HF,
> BT, MODEM, Earpiece, etc where some components have different
> constraints. It's possible that you dont have a path in your case.
>
> Can you check you have enabled a valid playback path with
> alsaucm/alsamixer and then test with aplay. This should help narrow down
> the issue.
>
> I've CC'ed Peter since 3.4 is a little old and he is working on the
> latest OMAP4 codebase.
>
> Regards
>
> Liam
>
>
>
>
>
