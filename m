From: Thomas Klausner <tk@giga.or.at>
Subject: Re: Remaining compatibility patches for NetBSD
Date: Thu, 3 Mar 2016 15:23:17 +0100
Message-ID: <20160303142317.GF26041@danbala.tuwien.ac.at>
References: <20160303101005.GI8492@danbala.tuwien.ac.at>
 <s5hpovbrhf2.wl-tiwai@suse.de>
 <20160303111840.GJ8492@danbala.tuwien.ac.at>
 <s5hsi076bd6.wl-tiwai@suse.de>
 <20160303113921.GK8492@danbala.tuwien.ac.at>
 <20160303120242.GL8492@danbala.tuwien.ac.at>
 <s5hlh5z65x1.wl-tiwai@suse.de>
 <20160303134641.GB26041@danbala.tuwien.ac.at>
 <sfid-H20160303-145421-+070.75-1@spamfilter.osbf.lua>
 <s5hfuw7651a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from danbala.ifoer.tuwien.ac.at (danbala.ifoer.tuwien.ac.at
 [128.130.168.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 440AA2666A3
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 15:23:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfuw7651a.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 03, 2016 at 02:54:09PM +0100, Takashi Iwai wrote:
> On Thu, 03 Mar 2016 14:46:41 +0100,
> Thomas Klausner wrote:
> > 
> > On Thu, Mar 03, 2016 at 02:35:06PM +0100, Takashi Iwai wrote:
> > > On Thu, 03 Mar 2016 13:02:42 +0100,
> > > Thomas Klausner wrote:
> > > > 
> > > > Here are the remaining patches to make the build succeed on NetBSD.
> > > > More patches are needed for FreeBSD and Solaris, but let's take it one
> > > > at a time :-)
> > > > 
> > > > I think the first two (0002 and 0003) should be uncontroversial.
> > > > 
> > > > For patch 0004 it would perhaps be good to have versionsort/alphasort
> > > > in a central place instead of two. Do you have a suggestion where?
> > > > 
> > > > I'm not sure what to do about 0005 since you said you don't want to
> > > > modify include/sound/asound.h.
> > > 
> > > Right.  If we need to modify, it must be applied to Linux kernel tree
> > > at first, then copy back to alsa-lib.
> > 
> > I haven't done this before.
> > 
> > I see on https://www.kernel.org/doc/linux/MAINTAINERS
> > 
> > SOUND
> > M:	Jaroslav Kysela <perex@perex.cz>
> > M:	Takashi Iwai <tiwai@suse.com>
> > L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> > W:	http://www.alsa-project.org/
> > T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> > T:	git git://git.alsa-project.org/alsa-kernel.git
> > Q:	http://patchwork.kernel.org/project/alsa-devel/list/
> > S:	Maintained
> > F:	Documentation/sound/
> > F:	include/sound/
> > F:	include/uapi/sound/
> > F:	sound/
> > 
> > Against which of the two git trees should I prepare the patch?
> 
> Use my sound git tree.

Ok, I've just sent a patch against that repository to this mailing list.
 Thomas
