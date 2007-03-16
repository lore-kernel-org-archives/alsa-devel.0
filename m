From: Ciaccia <ciacciax@yahoo.com>
Subject: Re: Static build of alsa-lib
Date: Fri, 16 Mar 2007 08:11:20 -0700 (PDT)
Message-ID: <393830.60990.qm@web31012.mail.mud.yahoo.com>
References: <s5hzm6duuzw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hzm6duuzw.wl%tiwai@suse.de>
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

Hi Takashi,
Thanks for the answer. To I need both the patches or
just the first one? Which alsa-lib release should I
use with the patch, 1.0.13?

PS: sorry, what is the HG tree?

--- Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 16 Mar 2007 15:18:04 +0100,
> I wrote:
> > 
> > At Fri, 16 Mar 2007 06:17:00 -0700 (PDT),
> > Ciaccia wrote:
> > > 
> > > Hi there,
> > > I would like to compile an alsa application for
> an
> > > embedded system with no shared-libraries
> support. My
> > > application just needs PCM, with no plug-ins, no
> mixer
> > > and no midi and the application should be a
> standalone
> > > executable with no external dependencies,
> otherwise it
> > > will not work.
> > > 
> > > I tried to compile alsa-lib with static support,
> but
> > > without luck (-ldl is always needed in the gcc
> line
> > > and gcc always prints some weird warnings).
> Since I
> > > don't need external plugins nor ladspa, I think
> there
> > > should be a way to compile an application in a
> 100%
> > > static manner, but I still have to figure out
> how.
> > > 
> > > I also found this thread with a similar problem
> with
> > > uClinux
> > >
>
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg18253.html
> > > but at the end I did not understand how/if the
> problem
> > > was solved.
> > > 
> > > Do you think it should be possible to compile
> alsa-lib
> > > with no dependencies on dl? How?
> > > 
> > > Otherwise, would it be possible to write an alsa
> > > application that does not rely on alsa-lib
> (i.e.,
> > > by using the alsa kernel APIs directly)? Has
> someone
> > > already tried it? Some hints?
> > > 
> > > Every hint is extremely welcome
> > 
> > I worked on this sometime ago, and made a patch to
> build alsa-lib
> > without pthread and libdl.  I don't remember why
> this wasn't applied.
> > IIRC, ulibc has the wrappers for pthread and
> libdl, so this wasn't
> > needed at that time in the end.
> > 
> > Otherwise, it should work.  Build with
> --enable-static
> > --disable-shared, --disble-mixer, --disable-hwdep,
> etc.
> 
> ... oh, not perfectly if really no pcm plugin is
> used.
> The patch below fixes the build problem.  Already
> applied to HG tree.
> 
> 
> Takashi
> 
> diff -r f1203eb7eb48 configure.in
> --- a/configure.in	Tue Mar 13 10:44:28 2007 +0100
> +++ b/configure.in	Fri Mar 16 15:18:21 2007 +0100
> @@ -371,6 +371,7 @@ fi
>  
>  dnl Create PCM plugin symbol list for static
> library
>  rm -f "$srcdir"/src/pcm/pcm_symbols_list.c
> +touch "$srcdir"/src/pcm/pcm_symbols_list.c
>  for t in $PCM_PLUGIN_LIST; do
>    if eval test \$build_pcm_$t = yes; then
>      echo \&_snd_module_pcm_$t, >>
> "$srcdir"/src/pcm/pcm_symbols_list.c
> 



 
____________________________________________________________________________________
Don't get soaked.  Take a quick peek at the forecast
with the Yahoo! Search weather shortcut.
http://tools.search.yahoo.com/shortcuts/#loc_weather

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
