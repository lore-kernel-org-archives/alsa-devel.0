From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: problem in executing the application
Date: Fri, 2 May 2003 11:48:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305021147560.4749-100000@pnote.perex-int.cz>
References: <20030502031930.25809.qmail@webmail17.rediffmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030502031930.25809.qmail@webmail17.rediffmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mahendra sp <mahendra_sp@rediffmail.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "pzad@pobox.sk" <pzad@pobox.sk>, "jhall@maoz.com" <jhall@maoz.com>
List-Id: alsa-devel@alsa-project.org

On 2 May 2003, mahendra  sp wrote:

> hi,
> 
>    when i am trying to execute the latency.c , after complilation 
> is over when i try to execute it,it says undefined reference to 
> variuos
> functions such as snd_pcm_hwparams_any,snd_pcm_hwparams_access   
> etc.
> 
>     is there any way to overcome it? i have installed ALSA 1938 
> 0.9.1 version driver. If not, how to change the functions so as to 
> execute the program?

The library must be compiled as first.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
