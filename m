From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: General Guidelines?  (MIDI)
Date: Sun, 19 Jan 2003 23:21:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030119222156.GC5697@obelix>
References: <E18ZGLH-0005nh-00@sc8-sf-list2.sourceforge.net> <200301162227.36021.plcl@telefonica.net> <20030116223735.GB32330@bhv1.adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030116223735.GB32330@bhv1.adelphia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian Victor <bhv1@psu.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 16, 2003 at 05:37:35PM -0500, Brian Victor wrote:
> 
> Likewise, I was under the impression that queues handled sequencing
> events by timestamp if they arrived in non-sequential order.  Is that
> so?  

Yes, the sequencer's priority queues automatically order the events enqueued
by timestamp.

> Do I just need to stay ahead of the queue for this to work?  Does
> that mean, I can't reliably send the queue all events for one voice,
> followed by all events for another voice?

Because of memory sizes for the event pool, this depends on the number of
events you want to enqueue. Of course you'll need to stay ahead of the queue
or the event wil be emitted immediately (when T[scheduled] < T[queue head]).

Yes, you can enqueue all events for one voice followed by next voices as
long as you do not exceed the size of the queue. In practice you'll enqueue
the events for a (small) timeframe, eg. one bar, and let the sequencer
handle the scheduling. 

Frank.

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
