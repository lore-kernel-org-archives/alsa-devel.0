From: Jeremy Hall <jhall@maoz.com>
Subject: Re: I must be really dense
Date: Fri, 11 Jul 2003 11:58:58 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307111558.h6BFwwX9023787@sith.maoz.com>
References: <Pine.HPX.4.33n.0307111712570.4950-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0307111712570.4950-100000@studcom.urz.uni-halle.de>
 from Clemens Ladisch at "Jul 11, 2003 05:14:35 pm"
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jeremy Hall <jhall@maoz.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I reran snddevices and it seems happy, hopefully I can still go back and 
forth between old and new setups

thanks

_J

In the new year, Clemens Ladisch wrote:
> Jeremy Hall wrote:
> > when I try to run alsactl restore or alsactl store, it whines
> > about snd_ctl_open no such file or directory
> 
> Did you run snddevices?
> 
> > state.15 { ...
> > }
> > state.15_1 { ...
> > }
> 
> What is the ID of your card? (see /proc/asound/cards)
> The other state is old and can be deleted.
> 
> 
> HTH
> Clemens
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Parasoft
> Error proof Web apps, automate testing & more.
> Download & eval WebKing and get a free book.
> www.parasoft.com/bulletproofapps1
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
