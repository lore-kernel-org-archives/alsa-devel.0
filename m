From: Sundaranathan S <snathan@siptech.co.in>
Subject: Re: Regarding global.h
Date: Mon, 23 Jun 2003 14:04:36 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF74F44.6000E751@siptech.co.in>
References: <Pine.LNX.4.44.0306230949440.1838-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hummingbird.siptech.co.in ([202.54.64.122])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA06263
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2003 10:23:50 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

thanks .... I will try that and let you know ....

thanks,
-Sundaranathan
SIP Technologies & Exports Ltd

Jaroslav Kysela wrote:

> On Mon, 23 Jun 2003, Sundaranathan S wrote:
>
> > Hi All,
> >
> >         While compiling ALSA libraries i am getting an error which is
> > stated below
> >
> >                     control.c: In function `snd_ctl_open_conf':
> >                     control.c:581: `_dlsym_control_001' undeclared
> > (first use in this function)
> >                     control.c:581: (Each undeclared identifier is
> > reported only once
>
> Could you try this patch?
>
> Index: global.h
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-lib/include/global.h,v
> retrieving revision 1.19
> diff -u -r1.19 global.h
> --- global.h    23 Apr 2003 12:41:55 -0000      1.19
> +++ global.h    23 Jun 2003 07:50:24 -0000
> @@ -84,6 +84,11 @@
>
>  #endif
>
> +#ifndef __STRING
> +/** \brief Return 'x' argument as string */
> +#define __STRING(x)     #x
> +#endif
> +
>  /** \brief Returns the version of a dynamic symbol as a string. */
>  #define SND_DLSYM_VERSION(version) __STRING(version)
>
>
>                                                 Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: INetU
> Attention Web Developers & Consultants: Become An INetU Hosting Partner.
> Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
> INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
