From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa-1.0.1 and linux-2.2.25
Date: Wed, 21 Jan 2004 10:33:26 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401211032150.2010@pnote.perex-int.cz>
References: <20040121005347.29ECB4955@marimba.home.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040121005347.29ECB4955@marimba.home.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ted <ted@nowtsfree.freeserve.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Jan 2004, Ted wrote:

> Hello, thanks for including fixes for my previous problems
> loading alsa modules into linux-2.2.25. Unfortunately, a new
> problem appeared in alsa-driver-1.0.1. It compiles happily,
> but will not load:
> 
> /lib/modules/2.2.25/misc/snd-page-alloc.o:
> 	unresolved symbol snd_wrapper_request_region
> 
> I suspect the cause is a recent change to the file
> 	alsa-driver-1.0.1/acore/pci_compat_22.c
> 
> I managed to load the modules by changing acore/pci_compat_22.c:
> 356c356
> <               snd_wrapper_request_region(pci_resource_start(pdev, bar),
> ---
> >               request_region(pci_resource_start(pdev, bar),
> 
> but confess to not fully understand the code, so please check this.

It looks ok, applied.

> Now a longer standing problem. I have not been able to use alsa since
> the alsa-lib API changed, because I still get bad data passed by
> pcm.c:6442		snd_pcm_hw_params_set_period_time_near(),
> to
> pcm.c:3782		__snd_pcm_hw_params_set_period_time_near(),
> on its way to
> pcm_params.c:786	snd_pcm_hw_param_set_near().
>
> I configured alsa-lib with
> ./configure --prefix=/usr --with-versioned=no --with-debug=yes \
                            ^^^^^^^^^^^^^^^^^^^

This was the problem. I've fixed the code in CVS and sent you this patch 
in the separate mail.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
