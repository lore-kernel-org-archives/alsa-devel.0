From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: General Guidelines?  (MIDI)
Date: Thu, 16 Jan 2003 08:39:23 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301160836030.26796-100000@studcom.urz.uni-halle.de>
References: <20030116032713.GA30510@bhv1.adelphia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030116032713.GA30510@bhv1.adelphia.net>
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

Brian Victor wrote:
> Monitoring /proc/asound/seq/queues shows the events being queued, but as
> soon as the queue starts, all 400 notes leave the queue instantly; none
> are played.
>
>   snd_seq_ev_schedule_tick(&ev, m_queue, 0, tick);

What is the queue's tempo? 400 ticks may not be much.

>   snd_seq_ev_set_subs(&ev);

This will send the note events to the subscribers of your program's port.
Are there any?


HTH
Clemens



-------------------------------------------------------
This SF.NET email is sponsored by: A Thawte Code Signing Certificate 
is essential in establishing user confidence by providing assurance of 
authenticity and code integrity. Download our Free Code Signing guide:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0028en
