From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: EWX 24/96 and SPDIF: solved? (with patch)
Date: Tue, 30 Sep 2003 13:45:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309301329340.1362@pnote.perex-int.cz>
References: <5.1.0.14.1.20030930091950.037fac38@pop3.infotecna.lcl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.1.20030930091950.037fac38@pop3.infotecna.lcl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Denis Sbragion <d.sbragion@infotecna.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 30 Sep 2003, Denis Sbragion wrote:

> Hello Jaroslav and Takashi,
>
> may be I finally nailed down the SPDIF problem with the TerraTec EWX 24/96.
> The problem is caused by the execution of a second CS8427 reset in the
> snd_cs8427_iec958_pcm() function in the cs8427.c file, exactly in the
> following lines of code:
>
> ...
> reset = chip->rate != rate;
> snd_i2c_unlock(cs8427->bus);
> if (reset)
> 	snd_cs8427_reset(cs8427);
> ...
>
> Anyway, I think the problem arise elsewhere, within the ice1712.c file, in
> the snd_ice1712_playback_pro_hw_params(), where there are the following
> lines of code:
>
> ...
> if (ice->spdif.ops.setup_rate)
> 	ice->spdif.ops.setup_rate(ice, params_rate(hw_params));
> ...

I moved these two lines to snd_ice1712_set_pro_rate() function.

> where the spdif rate is changed without checking if the rate is locked or
> not, i.e. without verifying if the is_pro_rate_locked() function returns
> true. Attached to this e-mail there's the obvious patch for this problem,
> changing the previous line into:
>
> ...
> if (ice->spdif.ops.setup_rate && !is_pro_rate_locked(ice))
> 	ice->spdif.ops.setup_rate(ice, params_rate(hw_params));
> ...
>
> With this patch my EWX works flawless with ALSA 0.9.7, anyway I can't check
> if it is going to cause problems with other ICE1712 based soundcards. I
> hope this change is the right one, and not something that makes just my
> soundcard work.

But I think that we still need to investigate why the second reset of
the CS8427 chip failed.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
