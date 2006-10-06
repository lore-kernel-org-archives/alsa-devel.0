From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [alsa-cvslog] alsa-lib: fix various warnings
Date: Fri, 6 Oct 2006 15:23:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0610061522480.8573@tm8103.perex-int.cz>
References: <ALOGGER1160133519.3@alsa-project.org>
	<s5h1wpltwmw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h1wpltwmw.wl%tiwai@suse.de>
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

On Fri, 6 Oct 2006, Takashi Iwai wrote:

> (snip)
> > diff -r 603411fd0c77712cab43cdd5afcf0ff4ebe51a7f -r 1de4320f21cc1bd5d4fdcf0aa9f022c66954547c src/control/control_ext.c
> > --- a/src/control/control_ext.c	Fri Oct 06 11:01:40 2006 +0200
> > +++ b/src/control/control_ext.c	Fri Oct 06 13:18:34 2006 +0200
> > @@ -142,9 +142,9 @@ static int snd_ctl_ext_elem_info(snd_ctl
> >  		{
> >  			int64_t xmin, xmax, xstep;
> >  			ret = ext->callback->get_integer64_info(ext, key,
> > -								&xmin,
> > -								&xmax,
> > -								&xstep);
> > +								(int64_t *)&xmin,
> > +								(int64_t *)&xmax,
> > +								(int64_t *)&xstep);
> >  			info->value.integer64.min = xmin;
> >  			info->value.integer64.max = xmax;
> >  			info->value.integer64.step = xstep;
> 
> This change is nonsense.  The relevant warnings were already fixed.

Yes, you're right. My brain was in another dimension :-) Reverted.

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
