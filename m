From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] cs46xx DAC volume's mechanism rewrite,
 minor bugfixes
Date: Sun, 10 Nov 2002 19:45:23 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211101945160.748-100000@pnote.perex-int.cz>
References: <3DCEB5A4.4090600@cucumelo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DCEB5A4.4090600@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 10 Nov 2002, Benny Sjostrand wrote:

> Hi!
> 
> This patch changes the way the DAC volume are set on DSP SCB tasks. I 
> would like to know
> if maybe this fixes the "bass"  problem that some users have experienced 
> with the cs46xx driver.
> 
> Still some more attempts to have AC3 through IEC958, but no success yet ...
> 
> Summary:
> - DAC volume mechanism  rewrite (added cs46xx_dsp_set_dac_volume (...) 
> in dsp_spos.c)
> - IEC958 input volume mechanism rewrite (added 
> cs46xx_dsp_set_iec958_volume (...) in dsp_spos.c)
> - Enable IEC958 hw if not done in cs46xx_iec958_pre_open (...)
> - Added "AC3 Mode Switch" in mixer, when enabled appropiate status
> bit's (non-audio, profesional) are set in IEC958 stream and PCM channel 
> is locked to 48Khz
> - Typo fix in constant name DSP_SDPIF... -> DSP_SPDIF...
> - Some code cleanups

Applied. Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
