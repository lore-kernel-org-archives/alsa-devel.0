From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] deprecate (un)register_ioctl32_conversion
Date: Thu, 6 Jan 2005 16:41:16 +0200
Message-ID: <20050106144116.GA25898@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050105144043.GB19434@mellanox.co.il> <20050105144603.GA1419@infradead.org> <20050105150310.GA19758@mellanox.co.il> <20050105133358.16ce6891.akpm@osdl.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262841AbVAFOjl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050105133358.16ce6891.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, ak@suse.de, mingo@elte.hu, rlrevell@joe-job.com, tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, alsa-devel@lists.sourceforge.net, greg@kroah.com
List-Id: alsa-devel@alsa-project.org

Hello!
Quoting r. Andrew Morton (akpm@osdl.org) "Re: [PATCH] deprecate (un)register_ioctl32_conversion":
> >  Christoph, I know you want to remove the inode parameter :)
> > 
> >  Otherwise I think -mm1 has the final version of the replacement.
> 
> I merged Christoph's verion of the patch into -mm.

I see some more problems with this decision.

> 
> 
>  asmlinkage long compat_sys_ioctl(unsigned int fd, unsigned int cmd,
>  				unsigned long arg)
>  {
> -	struct file * filp;
> +	struct file *filp;
>  	int error = -EBADF;
>  	struct ioctl_trans *t;
>  
>  	filp = fget(fd);
> -	if(!filp)
> -		goto out2;
> -
> -	if (!filp->f_op || !filp->f_op->ioctl) {
> -		error = sys_ioctl (fd, cmd, arg);
> +	if (!filp)
>  		goto out;
> +
> +	if (!filp->f_op) {
> +		if (!filp->f_op->ioctl)
> +			goto do_ioctl;
> +	} else if (filp->f_op->compat_ioctl) {
> +		error = filp->f_op->compat_ioctl(filp, cmd, arg);
> +		goto out_fput;
>  	}


Stare at this as I might, I dont understand why does it make sence.
So if filp->f_op is NULL, you are then checking filp->f_op->ioctl?
Looks like an oops to me.

What should be there:

> +	if (!filp->f_op) {
> +		goto do_ioctl;
> +	} else if (filp->f_op->compat_ioctl) {
> +		error = filp->f_op->compat_ioctl(filp, cmd, arg);
> +		goto out_fput;

Look, was this patch even tested?

MST
