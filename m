From: jmal8295 <jmal8295@artax.karlin.mff.cuni.cz>
Subject: Re: [alsa-cvslog] alsa-kernel: Official ALSA project
 GIT repository for Linux 2.6 branch, master now at v2.6.31-rc8-407-gfc9e4a3
Date: Tue, 6 Oct 2009 20:11:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0910061955510.18975@artax.karlin.mff.cuni.cz>
References: <20091006063609.B06E110381F@alsa0.perex.cz>
	<s5hab05role.wl%tiwai@suse.de> <4ACAF4AC.3000608@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from artax.karlin.mff.cuni.cz (artax.karlin.mff.cuni.cz
	[195.113.26.195])
	by alsa0.perex.cz (Postfix) with ESMTP id B9EC6103834
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 20:11:14 +0200 (CEST)
In-Reply-To: <4ACAF4AC.3000608@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Honza Maly <hkmaly@matfyz.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Oct 2009, Clemens Ladisch wrote:
> Takashi Iwai wrote:
> > noreply-git@alsa-project.org wrote:
> > > commit fc9e4a3811567f8d1d4c263a89e27b52c90d6098
> > > Author:     Clemens Ladisch <clemens@ladisch.de>
> > > AuthorDate: Tue Oct 6 08:21:04 2009 +0200
> > > 
> > >     sound: via82xx: move DXS volume controls to PCM interface
> > >     
> > >     The "VIA DXS" controls are actually volume controls that apply to the
> > >     four PCM substreams, so we better indicate this connection by moving the
> > >     controls to the PCM interface.
> > 

By "moving" you mean removing them or will there appear somewhere else?

> > Well, this control was once removed, and then revived due to complains 
> > by users
> 
> one user
> 
> > who have used it in mixer.  Moving this to PCM iface does
> > almost the same thing, disabling an easy way to access it.
> 
> Any application that looks for per-stream volume controls would find
> them only this way.
> 
> Since the assignment of applications to PCM substreams is more or less
> random, depending on how many other substreams are open, it does not
> make much sense to allow the user to access them by their number.
> 
> > I'm afraid that this patch might be regarded as another "regression".
> > For such an old driver, the compatibility is the most important item.
> 
> Honza, are you still using this driver?
> 

Yes I do (there is a different driver for this codec?). And I _will_ be 
regarding it as regression if I lose possibility to change volume of the 
four streams independently.
On the other hand, I do change the volume only manually (not 
automatically by program), so if only thing which changes is the way how 
to modify that volume I would not see problem in that.
	Honza

> 
> Best regards,
> Clemens
> 
