From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: usr/include/linux/soundcard.h warnings for 'make
	headers_check'
Date: Wed, 21 Jan 2009 06:41:38 +0100
Message-ID: <20090121054138.GA26551@uranus.ravnborg.org>
References: <1232465902.3088.31.camel@localhost.localdomain>
	<s5h7i4psepm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 910A1103858
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 06:39:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h7i4psepm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaswinder Singh Rajput <jaswinder@kernel.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 21, 2009 at 01:08:37AM +0100, Takashi Iwai wrote:
> At Tue, 20 Jan 2009 21:08:22 +0530,
> Jaswinder Singh Rajput wrote:
> > 
> > usr/include/linux/soundcard.h is giving following warnings for 'make headers_check':
> >  usr/include/linux/soundcard.h:1047: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1048: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1049: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1050: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1051: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1053: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1055: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1056: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1061: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1062: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1078: extern's make no sense in userspace
> >  usr/include/linux/soundcard.h:1079: extern's make no sense in userspace
> > 
> > Do we need to fix these warnings.
> 
> No, these are declarations for OSS-lib.
> It doesn't belong to kernel, but it's better to keep it for
> compatibility in some way.

But not in the kernel for sure.
I just checked and for example: OSS_init is not used anywhere in the kernel.
The kernel headers are not a "dump all your stuff" ground anymore.

So I encourage you to find a better home for the user space library definitons.
We can let the definiton stay for a while - but eventually they have to
be dropped from the kernel.

	Sam
