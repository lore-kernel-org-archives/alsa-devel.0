From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-lib/src Versions,1.29,1.30
Date: Fri, 10 Jun 2005 09:03:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0506100900410.1834@pnote.perex-int.cz>
References: <E1DgQZf-0005jT-6u@sc8-pr-cvs1.sourceforge.net>
 <20050609190523.GA16131@procyon.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050609190523.GA16131@procyon.home>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Takashi Iwai <tiwai@users.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 9 Jun 2005, Sergey Vlasov wrote:

> On Thu, Jun 09, 2005 at 10:12:11AM -0700, Takashi Iwai wrote:
> > --- Versions	3 Jun 2005 13:35:39 -0000	1.29
> > +++ Versions	9 Jun 2005 17:12:09 -0000	1.30
> > @@ -254,4 +254,7 @@
> >      snd_mixer_selem_set_capture_dB_all;
> >      snd_mixer_selem_compare;
> >  
> > +    snd_ctl_ext_create;
> > +    snd_ctl_ext_delete;
> > +
> >  } ALSA_1.0.9;
> 
> This looks wrong - alsa-1.0.9 was released, therefore its ABI is
> fixed, and nothing can be added to the corresponding version.  With
> this change you could link a program which uses snd_ctl_ext_create
> with the new libraries, and the version dependencies will appear to be
> satisfied with the libraries from the 1.0.9 release - but the program
> run with alsa-lib-1.0.9 will fail when it tries to use the new
> symbols.
> 
> New symbols should go into the new version - ALSA_1.0.10, which would
> clearly show that the program which uses these symbols will not work
> with alsa-lib-1.0.9.

Please, look to WHOLE file before complaining.... It is not as is looks 
for the first glance.... The bottom version string specifies PARENT not 
current version.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
