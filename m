From: Jeremy Hall <jhall@maoz.com>
Subject: Re: [PATCH] alsactl fixes
Date: Tue, 24 Jun 2003 19:57:49 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306242357.h5ONvnVJ027342@sith.maoz.com>
References: <s5hy8zw39cs.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8zw39cs.wl@alsa2.suse.de> from Takashi Iwai at "Jun 20, 2003
 08:13:55 pm"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

anoncvs has not picked up changes.

I am seeing a core dump when I try to run alsactl store and don't know 
why.  gdb isn't helping me on this machine.

_J

In the new year, Takashi Iwai wrote:
> At Fri, 20 Jun 2003 09:09:43 +0200 (METDST),
> Clemens Ladisch wrote:
> > 
> > 
> > When a card doesn't have any controls, the state.cardid.control node
> > isn't written to the output file because the node's join flag has been
> > set. This patch modifies alsactl not to set the join flag in this case
> > to prevent the "no state is present for card" message from "alsactl
> > restore".
> > 
> > And the check in line 510 used the wrong variable.
> 
> applied to cvs.
> 
> 
> thanks,
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: INetU
> Attention Web Developers & Consultants: Become An INetU Hosting Partner.
> Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
> INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
