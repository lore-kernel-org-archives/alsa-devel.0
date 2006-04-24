From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA HG repos
Date: Mon, 24 Apr 2006 13:18:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0604241316310.9305@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0604201437500.10174@tm8103.perex-int.cz>
 <s5hwtdkbdap.wl%tiwai@suse.de> <Pine.LNX.4.61.0604241121320.10174@tm8103.perex-int.cz>
 <s5h8xpv443x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8xpv443x.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Apr 2006, Takashi Iwai wrote:

> > # cat stable-list
> > +4000				# use alsa-kernel HG changeset 4000
> > +patches/4001.patch		# fixed HG changeset 4001 for stable tree
> > +kpatches/some-pnp-fix.patch	# not ALSA patch - pnp fix
> > 
> > Comments?
> 
> If we use such things, then better to stick with quilt.

It will be overhead. I'd like to retreive most of patches directly from HG 
and do the on-the-fly conversion for GIT commits. I'm already working on 
this, so we can do some tests and decide later if it's the way to go.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
