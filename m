From: Florin Andrei <florin@andrei.myip.org>
Subject: Re: limits
Date: 07 Jun 2004 12:27:17 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1086636437.3260.6.camel@rivendell.home.local>
References: <Pine.HPX.4.33n.0406070926050.6374-100000@studcom.urz.uni-halle.de>
	 <Pine.LNX.4.58.0406071038470.3294@pnote.perex-int.cz>
Reply-To: alsa-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0406071038470.3294@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-06-07 at 01:40, Jaroslav Kysela wrote:
> On Mon, 7 Jun 2004, Clemens Ladisch wrote:
> 
> > Florin Andrei wrote:
> > > What's the max number of cards in a system that can be used by ALSA
> > > simultaneously?
> > 
> > > The answers to the questions above - are they in the docs?
> > 
> > Use the Source, Luke!  :-)

Well, now that ALSA has gone mainstream, perhaps "use the source" is not
the most appropriate answer anymore. See below for details.

> Note that applications shouldn't rely on these limits, because we can 
> change the driver code to support more cards/devices/sequencer queues etc. 
> in future.

I was asking purely from a "simple user"'s perspective.
See for example this message:

http://groups.yahoo.com/group/alesis-ion/message/4129

So people actually hit various driver limits. It was relatively easy to
find that kind of info about the Microsoft drivers, but the ALSA
documentation is a bit lacking on that.

-- 
Florin Andrei

http://florin.myip.org/



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
