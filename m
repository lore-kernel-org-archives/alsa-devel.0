From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: opl kernel panic
Date: Tue, 01 Apr 2003 11:35:23 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0304011126480.7279-100000@studcom.urz.uni-halle.de>
References: <20030330000156.GA16202@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030330000156.GA16202@spacedout.fries.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Fries <dfries@mail.win.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Fries wrote:
> ...
> ALSA ../alsa-kernel/isa/opl3sa2.c:733: specify port
> Yamaha OPL3-SA soundcard not found or device busy
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> ...

There seems to be a bug in opl3sa2.c.

Anyway, you have to specify the module options in /etc/modules.conf, e.g.
	options snd-opl3sa2 port=0x123 .....


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
