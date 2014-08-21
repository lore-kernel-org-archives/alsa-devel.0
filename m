From: Ira Malinich <thub@iname.com>
Subject: Re: can't insmod patched snd-usb-audio
Date: Thu, 21 Aug 2014 00:25:54 +0000 (UTC)
Message-ID: <loom.20140821T021531-453@post.gmane.org>
References: <20140809114001.GA7938@x1-orm> <53E75E10.7080805@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D8932651EE
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 02:40:07 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1XKGQ7-00038S-4G
 for alsa-devel@alsa-project.org; Thu, 21 Aug 2014 02:40:03 +0200
Received: from S010600195b2f1709.cg.shawcable.net ([70.72.188.181])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 02:40:03 +0200
Received: from thub by S010600195b2f1709.cg.shawcable.net with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 02:40:03 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack <daniel <at> zonque.org> writes:

> Interesting. Why isn't this patch mainline? Keeping such things
> out-of-tree are likely to cause maintenance overhead in the future, and
> people who don't want to (or are unable to) compile a kernel themselves
> will not benefit from it.

I know I'd like to see it in mainline.

> Tobias doesn't seem to have a public mail address (at least I didn't
> find any in his GH profile), so I can't ask him whether he considers
> sending a patch for inclusion.

It looks like he is pretty responsive to issues in github, but he's made it
clear he doesn't have the time to invest in getting this in mainline.

> Orm, would you be up for it? It needs to be done by someone with access
> to the hardware for testing. There are some things that need cleanup,
> but we can best discuss those in replies to a patch.

I wish I could volunteer, but I have no idea what I'm doing with kernel
stuff.  I have a Scarlett 6i6 to test with and may be able to get access to
an 18i20 as well, if that's in any way useful.

  - Ira
