From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: WM8804: fsi-wm8804
Date: Mon, 15 Nov 2010 12:33:51 +0000
Message-ID: <20101115123351.GB3338@sirena.org.uk>
References: <4CE126FD.7000407@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DE47103831
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 13:33:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CE126FD.7000407@elproma.com.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grzegorz Daniluk <g.daniluk@elproma.com.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 15, 2010 at 01:26:37PM +0100, Grzegorz Daniluk wrote:

> I'm trying to use the wm8804 codec in my SH4-based system (Renesas 
> SH7724 to be precise). I have used the latest kernel 2.6.37-rc1 where 
> there is the codec driver for wm8804. However, I have to write my own 
> fsi-wm8804.c (like e.g. fsi-da7210.c). My code attached below. After 
> compiling it with the rest of the kernel sources or compiling as an 
> external module my alsa still does not see any soundcards. However, by 
> running i2cdetect I can see that the device is correctly taken by the 
> codec driver so the problem is somewhere with my fsi-wm8804 probably. 

Did you register the I2C device for the CODEC with the I2C subsystem?
If that's not the issue could you please provide a kernel log with
#define DEBUG at the top of soc-core.c?

> static int fsi_wm8804_init(struct snd_soc_codec *codec)
> {
> 
>     return 0;
> }

Remove unused functions.

>     if(substream->stream == SNDRV_PCM_STREAM_CAPTURE)
>     {
>         snd_soc_dai_set_pll(dai, 0, 0, 12000000, 94310400);
>     }
>     else if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>     {
>         snd_soc_dai_set_pll(dai, 0, 0, 12000000, 98304000);
>     }

This is going to prevent simultaneous playback and record; this may not
be an issue in your system but I wanted to be sure you were aware of it.
