From: Brian Victor <bhv1@psu.edu>
Subject: Re: General Guidelines?  (MIDI)
Date: Thu, 16 Jan 2003 08:41:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030116134157.GA31876@bhv1.adelphia.net>
References: <20030116032713.GA30510@bhv1.adelphia.net> <Pine.HPX.4.33n.0301160836030.26796-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0301160836030.26796-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 16, 2003 at 08:39:23AM +0100, Clemens Ladisch wrote:
>Brian Victor wrote:
>> Monitoring /proc/asound/seq/queues shows the events being queued, but as
>> soon as the queue starts, all 400 notes leave the queue instantly; none
>> are played.
>>
>>   snd_seq_ev_schedule_tick(&ev, m_queue, 0, tick);
>What is the queue's tempo? 400 ticks may not be much.

[before starting]
owned by client    : 128
lock status        : Locked
queued time events : 0
queued tick events : 400
timer state        : Stopped
timer PPQ          : 128
current tempo      : 12000000
current BPM        : 5
current time       : 0.000000000 s
current tick       : 0

[after starting]
queue 0: [Queue-0]
owned by client    : 128
lock status        : Locked
queued time events : 0
queued tick events : 0
timer state        : Running
timer PPQ          : 128
current tempo      : 12000000
current BPM        : 5
current time       : 1.140000000 s
current tick       : 12

(Which begs another question: what does PPQ stand for?  Something per
quarter?)

>>   snd_seq_ev_set_subs(&ev);
>This will send the note events to the subscribers of your program's port.
>Are there any?

Yes.  I have a sleep in my program that allows me to run from another
terminal: aconnect 64:0 128:1; aconnect 128:0 64:0  (Yes, there's an
input port, too.)

-- 
Brian


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
