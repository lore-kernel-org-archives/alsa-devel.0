From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.16-rcX - no more sound with ALSA snd-hda-intel / Sigmatel
Date: Sat, 18 Mar 2006 15:36:38 +0100
Message-ID: <20060318143637.GB7471@stusta.de>
References: <441C13C1.7000902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <441C13C1.7000902@web.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marcus Hartig <m.f.h@web.de>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 18, 2006 at 03:05:53PM +0100, Marcus Hartig wrote:

> Hello!

Hi Marcus!

> Since the 2.6.16.rcX kernel versions I have no more sound with the ALSA 
> snd-hda-intel driver. All modules load without errors, all  channels are 
> unmuted, no errors in any log, but sound is death! :(
> 
> With kernel 2.6.15.6 (ALSA 1.0.10rc3) the sound is working, only that 
> the headphones output is not doing any noise and then the internal 
> speakers are not muted. With mplayer and ALSA sound output the CPU load 
> goes very high and it stutters, with OSS output in mplayer OSS device 
> not more.
> 
> This is an new DELL Inspiron 9400 Dual Core notebook with Sigmatel STAC 
> 92XX C-Major HD Audio.
> 
> lspci:
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
> Definition Audio Controller (rev 01) Subsystem: Dell Unknown device 01cd
> 
> Module options:
> snd_hda_intel position_fix=1 index=0
>...

Does the patch from [1] help?

> Greetings,
> Marcus

cu
Adrian

[1] http://lkml.org/lkml/2006/3/17/279

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
