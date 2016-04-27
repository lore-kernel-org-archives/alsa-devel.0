From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] ASoC: pcm: allow changing the
 playback/capture rates for symmetric links
Date: Wed, 27 Apr 2016 22:45:48 +0200
Message-ID: <122ca84a-230e-654e-425f-3adb0ca00ec7@axentia.se>
References: <1461746959-11443-1-git-send-email-peda@axentia.se>
 <20160427161504.GZ3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0125.outbound.protection.outlook.com [157.55.234.125])
 by alsa0.perex.cz (Postfix) with ESMTP id EB9C1264FFF
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 22:45:57 +0200 (CEST)
In-Reply-To: <20160427161504.GZ3217@sirena.org.uk>
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

On 2016-04-27 18:15, Mark Brown wrote:
> On Wed, Apr 27, 2016 at 10:49:19AM +0200, Peter Rosin wrote:
>
>> The below program fails on a dai link with symmetric rates without this
>> patch. The patch makes it work.
>
> You've not articulated the problem you're trying to fix here, what in
> concrete terms is the program trying to accomplish and why should it
> succeed?

It is opening an OSS fd, and setting some parameters, but changing
the speed fails (in this case, since the codec dai has .symmetric_rates).
As far as I know this is how you specify a specific speed when using
OSS and it is simply not possibly when one of the involved dais is
symmetric in any way. Which is silly since there is only one stream,
so symmetry should not be an issue.

>>     if ((fd = open("/dev/dsp", O_WRONLY, 0)) == -1) {
>>             perror("open");
>>             return 1;
>>     }
>
> This is using the OSS interfaces which really haven't ever been
> especially supported for ASoC.

Apparently, how should I know?

>> +    if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +        if (!cpu_dai->capture_active)
>> +            return 0;
>> +    } else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
>> +        if (!cpu_dai->playback_active)
>> +            return 0;
>> +    }
>> +
>>      rate = params_rate(params);
>>      channels = params_channels(params);
>>      sample_bits = snd_pcm_format_physical_width(params_format(params));
>
> This means we've opened up a race where the stream is configured but not
> started where the opposite direction can configure a different setup.
> Since starting both directions very close together is a common operation
> it seems likely to cause issues.

Ouch, that's no good. Scrap the patch.

I haven't looked really closely at the userspace side of this, but the
big picture is that we're using a (closed source) library that in its
documentation has an example where they open /dev/dsp like this and
feeds the fd to the lib. We are simply replicating that in our code.
I don't know if the library does anything OSSy with the fd, or if it
would be equally happy with an ALSA fd.

I'll investigate that...

Cheers,
Peter
