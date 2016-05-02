From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] ASoC: pcm: allow changing the
 playback/capture rates for symmetric links
Date: Mon, 2 May 2016 09:43:53 +0200
Message-ID: <c7193097-f216-df7d-2f94-bd5f6684c28b@axentia.se>
References: <1461746959-11443-1-git-send-email-peda@axentia.se>
 <20160427161504.GZ3217@sirena.org.uk>
 <122ca84a-230e-654e-425f-3adb0ca00ec7@axentia.se>
 <20160428103822.GJ3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1on0137.outbound.protection.outlook.com [157.56.112.137])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DD9826040E
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 09:44:00 +0200 (CEST)
In-Reply-To: <20160428103822.GJ3217@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 2016-04-28 12:38, Mark Brown wrote:
> On Wed, Apr 27, 2016 at 10:45:48PM +0200, Peter Rosin wrote:
>> I haven't looked really closely at the userspace side of this, but the
>> big picture is that we're using a (closed source) library that in its
>> documentation has an example where they open /dev/dsp like this and
>> feeds the fd to the lib. We are simply replicating that in our code.
>> I don't know if the library does anything OSSy with the fd, or if it
>> would be equally happy with an ALSA fd.
> 
> If it's using OSS it's unlikely to work with ALSA, the two ABIs are
> completely different.  You need to talk to your proprietary software
> vendor about updating their software.  There are also some userspace
> utilities that try to do the remapping by wrapping things there but I
> can't remember the names off the top of my head, it's been a long time.

Ok, I managed to hook it up with ALSA instead but am now bitten by
a completely different problem.

The code now does this (error checks elided, there are no errors
reported in the real code which does check for errors):

snd_pcm_open(&pcm, "default", SND_PCM_STREAM_PLAYBACK, 0);
snd_pcm_set_params(pcm,
	SND_PCM_FORMAT_S16_LE,
	SND_PCM_ACCESS_RW_INTERLEAVED,
	2, 22050, 0, 1000000);
while (!end) {
	/* code filling in stereo_buf elided */
	snd_pcm_writei(pcm, stereo_buf, sample_count);
}
snd_pcm_drain(pcm);
snd_pcm_close(pcm);

There is no rate control in this, the code relies on snd_pcm_writei
to block if there is no room. This part appears to work as expected.
sample_count is not constant, but it is mostly 4096 and never bigger
than that.

The problem is in the drain/close part. If I leave out snd_pcm_drain
I naturally lose the tail of the output, but if I have it I get what
I guess is a repeat of the content in some circular buffer. I.e. the
very last part of the played sound is played twice(ice).

If I instead write the generated samples to a file and play them
with aplay, all is fine, so I appear to be misunderstanding the
alsa api?

Anything obviously wrong in the above code?

Cheers,
Peter
