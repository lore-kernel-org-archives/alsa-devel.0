From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: queue time not increasable with snd_seq_ev_set_queue_pos_real
Date: Thu, 3 Mar 2005 16:34:17 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503031627300.18307-100000@studcom.urz.uni-halle.de>
References: <20050303122133.41334.qmail@web51907.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20050303122133.41334.qmail@web51907.mail.yahoo.com>
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
> I can change queue times backwards but not forwards
> via snd_seq_ev_set_queue_pos_real.
>
> snd_seq_ev_set_queue_pos_real(&ev, queue, &time_stamp);

This is OK ...

> snd_seq_ev_schedule_real(&ev, queue, 0, &time_stamp);

... but this schedules the time change event to be delivered at a
later time, so it won't yet be effective when reading the queue status
immediately after this call.  I guess you wanted to use
snd_seq_ev_set_direct here.

Yes, the documentation sucks.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
