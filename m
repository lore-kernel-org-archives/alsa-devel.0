From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: seq24 not in aconnect or qjackctl
Date: Thu, 31 Mar 2005 10:31:41 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0503311030090.25472-100000@studcom.urz.uni-halle.de>
References: <20050330150554.GA17648@palantir7.mph.eclipse.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050330150554.GA17648@palantir7.mph.eclipse.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Habets <errandir_news@mph.eclipse.co.uk>
Cc: seq24-users@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Martin Habets wrote:
> Problem I'm having is that seq24 does not show up in
> aconnect or qjackctl.
>
> $ cat /proc/asound/seq/clients
> ...
> Client 128 : "seq24" [User]
>   Port   0 : "seq24 out" (r---)
>   Port   1 : "seq24 in" (-w--)
>   Port   2 : "seq24 in" (-w--)

seq24 doesn't allow connecting from other programs, you have to do it
from inside seq24.


HTH
Clemens



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
