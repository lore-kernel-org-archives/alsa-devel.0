From: Robert Vetter <vetter@bury.com>
Subject: Re: How to add a new module to the drivers package?
Date: Tue, 1 Aug 2006 15:04:22 +0200
Message-ID: <200608011504.22166.vetter@bury.com>
References: <200608011446.36562.vetter@thb.de> <s5hejw08vjs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hejw08vjs.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



I'm working with alsa-drivers-1.0.2 package, since it builds without problems 
for arm architecture and linux 2.4.19. The newest package (1.0.11) doesn't 
compile in this environment.
Thus, do I have still to use the Kconfig file?

Thank you

Robert


On Tuesday 01 August 2006 14:55, Takashi Iwai wrote:
> At Tue, 1 Aug 2006 14:46:36 +0200,
>
> Robert Vetter wrote:
> > Hi,
> >
> > I'm trying to add a new driver (for example dummy1) module to the drivers
> > package. What i do is:
> >
> > 1. to add the module into scripts/Modules.dep
> >
> > %dir linux/sound/drivers
> >
> > |snd-dummy snd-pcm
> > |snd-dummy1 snd-pcm
>
> Modules.dep is obsoleted (where did you find it?).
> You need to add a corresponding entry in Kconfig file.  The dependency
> should be given in Kconfig (e.g. add a line "select SND_PCM").
>
> > 2. to add the module into linux/sound/drivers/Makefile
> >
> > snd-dummy1-objs := dummy1.o
> > obj-$(CONFIG_SND_DUMMY1) += snd-dummy1.o
>
> Correct.
>
> > 3. to run cvscompile
>
> Or hgcompile script.  If you're using CVS from the old ALSA CVS repo,
> stop it.  CVS is dead.
>
>
> Takashi

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
