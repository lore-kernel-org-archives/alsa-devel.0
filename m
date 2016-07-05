From: Trent Reed <treed0803@gmail.com>
Subject: Re: SND_PCM_STREAM_CAPTURE and SND_PCM_NONBLOCK
 producing strange artifacts
Date: Tue, 5 Jul 2016 01:46:12 -0700
Message-ID: <CAL6pMWoYAd_hR5UFs4kmdQC7PVmF=VBf8E1ihQyXti1PKpXoMw@mail.gmail.com>
References: <CAL6pMWpW4VMPkaeqUS3DaU4d+fUB2s1i9kpTPkfNPeNjW4gHpQ@mail.gmail.com>
 <CAL6pMWqXvZk0ZSQ+rPNRxjA5h8QT6nU_-NT_Gqh2AMUwjRGqJQ@mail.gmail.com>
 <s5hmvlwpoeb.wl-tiwai@suse.de>
 <CAL6pMWpwpgLBmqEhDnqKPvQPYmnSy1S=19m6YL=5YMpHQRfLtw@mail.gmail.com>
 <s5hinwkpmam.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f170.google.com (mail-qk0-f170.google.com
 [209.85.220.170])
 by alsa0.perex.cz (Postfix) with ESMTP id F3F31265325
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 10:46:13 +0200 (CEST)
Received: by mail-qk0-f170.google.com with SMTP id t127so282624054qkf.1
 for <alsa-devel@alsa-project.org>; Tue, 05 Jul 2016 01:46:13 -0700 (PDT)
In-Reply-To: <s5hinwkpmam.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 5, 2016 at 12:38 AM, Takashi Iwai <tiwai@suse.de> wrote:

> Please don't drop Cc to ML.  Also avoid top-post.
>

Whoops! Sorry - not too familiar with the etiquette yet. (Dropped Cc was an
honest mistake, reply instead of reply-all).


> On Tue, 05 Jul 2016 09:02:12 +0200,
> Trent Reed wrote:
> >
> > Thanks Takashi,
> >
> > My implementation does only use the "hw:N" devices, unfortunately - I am
> > not using MMAP because I was under the impression that you must poll when
> > directly accessing the hardware. And yes, 48kHz is the exact rate I'm
> > attempting. :(
> > I do have an update, though - I'm able to reproduce the issue quite
> simply
> > by running the ALSA test application latency with the following command:
> >
> > `latency -P <playback-device> -C <capture-device> -r 48000`
> >
> > This, as far as I understand from the source code, should open R/W
> > interleaved streams on ("hw:2" is what I'm using for both, though the
> > problem persists in non-duplex mode, e.g. "hw:2" "hw:0") in non-blocking
> > mode without polling.
> >
> > What happens is the latency application does normalize around some value
> > (say, 16ms roundtrip time), but the audio is awful and broken, a lot of
> > this "static" I'm talking about. It seems to me that it's the same
> problem
> > that I have in my above-mentioned sample code.
> >
> > I would love to help more, so if I can in any way, please let me know!
> But
> > I feel at a loss for how to further debug.
>
> The latency program is too complex to analyze the issue.  Check
> arecord with --nonblock --test-nowait options and with the hw device.
> Does the issue happen always?  Or does it depend on the buffer or
> period size?


> Takashi
>

It doesn't happen always, but it usually happens more often than not -
sometimes I'll go a few attempts without hearing the issue, and other times
it'll be consistent. The only constant seems to be that I have never heard
it occur when I am running snd_pcm_wait() (e.g. without --test-nowait). I
will keep trying this though to see if that ever changes.

Here are my attempted recordings:

Non-Blocking, No-Wait (produces static):
`arecord -Dhw:2 -fS16_LE -r48000 -c2 --period-size=256 --nonblock
--test-nowait -d5 > s16le-c2-p256-nonblock-nowait.wav`
https://drive.google.com/open?id=0B-1aumGKQcQTR0ZtUFlaV1Q5cFU

Non-Blocking, Wait (does not produce static):
`arecord -Dhw:2 -fS16_LE -r48000 -c2 --period-size=256 --nonblock -d5 >
s16le-c2-p256-nonblock-wait.wav`
https://drive.google.com/open?id=0B-1aumGKQcQTa2pGUWpTWmc1QW8

At first, I thought it had to do with the period - but here I attempt to
use the default period for arecord (unsure of what the default gets set to).
`arecord -Dhw:2 -fS16_LE -r48000 -c2 --nonblock --test-nowait -d5 >
s16le-c2-nonblock-nowait.wav`
https://drive.google.com/open?id=0B-1aumGKQcQTa280VG9LbHlreU0

To be absolutely sure that period size didn't play a role, I asked for a
specific size:
`arecord -Dhw:2 -fS16_LE -r48000 -c2 --period-size=1024 --nonblock
--test-nowait -d5 > s16le-c2-p1024-nonblock-nowait.wav`
https://drive.google.com/open?id=0B-1aumGKQcQTZlRCQ0lvek9YN3M

And it doesn't appear to relate to the sample rate:
`arecord -Dhw:2 -fS16_LE -r44100 -c2 --nonblock --test-nowait -d5 >
s16le-44100-c2-nonblock-nowait.wav`
https://drive.google.com/open?id=0B-1aumGKQcQTZFNmTGt5VXJKQTg

I also can get it to reproduce using --mmap flag:
`arecord -Dhw:2 -fS16_LE -r48000 -c2 --nonblock --test-nowait --mmap -d5 >
s16le-c2-mmap-nonblock-nowait.wav`
https://drive.google.com/open?id=0B-1aumGKQcQTWDZ6cFlSZjA5ek0

Let me know how I can help further debug. :)

Thanks,
- Trent Reed


> >
> > Thanks,
> > - Trent Reed
> >
> > On Mon, Jul 4, 2016 at 11:52 PM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > On Sat, 02 Jul 2016 23:58:28 +0200,
> > > Trent Reed wrote:
> > > >
> > > > (Ping)
> > > >
> > > > I'm afraid I still don't understand why this is failing. I found
> that a
> > > > call to sdn_pcm_wait() when -EAGAIN is returned fixes the problem
> because
> > > > it waits for samples to be ready, but I don't understand why it is a
> > > > problem in the first place. Much of the sample code is written in a
> way
> > > > that suggests that the call to snd_pcm_wait() is optional, and only
> > > > required when directly reading/writing from the device (MMAP, I'm not
> > > doing
> > > > this).
> > > >
> > > > I'm just wondering what is wrong with basically looping over a call
> to
> > > > snd_pcm_readi() in non-blocking mode, reacting to errors, and
> capturing
> > > > frames. This produces awful static (which is basically garbage
> samples),
> > > is
> > > > it a requirement that I call snd_pcm_wait() when -EAGAIN is passed
> back
> > > to
> > > > wait for a full period to be ready?
> > >
> > > Well, in the API level, it should work as you expected.  So there must
> > > be definitely some bug(s).  But it's hard to spot out, as there are
> > > several layers behind the scene.
> > >
> > > As a first shot, try to reproduce without alsa-lib plugins, i.e. only
> > > with "hw" PCM device, if not done yet.  Also, it's interesting to see
> > > whether it happens with or without mmap r/w.
> > >
> > > Another point is whether it depends on the parameter.  Did you try
> > > 48kHz instead of 44.1kHz?
> > >
> > >
> > > Takashi
> > >
> > >
> > > >
> > > > Thanks,
> > > > - Trent Reed
> > > >
> > > >
> > > > On Tue, Jun 28, 2016 at 7:27 PM, Trent Reed <treed0803@gmail.com>
> wrote:
> > > >
> > > > > Hey All,
> > > > >
> > > > > I've been banging my head against the wall for about a week on this
> > > bug.
> > > > > The following gist shows my sample reproduction code:
> > > > > https://gist.github.com/TReed0803/985c5d5c3d295245e19006a27be447c3
> > > > >
> > > > > I'm simply opening up a non-blocking PCM capture stream and
> writing the
> > > > > contents of the reads to stdout.
> > > > > (Originally, I was writing to the playback stream, but I was
> hearing
> > > this
> > > > > strange static occasionally!)
> > > > >
> > > > > It's the static I'm trying to debug. It doesn't happen every time.
> In
> > > > > fact, sometimes I'll go a few consecutive executions without
> hearing
> > > it.
> > > > > I was able to capture some of the bad data, and I loaded it up in
> > > Audacity
> > > > > for visualization:
> > > > >
> > > > >
> > >
> https://drive.google.com/file/d/0B-1aumGKQcQTcUJoZzIwRWhYSFE/view?usp=sharing
> > > > >
> > > > > It looks like the internal buffer occasionally is sending me more
> data
> > > > > than it actually captured, and I end up either reading old PCM data
> > > from
> > > > > the internal ring buffer, or (at the very beginning) a bunch of
> zeros.
> > > > >
> > > > > Can anyone help me understand what is going on? What could cause
> these
> > > > > definitely incorrect samples to be recorded? (I get the same effect
> > > > > regardless of hardware, but I will list hardware just in case.)
> > > > >
> > > > > I hope I have all the information you might need:
> > > > > Hardware: Samson Meteor Mic (USB-Audio, USB Mixer) [Though, it even
> > > > > happens with my built-in microphone]
> > > > > ALSA version: Advanced Linux Sound Architecture Driver Version
> > > > > k4.4.0-28-generic.
> > > > > apt-cache policy (installed alsa-lib version): 1.1.0-0ubuntu1
> > > > >
> > > > > Thanks,
> > > > > - Trent Reed
> > > > >
> > > > _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@alsa-project.org
> > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > >
>
