From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsaplayer and jackd faild on snd_pcm_hw_params_set_period_size(...)
 call
Date: Mon, 12 Aug 2002 08:43:07 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208120841330.771-100000@pnote.perex-int.cz>
References: <3D5692AB.80303@cucumelo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D5692AB.80303@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 11 Aug 2002, Benny Sjostrand wrote:

> Hi!
> 
> Trying some native ALSA applications I got some problems,  "alsaplayer" 
> and the "jackd" both seems to fail
> on the same call: snd_pcm_hw_params_set_period_size(...) in alsa-lib
>  
> the jackd:
> [gorm@cactus alsa-driver]$ jackd -d alsa -p 1024 -d pcm.cs46xx
> jackd 0.34.0
> Copyright 2001-2002 Paul Davis and others.
> jackd comes with ABSOLUTELY NO WARRANTY
> This is free software, and you are welcome to redistribute it
> under certain conditions; see the file COPYING for details
> 
> creating alsa driver ... pcm.cs46xx|1024|2|48000|swmon
> ALSA: cannot set period size to 1024 frames for capture
> ALSA: cannot configure capture channel

Use 512 frames for period size. The period size is hardwired in the 
driver. Maybe, your firmware changes allow different period sizes. If it's 
true, it would be nice to change the driver code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
