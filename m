From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_format_value() patch in pcm.c
Date: Sun, 3 Mar 2002 08:35:22 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0203030833380.1982-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.30.0203030028390.2434-100000@gwyn.tux.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Samuel S Chessman <chessman@tux.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 3 Mar 2002, Samuel S Chessman wrote:

> I have been trying to get S16_LE format sound out of my ice1712 with
> poor success, and noted the example in
> http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html
> for setting up slaves.  I added a format line to ~/.asoundrc thus:
> 
> pcm.rate44100Hz {
>         type plug
>         slave {
>                 pcm "hw:0,0"
>                 rate 44100
>                 format "Unsigned 16 bit Little Endian"
>         }
> }
> 
> and received a failure;
> ALSA lib pcm.c:5504:(snd_pcm_slave_conf) unknown format
> snd_pcm_open: Invalid argument (rate44100Hz)
> 
> Investigating the code led me to conclude that the snd_pcm_format_value()
> function should be looking up strings in snd_pcm_format_descriptions[]
> where they are defined instead of snd_pcm_format_names[] where they are not.
> It would also be helpful to print out the unknown format with the error.
> 
> Perhaps I misunderstand but there is little documentation on format.

I've added the support for long format description as well. The 
snd_pcm_format_names[] is perfectly ok - try 'U16_LE' or 'S16_LE'.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
