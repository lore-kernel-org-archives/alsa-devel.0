From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [Jackit-devel] irq handler top half timestamps
Date: Fri, 10 Dec 2004 12:17:35 -0500
Message-ID: <200412101717.iBAHHZuW012442@localhost.localdomain>
References: <20041210182359.2a5dc4a4@mango.fruits.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 10 Dec 2004 18:23:59 +0100."
             <20041210182359.2a5dc4a4@mango.fruits.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Jaroslav Kysela <perex@suse.cz>, Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>, jackit-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> We can do any timestamp in the IRQ handler (this enum can be extended):
>> 
>> enum sndrv_pcm_tstamp {
>>         SNDRV_PCM_TSTAMP_NONE = 0,
>>         SNDRV_PCM_TSTAMP_MMAP,
>>         SNDRV_PCM_TSTAMP_LAST = SNDRV_PCM_TSTAMP_MMAP,
>> };
>> 
>> And this structure is used to store timestamp value:
>> 
>> struct timespec tstamp;
>
>Way cool! But how to access it from userspace?

i was remembering this the other day. just a quick note: the timestamp
will be taken in the "bottom half" handler, which hopefully makes no
difference for JACK purposes because the audio interface IRQ is not
threaded.

--p


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
