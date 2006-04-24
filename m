From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA HG repos
Date: Mon, 24 Apr 2006 11:40:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0604241121320.10174@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0604201437500.10174@tm8103.perex-int.cz>
 <s5hwtdkbdap.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwtdkbdap.wl%tiwai@suse.de>
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

On Thu, 20 Apr 2006, Takashi Iwai wrote:

> While we are here:
> 
> Can we manage the repos for development and stable trees?
> It's fundamental to fix bugs for the current linux rc* kernel
> (2.6.17rc), but at the same time big changes should be evaluated and
> debugged for inclusion to the next kernel (2.6.18).
> 
> So far, we've had one single CVS repo, and the fixes to rc kernel are
> chosen manually.  This tends to delay the push and eventually drop
> some important fixes because of confliction with other changes.
> 
> Hg has no explicit tagged branches in a single repo like git, so we'd
> need two different repos, such as alsa-kernel and alsa-kernel-devel.
> You can clone it to alsa-kernel directory via
> 
> 	% hg clone $alsarepo/alsa-kernel-devel alsa-kernel
> 
> so that cvscompile script (should be renamed?) works as it is.
> 
> Then alsa git is updated from the stable hg, and alsa-current git from
> the devel hg repo, respectively.  Andrew updates his mm tree based on
> alsa-current git, so the changes to devel tree would go to mm, too.

Well, this repo schema does not satisfy patches from outside for GIT tree 
which are out of scope ALSA sources. Also, most of patches does not
conflict with mainstream. I would suggest to do these changes:

1) create alsa-ksync repository which will contains these files:

   stable-list
   current-list
   patches/XXXX.patch
   kpatches/*.patch

2) remove using of Patch-level: tag from comments

The stable and current list will contain links to HG alsa-kernel 
repository like:

# cat stable-list
+4000				# use alsa-kernel HG changeset 4000
+patches/4001.patch		# fixed HG changeset 4001 for stable tree
+kpatches/some-pnp-fix.patch	# not ALSA patch - pnp fix

Comments?

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
