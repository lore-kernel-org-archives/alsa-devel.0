From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: problem ragarding execution of Latency.c
Date: Wed, 30 Apr 2003 09:08:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304300908140.15946-100000@pnote.perex-int.cz>
References: <20030430051917.27750.qmail@webmail28.rediffmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030430051917.27750.qmail@webmail28.rediffmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mahendra sp <mahendra_sp@rediffmail.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "pzad@pobox.sk" <pzad@pobox.sk>, "hall@maoz.com" <hall@maoz.com>, "abramo@alsa-project.org" <abramo@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 30 Apr 2003, mahendra  sp wrote:

> hi ,
> 
>    I am trying to execute the file latency.c , provided by ALSA.MY 
> driver is ES 1938 solo-1. I have source code for the driver.
> 
>   application i want to write is similar to latency.c
> 
>   I want to write application to capture ansd playback.So i want 
> to execute latency.c and see the output. I have include 
> asoundlib.h.
> 
>    The errors it is giving when i give the command
> 
>   gcc -o latency.out latency.c
> 
> "in functio set_hwparams:undefined reference to 
> snd_pcm_hw_params_any
> snd_strerror,snd_pcm_hw_params_set_format..."

cd alsa-lib/test
make latency

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
