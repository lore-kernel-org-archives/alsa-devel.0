From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: smart and automatic use of dmix and dsnoop - feature
 suggestion.
Date: Mon, 17 Nov 2003 21:05:17 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0311172102250.16992@pnote.perex-int.cz>
References: <200311171936.hAHJaW1B013634@oud.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200311171936.hAHJaW1B013634@oud.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Peter Kirk <pwk.linuxfan@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Nov 2003, Paul Davis wrote:

> >what you say seems to be valid to me, but not if you implement smart dmix the
> >way I said =). The way I suggested *every* application would connect to smart
> >dmix, and none directly to alsa lib (except those that use devices like hw: -
> >and those should never be mixed). Since every stream is connected to smart
> >dmix, there is no need to *reroute* anything in the case of needed mixing.
> >The only thing that has to happen, is that the new stream, that has to be
> >mixed into the existing one due to hardware limitations has to be resampled
> >etc. to make mixing possible.
>
> believe or not, i actually think that peter is right here. if dmix
> works well enough to be used by any application, then i think it
> should be used for all non-hw accesses unless the user configures it
> otherwise. if it doesn't work this well, it should :)

Ok, maybe we all talk about same thing. Sure, if the code is matured
enough, we can use it as default. But I only want to note that dmix
- even with one stream - won't be ever equal to the raw hardware access
(hw:#,#).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
