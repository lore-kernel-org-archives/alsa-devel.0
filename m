From: jhall@UU.NET (Jeremy Hall)
Subject: Re: snd_pcm_format_value() patch in pcm.c
Date: Sun, 3 Mar 2002 01:15:45 -0500 (EST)
Message-ID: <QQmenx17454.200203030615@neserve0.corp.us.uu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.30.0203030028390.2434-100000@gwyn.tux.org> from Samuel
 S Chessman at "Mar 3, 2002 00:42:46 am"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Samuel S Chessman <chessman@tux.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

You might try signed instead of unsigned.

_J

In the new year, Samuel S Chessman wrote:
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
> 
> Now I get the following error:
> ALSA lib pcm_params.c:2020:(snd_pcm_hw_refine_slave) Slave PCM not useable
> 
> Any ideas?
> 
> The following patch is against yesterdays cvs.
> --- /u01/alsa/alsa-cvs/alsa-lib/src/pcm/pcm.c   Fri Feb 22 21:03:18 2002
> +++ src/pcm/pcm.c       Sun Mar  3 00:07:26 2002
> @@ -1299,8 +1299,8 @@
>  {
>         snd_pcm_format_t format;
>         for (format = 0; format <= SND_PCM_FORMAT_LAST; format++) {
> -               if (snd_pcm_format_names[format] &&
> -                   strcasecmp(name, snd_pcm_format_names[format]) == 0) {
> +               if (snd_pcm_format_descriptions[format] &&
> +                   strcasecmp(name, snd_pcm_format_descriptions[format]) == 0) {
>                         return format;
>                 }
>         }
> @@ -5501,7 +5501,7 @@
>                                 }
>                                 f = snd_pcm_format_value(str);
>                                 if (f == SND_PCM_FORMAT_UNKNOWN) {
> -                                       SNDERR("unknown format");
> +                                       SNDERR("unknown format %s",str);
>                                         err = -EINVAL;
>                                         goto _err;
>                                 }
> 
> 
> -- 
>    Sam Chessman                                               chessman@tux.org
>     First do what's necessary, then what's possible, finally the impossible.
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
