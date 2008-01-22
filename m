From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: 1.0.16rc1 release
Date: Tue, 22 Jan 2008 09:56:04 -0800
Message-ID: <1201024564.30379.161.camel@razman.gruemaster.com>
References: <Pine.LNX.4.61.0801221247570.9698@tm8103.perex-int.cz>
	<47961880.3090309@moving-picture.com>	<s5h4pd5954z.wl%tiwai@suse.de>
	<479624A6.7040700@moving-picture.com> <s5hwsq17p64.wl%tiwai@suse.de>
	<47962A63.8020204@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id DAF7D24B87
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 18:59:39 +0100 (CET)
In-Reply-To: <47962A63.8020204@moving-picture.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Pearson <james-p@moving-picture.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

One of the main problems with supporting Redhat kernels is that they
backport functions into their kernels from later revisions.  As an
example, there is a typedef (gfp_t) that in the alsa driver will be used
if the kernel is older than a certain version.  Redhat added it in their
Enterprise 4.4 kernel, but not their 4.3 kernel (both have the same
major rev - 2.6.9).  This makes it difficult at the preparser level, and
I think the way we got around that was in the configure script.  But it
takes extra work to make alsa-driver compile on the various
distributions that do this kind of backporting (fortunately this is
limited to Redhat/Centos at the moment AFAIK), and Alsa doesn't have the
manpower to do all of these fixes.

If someone that works for Redhat or works on Redhat distros wants to
jump in and help, great.

On Tue, 2008-01-22 at 17:39 +0000, James Pearson wrote:

> Takashi Iwai wrote:
> 
> >>
> >>>Or, RH has an uncomplete mutex implementation?
> >>
> >>Don't know - see above?
> > 
> > 
> > Looks like so...  Sigh.
> > 
> > Can someone report RedHat to fix their kernel?
> 
> May be that should be someone that has an interest in sound and has 
> recently started working for RedHat ??
> 
> Is it possible to define mutex_destroy in the ALSA code if it isn't 
> defined elsewhere for this case?
> 
> Thanks
> 
> James Pearson
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis 


The sheep died in the wool.
