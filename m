From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa sequencer: How to eliminate choking
Date: Wed, 8 Dec 2004 19:05:02 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0412081901570.21064-100000@studcom.urz.uni-halle.de>
References: <20041208001902.5265.qmail@web51902.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041208001902.5265.qmail@web51902.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michael Geis <michaelgeis11@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Michael Geis wrote:
> > I am pretty convinced that the problem is not queue overflow,
> > since I flush queues every two seconds.
>
> What do you mean by "flush"?
>
> -Sorry, I meant drain.

Do you mean snd_seq_drain_output?  This one should be called
immediately after you've written a bunch of events so that the kernel
sequencer sees them.  It isn't related to queues.

How much in advance of the delivery time do you send the events?


Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
