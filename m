From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: [PATCH] au88x0 - do codec init more like windows
 does
Date: Wed, 23 Feb 2005 15:48:14 +0100
Message-ID: <m2mztvmixd.fsf@vador.mandrakesoft.com>
References: <20050223033505.GB6974@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050223033505.GB6974@debian> (Jeff Muizelaar's message of
 "Tue, 22 Feb 2005 22:35:06 -0500")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jeff Muizelaar <jeff@infidigm.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jeff Muizelaar <jeff@infidigm.net> writes:

> The following patch makes the codec init code act more like the
> windows code.
> 
> Signed-off-by: Jeff Muizelaar <jeff@infidigm.net>
> 
> 
> Index: pci/au88x0/au88x0_core.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/pci/au88x0/au88x0_core.c,v
> retrieving revision 1.10
> diff -u -r1.10 au88x0_core.c
> --- pci/au88x0/au88x0_core.c	3 Jan 2005 12:08:24 -0000	1.10
> +++ pci/au88x0/au88x0_core.c	23 Feb 2005 03:30:43 -0000
> @@ -2480,7 +2480,8 @@
>  	int i;
>  
>  	for (i = 0; i < 32; i++) {
> -		hwwrite(vortex->mmio, (VORTEX_CODEC_CHN + (i << 2)), 0);
> +		/* the windows driver writes -i, so we write -i */
> +		hwwrite(vortex->mmio, (VORTEX_CODEC_CHN + (i << 2)), -i);
>  		msleep(2);
>  	}
>  	if (0) {
> @@ -2502,7 +2503,7 @@
>  		hwwrite(vortex->mmio, VORTEX_CODEC_CTRL, 0x00e8);
>  	}
>  	for (i = 0; i < 32; i++) {
> -		hwwrite(vortex->mmio, (VORTEX_CODEC_CHN + (i << 2)), 0);
> +		hwwrite(vortex->mmio, (VORTEX_CODEC_CHN + (i << 2)), -i);
>  		msleep(5);
>  	}
>  	hwwrite(vortex->mmio, VORTEX_CODEC_CTRL, 0xe8);

shouldn't the same comment be added to second occurence too?

aka sg like:
--- pci/au88x0/au88x0_core.c	3 Jan 2005 12:08:24 -0000	1.10
+++ pci/au88x0/au88x0_core.c	23 Feb 2005 03:30:43 -0000
@@ -2502,6 +2503,7 @@
 		hwwrite(vortex->mmio, VORTEX_CODEC_CTRL, 0x00e8);
 	}
 	for (i = 0; i < 32; i++) {
+		/* the windows driver writes -i, so we write -i */
 		hwwrite(vortex->mmio, (VORTEX_CODEC_CHN + (i << 2)), -i);
 		msleep(5);
 	}



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
