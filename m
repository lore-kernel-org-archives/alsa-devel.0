From: Martin Langer <martin-langer@gmx.de>
Subject: Re: 1.0.6rc1 packages
Date: Wed, 4 Aug 2004 23:31:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040804213106.GA612@tuba.home>
References: <Pine.LNX.4.58.0408042050320.15189@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 3E0A8271
	for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2004 23:29:49 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408042050320.15189@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 04, 2004 at 08:51:08PM +0200, Jaroslav Kysela wrote:
> Hi all,
> 
> 	the 1.0.6rc1 ALSA packages are available for testing.

In file included from usbusx2yaudio.c:19:
../../alsa-kernel/usb/usx2y/usbusx2yaudio.c: In function usX2Y_urbs_allocate':
../../alsa-kernel/usb/usx2y/usbusx2yaudio.c:492: __old_i_usX2Y_urb_complete'
undeclared (first use in this function)
../../alsa-kernel/usb/usx2y/usbusx2yaudio.c:492: (Each undeclared identifier
is reported only once
../../alsa-kernel/usb/usx2y/usbusx2yaudio.c:492: for each function it
appears in.)
../../alsa-kernel/usb/usx2y/usbusx2yaudio.c: In function usX2Y_rate_set':
../../alsa-kernel/usb/usx2y/usbusx2yaudio.c:623: warning: assignment from
incompatible pointer type
usbusx2yaudio.c: At top level:
usbusx2yaudio.c:26: warning: i_usX2Y_urb_complete__old_' defined but not used

Oh, usx2y needs a fix.

martin


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
