From: Michael Geis <michaelgeis11@yahoo.com>
Subject: Re: queue time not increasable with snd_seq_ev_set_queue_pos_real
Date: Thu, 3 Mar 2005 15:06:35 -0800 (PST)
Message-ID: <20050303230635.30639.qmail@web51910.mail.yahoo.com>
References: <Pine.HPX.4.33n.0503031627300.18307-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.33n.0503031627300.18307-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Yes, it helped. I just had to use snd_seq_ev_direct,
and everything worked fine.

Merci,
Michael


>Michael Geis wrote:
>> I can change queue times backwards but not forwards
>> via snd_seq_ev_set_queue_pos_real.
>>
>> snd_seq_ev_set_queue_pos_real(&ev, queue,
>&time_stamp);
>
>This is OK ...
>
>> snd_seq_ev_schedule_real(&ev, queue, 0,
>&time_stamp);
>
>... but this schedules the time change event to be
>delivered at a
>later time, so it won't yet be effective when reading
>the queue status
>immediately after this call.  I guess you wanted to
>use
>snd_seq_ev_set_direct here.
>
>Yes, the documentation sucks.
>
>
>HTH
>Clemens
>


	
		
__________________________________ 
Celebrate Yahoo!'s 10th Birthday! 
Yahoo! Netrospective: 100 Moments of the Web 
http://birthday.yahoo.com/netrospective/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
