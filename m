From: Philip Spencer <pspencer@fields.utoronto.ca>
Subject: Re: [PATCH] Wrong latency in pulseaudio plugin breaks
 Adobe Flash Player
Date: Thu, 23 Feb 2012 10:18:35 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1202231008560.4520@lpc8.fields.utoronto.ca>
References: <alpine.LFD.2.00.1202161015470.19707@lpc8.fields.utoronto.ca>
	<4F3DAC41.4000602@canonical.com>
	<alpine.LFD.2.00.1202162248280.21549@fields.fields.utoronto.ca>
	<4F3E1A04.9080404@canonical.com>
	<alpine.LFD.2.00.1202171351300.11808@lpc8.fields.utoronto.ca>
	<4F42323E.1030204@canonical.com>
	<alpine.LFD.2.00.1202222059170.29627@fields.fields.utoronto.ca>
	<4F460055.2010508@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fileserver.fields.utoronto.ca (fileserver.fields.utoronto.ca
	[128.100.216.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A89C1041AD
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 16:18:39 +0100 (CET)
In-Reply-To: <4F460055.2010508@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 23 Feb 2012, Clemens Ladisch wrote:

> Philip Spencer wrote:
>>     3. What should happen?
>>
>>            (a) The call returns immediately, since there's lots of room
>>                in the buffer.
>>
>>            (b) The call returns after one I/O period's worth of data has
>>                been drained from the buffer.
>
> (a)
>
>> If the correct answer is (a) (ALSA's current behaviour), then is there
>> any mechanism for an app to achieve (b) -- get woken up after one I/O
>> period's worth of data have been drained (other than just doing some
>> infinite loop of sleeping then checking snd_pcm_avail periodically)?
>
> Adjust avail_min (but note that wakeups happen only at period
> boundaries).

That won't work if using the pulseaudio plugin as the backend -- it'll 
stop the first part of snd_pcm_wait from succeeding right away, but when 
it moves on to snd_pcm_wait_nocheck the poll call will return right away, 
because the pulseaudio plugin marks the file descriptor as ready whenever 
there are more than buffer_attr.minreq bytes available in the buffer.

Perhaps (though that won't help me, as I don't imagine I'll have any 
success getting Flash Player developers to change anything!, but it may
help any other similar app) that should be fixed in the pulseaudio plugin:

   - Implement sw_params

   - When sw_params is called, check the avail_min value and record it
      as a new field avail_min (and if it's different from the previous
      recorded value and the stream is running, call update_active)

   - In check_active, instead of "return wsize >= pcm->buffer_attr.minreq",
       "return wsize >= pcm->avail_min". (Question: should
       buffer_attr.minreq be changed too, or left alone?)

   - At the same time the start_threshold parameter could be implemented
     too.

I could whip up a patch for that if needed, although of course it won't 
actually help my situation -- I may just have to be resigned to using
non-live mode with about a 3/4 second latency for linux users.

Regards,

Philip

--------------------------------------------+-------------------------------
Philip Spencer  pspencer@fields.utoronto.ca | Director of Computing Services
Room 336        (416)-348-9710  ext3036     | The Fields Institute for
222 College St, Toronto ON M5T 3J1 Canada   | Research in Mathematical Sciences
