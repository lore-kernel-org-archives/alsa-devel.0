From: Lennart Poettering <mznyfn@0pointer.de>
Subject: snd_pcm_rewind() weirdness
Date: Sun, 20 Apr 2008 01:37:38 +0200
Message-ID: <20080419233738.GA18371@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 506082441C
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Apr 2008 01:37:39 +0200 (CEST)
Content-Disposition: inline
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

Hey!

On ALSA 1.0.16 with the HDA driver I am experiencing some weird things
with snd_pcm_rewind() which I think are the result of a kernel bug,
but I am not sure.

Here's what I do to trigger this:

I play some PCM. Eventually I want to rewrite what I already have
written. I call snd_pcm_hwsync() and then snd_pcm_avail_update() to
determine how "empty" the playback buffer is. I subtract that value
from the total buffer size. The resulting value should be something
resembling the number of frames that I might be able to rewind. I then
subtract enough frames to keep away from the playback pointer far
enough (50ms, the playback buffer is 370ms, period is 185ms).

Now I pass that value to snd_pcm_rewind() and it returns something that
is higher than what I passed in. Which I find quite
surprising. I had expected that the returned value could be equal or
smaller than what I passed in, but never higher! 

So, my interpretation of the API was apparently wrong. It looks like
on HDA the snd_pcm_rewind() parameter is apparently rounded *up* to
the next period boundary (which in this case was equivalent to the
*entire* buffer)?

Of course, rewinding that far immediately caused an XRUN. Which is why
I think rounding up in this cases is a bad idea and the API shouldn't
work this way. Rounding down is OK, rounding up is call for trouble.

To tape over this I added some code to immediately call
snd_pcm_forward() with the difference if I noticed that the device
forwarded more than I requested. This value also got rounded up -- to
twice the period size. So with this backward+forward operation I ended
up at a frame index that is farther ahead than where I originally came
from!

So, what's the expected behaviour of snd_pcm_rewind()? Always round
up? What's the rationale behind this?

If this is not a bug but expected behaviour, could we at least add
something for passing the direction to round to?

What I am working on is the "glitch-free" playback model in PulseAudio
(http://0pointer.de/blog/projects/pulse-glitch-free.html). To do this
I am writing blocks smaller than the period size to the device via the
mmap interface all the time. Given that on HDA _rewind() is apparently
not granular to the frame size, is writing via mmap in small blocks
like that OK?  If it's not, how can I learn about this in advance?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
