From: Glenn Maynard <glenn@zewt.org>
Subject: Re: valgrind and alsa
Date: Thu, 24 Feb 2005 21:57:46 -0500
Message-ID: <20050225025746.GE27159@zewt.org>
References: <421D9482.3090807@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421D9482.3090807@cs.ubc.ca>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 24, 2005 at 12:46:58AM -0800, Charles Buck Krasic wrote:
> Hi,
> 
> I'm new to alsa development.   I have just implemented native alsa 
> support in an application I've developed (a streaming video system).   
> When checking my application with valgrind,  valgrin generates numerous 
> alsa related warnings.   They all seem to originate from a single 
> problem in my initial call to snd_pcm_writei.  Basically valgrind 
> doesn't like that alsa is making an ioctl with unitialized data.  The 
> following patch fixed the problem for me, it's just a one liner add the 
> missing initializtion.
> 
> Cheers,
> 
> -- Buck

> --- pcm_hw.c-old	2005-02-24 00:36:02.906722553 -0800
> +++ pcm_hw.c	2005-02-24 00:35:37.390399025 -0800
> @@ -664,6 +664,7 @@
>  	struct sndrv_xferi xferi;
>  	xferi.buf = (char*) buffer;
>  	xferi.frames = size;
> +	xferi.result = 0;
>  	err = ioctl(fd, SNDRV_PCM_IOCTL_WRITEI_FRAMES, &xferi);
>  	err = err >= 0 ? sync_ptr(hw, SNDRV_PCM_SYNC_PTR_APPL) : -errno;
>  #ifdef DEBUG_RW

I'd guess that the "correct" fix would be to tell Valgrind that this
particular value is a result, so it knows that it's normal for it to
be uninitialized and that it becomes initialized by the ioctl.  (But
there's probably no harm in this, either.)

-- 
Glenn Maynard


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
