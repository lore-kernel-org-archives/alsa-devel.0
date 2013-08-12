From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add
	DAPM	links between codec and cpu DAI
Date: Mon, 12 Aug 2013 09:28:37 +0100
Message-ID: <20130812082837.GB23006@n2100.arm.linux.org.uk>
References: <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
 <20130805145644.GV23006@n2100.arm.linux.org.uk>
 <20130805203202.GX23006@n2100.arm.linux.org.uk>
 <20130805220639.GB26637@sirena.org.uk>
 <20130805233015.GY23006@n2100.arm.linux.org.uk>
 <20130806133206.GA6427@sirena.org.uk>
 <20130810161123.GW23006@n2100.arm.linux.org.uk>
 <20130810211342.GX23006@n2100.arm.linux.org.uk>
 <1376293215.2385.32.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 894E2260307
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 10:28:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1376293215.2385.32.camel@loki>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 12, 2013 at 08:40:15AM +0100, Liam Girdwood wrote:
> Russell, I'm just back from holiday now and have done a quick re test on
> Haswell. I can see the correct DAPM path and DPCM state as expected for
> Haswell, but let me get through my Inbox today and I'll see where we
> have some differences tomorrow.

Liam, welcome back.

Looking at this last night, I notice this:

 * Creates a new internal PCM instance with no userspace device or procfs
 * entries. This is used by ASoC Back End PCMs in order to create a PCM that
 * will only be used internally by kernel drivers. i.e. it cannot be opened
 * by userspace. It provides existing ASoC components drivers with a substream
 * and access to any private data.
 *
 * The pcm operators have to be set afterwards to the new instance
 * via snd_pcm_set_ops().

Note the final paragraph.  So, soc-pcm.c does this:

        /* create the PCM */
        if (rtd->dai_link->no_pcm) {
                snprintf(new_name, sizeof(new_name), "(%s)",
                        rtd->dai_link->stream_name);

                ret = snd_pcm_new_internal(rtd->card->snd_card, new_name, num,
                                playback, capture, &pcm);
        } else {
...
        if (rtd->dai_link->no_pcm) {
                if (playback)
                        pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->private_data = rtd;
                if (capture)
                        pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream->private_data = rtd;
                goto out;
        }
...
        if (playback)
                snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &rtd->ops);

        if (capture)
                snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &rtd->ops);
...
out:
        dev_info(rtd->card->dev, " %s <-> %s mapping ok\n", codec_dai->name,
                cpu_dai->name);
        return ret;

Hence, soc-pcm.c never sets the ops for the 'internal' stream, which,
because it uses the dummy DAI, has both a playback and a capture
stream.

The above is the only place where the ops are set on the ALSA stream(s)
by ASoC, which means there's no way that the internal streams can ever
have a non-NULL ops pointer, and suggests a possible reason why I get
this oops.
