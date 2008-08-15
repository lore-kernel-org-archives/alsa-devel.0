From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] found bug, fixed bug,
	cannot tell anyone
Date: Fri, 15 Aug 2008 09:19:59 +0200
Message-ID: <48A52E1F.4060303@keyaccess.nl>
References: <001d01c8fe5e$3e4eed40$0402a8c0@sj4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id F403424497
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Aug 2008 09:19:18 +0200 (CEST)
In-Reply-To: <001d01c8fe5e$3e4eed40$0402a8c0@sj4>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wesley Johnson <johnson2412@usgo.net>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 14-08-08 22:36, Wesley Johnson wrote:

> How do you notify ALSA dev team about a bug that has been in 1.0.16
> and 1.0.17.  ???

Here will do, although the alsa-devel mailing list would've been better 
still. Added to CC.

> Bugtracker will not let me login, nor email an account confirmation. 
> Getting an ALSA home page account seems to have no purpose at all, it
> does not let you do anything.

The homepage is a wiki so it surely does.

> BUG:
> When you try to compile driver for ens1371 by itself the compile will fail.
> The driver for ens1371 has an include of the file for ens1370, but the
> makefule does not have this dependency
> so the ens1370 file is missing.  The dev team is probably always compiling
> for all.
> 
> Diff file that fixes this problem follows.
> 
> *** pci/Makefile.orig Mon Jul 14 02:53:57 2008
> --- pci/Makefile Thu Jul 17 21:25:42 2008
> ***************
> *** 27,34 ****
> --- 27,35 ----
>   atiixp_modem.c: atiixp_modem.patch
> $(SND_TOPDIR)/alsa-kernel/pci/atiixp_modem.c
>   bt87x.c: bt87x.patch $(SND_TOPDIR)/alsa-kernel/pci/bt87x.c
>   cmipci.c: cmipci.patch $(SND_TOPDIR)/alsa-kernel/pci/cmipci.c
>   ens1370.c: ens1370.patch $(SND_TOPDIR)/alsa-kernel/pci/ens1370.c
> + ens1371.c: ens1370.c

I expect this should be a straight copy of the ens1370.c line but never 
use the standalone alsa-driver package. Now that we're on alsa-devel, 
people who do will reply though.

>   fm801.c: fm801.patch $(SND_TOPDIR)/alsa-kernel/pci/fm801.c
>   intel8x0.c: intel8x0.patch $(SND_TOPDIR)/alsa-kernel/pci/intel8x0.c
>   maestro3.c: maestro3.patch $(SND_TOPDIR)/alsa-kernel/pci/maestro3.c
>   via82xx.c: via82xx.patch $(SND_TOPDIR)/alsa-kernel/pci/via82xx.c
> 
> 
> I have been trying for since July 17 to try to send this to ALSA dev team,
> and have been blocked at every attempt
> It is now Aug 13.  If someone knows how to do this, please post a reply.

Well, not to unduly annoy you, and thank you very much for the report 
and the persistence, but basically all Linux development happens on 
mailinglists and the mailinglist information is right there on the 
homepage so, well...

The alsa-devel mailinglist is moderated for non-subscribers; if you did 
email alsa-devel before and just weren't let through the moderation 
queue then please say so because in that case we definitely have a 
problem to fix.

Rene.
