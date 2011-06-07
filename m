From: Andre Schramm <andre.schramm@iosono-sound.com>
Subject: Re: Issues with HDSPM
Date: Tue, 7 Jun 2011 18:51:02 +0200
Message-ID: <20110607185102.0bc6ac30@revell.mafea.no-ip.org>
References: <20110606210425.0a4c2901@revell.mafea.no-ip.org>
	<20110607063305.GE17989@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by alsa0.perex.cz (Postfix) with ESMTP id DC2EE2456F
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 18:51:05 +0200 (CEST)
In-Reply-To: <20110607063305.GE17989@ltw.loris.tv>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Jun 2011 08:33:05 +0200
Adrian Knoth <adi@drcomp.erfurt.thur.de> wrote:

> > When switching to a PCI version of the card, the kernel completely
> > crashes on boot.
> 
> We'd need a crash report. Best is to blacklist the kernel module, boot
> the machine and then trying to load the module, maybe on a console.
> 
I will have access to the hardware again on Friday, I'm going to provide
some more details then. I was trying to set up a kdump environment, but
haven't been doing much kernel hacking yet.


> If need be, we can meet and fix the problem on-site, I'm living close
> to your place.
> 
That would be great, we're heavily using the MADI cards. But maybe we
can figure it out online.


> 
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006723.html
> > And with [2], there is another issue which unfortunately hasn't been
> > merged yet and still exists in the current release.
> 
> Could you try this patch? (for your convenience, I've also attached
> it)
> 
Thanks. A colleague of mine found this one and we used to patch it by
hand till now. But it would be great if this would go upstream. :)


Regards,
   Andre
