From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: new rollback commits (was Re: [alsa-cvslog]
 ROLLBACK! alsa-kernel: ac97_codec (ALC655): add EAPD hack for MSI L725
 laptop)
Date: Thu, 5 Oct 2006 14:12:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610051356060.9351@tm8103.perex-int.cz>
References: <ALOGGER1160034648.34@alsa-project.org>
	<m2lknv6pju.fsf@vador.mandriva.com> <s5hpsd7oybr.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0610051305180.9351@tm8103.perex-int.cz>
	<s5hfye3ouhb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 91D9C23C
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Oct 2006 14:12:44 +0200 (MEST)
In-Reply-To: <s5hfye3ouhb.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Thierry Vignaud <tvignaud@mandriva.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 5 Oct 2006, Takashi Iwai wrote:

> At Thu, 5 Oct 2006 13:11:51 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Thu, 5 Oct 2006, Takashi Iwai wrote:
> > 
> > > At Thu, 05 Oct 2006 12:10:45 +0200,
> > > Thierry Vignaud wrote:
> > > > 
> > > > Takashi Iwai <tiwai@suse.de> writes:
> > > > 
> > > > > The rollback was triggered. The repository was rolled back to
> > > > > the changeset number bellow. All patches on top of this changeset
> > > > > were lost.
> > > > > 
> > > > > changeset:   4582:9233e1d82ed045609e1fb76acf00696393589031
> > > > > tag:         tip
> > > > > user:        perex
> > > > > date:        Thu Oct 05 09:30:36 2006 +0200
> > > > > files:       pci/ac97/ac97_patch.c
> > > > > description:
> > > > > ac97_codec (ALC655): add EAPD hack for MSI L725 laptop
> > > > > New PCI ID described and tested Spectr <spectr@gmail.com> .
> > > > 
> > > > I think that:
> > > > - the reason of the rollback should be visible and the mail (aka the
> > > >   rollback commit changelog)
> > > > - the rollback commit changelog) should be in the suject line rather
> > > >   than the changelog of the commit we reverse to, since it's more
> > > >   important
> > > 
> > > The rollback has no log for itself...
> > 
> > Yes, we have no additional information. Anyway, all rollbacks means "wrong 
> > patch". In this case, I figured immediately after commit that mpu401 patch 
> > does not make any sense and it was problem in the driver core code in 
> > mainstream (I already proposed correct patch on LKML).
> 
> Well, then in this case, something went wrong in the retrieval of the
> target changeset.  It should have shown mpu401-stuff instead of this
> AC97 change.

Yes, that would be probably the best solution, but the problem is that 
I've not found a way to determine which changesets will roll back (note 
that the whole last push will be lost, not only last changeset). Also, 
hg does not call any hook on rollback.

I've put a bug number 384 to hg tracker:

http://www.selenic.com/mercurial/bts/issue384

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
