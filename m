From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH, RFC] remove dead code an exports from alsa
Date: Mon, 25 Oct 2004 11:39:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041025093907.GB2798@stusta.de>
References: <20041024133813.GA20174@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id A07582E4
	for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2004 11:39:38 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20041024133813.GA20174@lst.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christoph Hellwig <hch@lst.de>
Cc: perex@suse.cz, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, Oct 24, 2004 at 03:38:13PM +0200, Christoph Hellwig wrote:
>...
> --- 1.37/sound/core/info.c	2004-08-15 11:03:10 +02:00
> +++ edited/sound/core/info.c	2004-10-23 15:58:41 +02:00
> @@ -126,12 +126,19 @@
>  	de->owner = THIS_MODULE;
>  }
>  
> +#ifdef CONFIG_PROC_FS
>  void snd_remove_proc_entry(struct proc_dir_entry *parent,
>  			   struct proc_dir_entry *de)
>  {
>  	if (de)
>  		remove_proc_entry(de->name, parent);
>  }
> +#else
> +static inline void snd_remove_proc_entry(struct proc_dir_entry *parent,
> +					 struct proc_dir_entry *de)
> +{
> +}
> +#endif
>  
>...

remove_proc_entry is a noop for CONFIG_PROC_FS=n, so this part shouldn't 
make any difference.

cu
Adrian

- -- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBfMm7mfzqmE8StAARAlo+AJ9tGNSeFVaeQmUUX3ScL2Gapb7fIACfSt/i
XMrRZdJQ5Zmus4TLZ040/ME=
=vHLN
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
