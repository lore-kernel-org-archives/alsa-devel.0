From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: HELP! seq - writing to q in realtime mode
Date: Wed, 12 May 2004 17:55:41 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405121743290.26780-100000@studcom.urz.uni-halle.de>
References: <40A1F7BA.6020109@orcon.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <40A1F7BA.6020109@orcon.net.nz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David McNab <rebirth@orcon.net.nz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David McNab wrote:
> I'm trying to create and schedule outbound events, in realtime absolute
> mode.
>
> When sending these events directly, using SND_SEQ_QUEUE_DIRECT, the
> events get delivered fine to subscribers.
>
> But when adding realtime absolute timestamps, and marking the event to a
> queue I've created, only the very first event (time=0) gets sent.

Is the queue running?  (see /proc/asound/seq/queues)

> Can someone please give an overview (or preferably sample code)
> explaining what I need to do to transmit events in realtime absolute mode?

See the aplaymidi example, which transmits events with relative tick
timestamps.  Set the appropriate bits in ev.flags
(SND_SEQ_TIME_STAMP_REAL and SND_SEQ_TIME_MODE_ABS) and use
ev.time.time.tv_sec and .tv_nsec instead of ev.time.tick.  (The
snd_seq_ev_schedule_real macro just sets these fields, too.)

> For instance, do I need to set up timers on the queue?

No, queues have a default timer.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
