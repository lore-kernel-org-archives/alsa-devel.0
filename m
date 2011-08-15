From: Joerg-Cyril.Hoehle@t-systems.com
Subject: How to pair Wine with ALSA? part1: intro & underruns
	(long)
Date: Mon, 15 Aug 2011 17:50:20 +0200
Message-ID: <8E4C156DA5797D418DBFADFD8CE655A41392BAD314@HE113481.emea1.cds.t-internal.com>
References: <8E4C156DA5797D418DBFADFD8CE655A4138FB471F5@HE113481.emea1.cds.t-internal.com>
	<4E47BE17.1000205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tcmail73.telekom.de (tcmail73.telekom.de [217.243.239.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C90224693
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 17:50:29 +0200 (CEST)
In-Reply-To: <4E47BE17.1000205@ladisch.de>
Content-Language: de-DE
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
Cc: clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

[I've moved some blocking/polling from part2 herein.]

Clemens Ladisch wrote:
> > [...]  GetPosition returns "the stream position of the sample that
> > is currently playing through the speakers".
>However, does that documentation actually make a distinction between the
>last sample that has been read from the buffer and the sample being played?

Er, what do you mean?

My interpretation is: if there's a 5s network latency, that is
included.  The front-end of the audio-processing chain may have
returned the buffer (as visible from GetCurrentPadding) containing
that sample already 3 seconds ago to the app, that doesn't matter.

GetCurrentPadding: font-end view on audio processing chain
GetPosition: back-end (speaker) view


>I would be tempted to just ignore the exclusive/share flag.
The flag is MS' view on it.  I never would think about using O_EXCL on
the host OS side.

BTW, I thought dmix could be used with any card, but I found no
one-liner syntax to open card 1 with dmix.  It seemed hard-wired (by
configuration) to card0 (not that I'm familiar with ALSA conf syntax).

I'd expect to be able to tell the (hypothetical) 5:1 player on card1:
"use dmix-style functionality too, don't grab plughw:1".


>There is no guarantee about the actual output resulting from those
>'missed' samples.  You can set silence_threshold/size to force silence.
Then I must use it.  I don't want the user to hear random noise
(or stuttering or similar effects).


>Configuring the device to stop on xruns seems to be a better fit for
>your requirements.
That's what Wine used to do in the former driver.

But it's precisely because dmix does(did?) not support xrun detection
that I started looking into the free-running mode.

I currently believe that I can support both simultaneously (i.e. not care):

- xrun stops: As long as snd_pcm_avail_update and snd_pcm_delay
  continue to be updated (my tests tell me they do), I know by how
  many samples to correct results.

- free-running: Here too, snd_pcm_avail_update and delay continue to
  be updated, so I know both:
  a) how many samples to skip when there'll be something to play again,
  b) how many samples not to include in what GetPosition must return.


>The meaning of ALSA's periods is as follows:
>2) When ALSA is blocked (in snd_pcm_write* or in poll), it checks
>    whether to wake up the application only when an interrupt arrives.

What about non-blocking mode?  Do you mean to imply that in
non-blocking mode, never using poll() causes period_size to become
irrelevant from the app POV?  ALSA may update its internal state upon
every interrupt, but the app never observes an interrupt, does it?


>Non-blocking mode is perfectly fine if you're using poll() to wait for
>other events at the same time.

AFAICT Wine never used poll() with ALSA.  It was in the code only to
communicate via pipe() with the rest of the Wine driver.  The new
driver doesn't use poll at all.  It uses a fixed rate timer signal.
Is that against any recommendations?  What's bad about it?

That's not ideal in terms of CPU interrupt frequency, nor latency.
However those 10ms packets observable in mmdevapi make it IMHO
unlikely that a fixed 10ms timer is wrong now in Wine.  It is my
conviction that Wine must mimic dynamic (timing) behaviour to avoid
triggering bugs in apps.
We'll see.

Regards,
	J=F6rg H=F6hle
