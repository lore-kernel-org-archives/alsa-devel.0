From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: I must be really dense
Date: Fri, 11 Jul 2003 17:14:35 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0307111712570.4950-100000@studcom.urz.uni-halle.de>
References: <200307111305.h6BD5c96023078@sith.maoz.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200307111305.h6BD5c96023078@sith.maoz.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jeremy Hall <jhall@maoz.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jeremy Hall wrote:
> when I try to run alsactl restore or alsactl store, it whines
> about snd_ctl_open no such file or directory

Did you run snddevices?

> state.15 { ...
> }
> state.15_1 { ...
> }

What is the ID of your card? (see /proc/asound/cards)
The other state is old and can be deleted.


HTH
Clemens




-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
