From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: PCM formats for AC97
Date: Sun, 9 Aug 2009 11:48:31 +0100
Message-ID: <20090809104830.GC4773@sirena.org.uk>
References: <9e4733910908081144s27f4b7fes1e22f838a203c3cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BAD492435B
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 12:48:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910908081144s27f4b7fes1e22f838a203c3cf@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 08, 2009 at 02:44:48PM -0400, Jon Smirl wrote:

> I think I have this backwards, the ac97 driver can take 8/16/24/32
> it's the Bestcomm program that doesn't know about anything except 32b.

Remember, you need to consider the I2S driver as well.

> #define SND_SOC_STD_AC97_FMTS (SNDRV_PCM_FMTBIT_S16_LE |\
>                                SNDRV_PCM_FMTBIT_S32_LE |\
>                                SNDRV_PCM_FMTBIT_S32_BE)
> shouldn't this be

> #define SND_SOC_STD_AC97_FMTS (SNDRV_PCM_FMTBIT_S16 |\
>                                SNDRV_PCM_FMTBIT_S32)

> The first form says the AC97 hardware can take both endians, but it
> doesn't take both endians it takes the endian matching the machine it
> is attached to.

No, it can take any endianess - the wire format is fixed.  The layout of
the data in memory is of little interest to the CODEC.  The formats used
will be restricted by the CPU driver, the values there are essentially
functioning as a wildcard match.

> Don't the standard AC97 formats also include 8 and 24b?

They'll include whatever the controller is happy to render down onto the
bus.  That's just the ones that people have needed so far.
