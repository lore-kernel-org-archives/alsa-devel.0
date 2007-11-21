From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: Re: Latency and timestamps
Date: Wed, 21 Nov 2007 13:33:59 +0200
Message-ID: <474417A7.8070606@cs.helsinki.fi>
References: <5f52f6d70711191646s6f23fce3seba229a77062e1a1@mail.gmail.com>
	<s5h4pffj2j3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh07.mail.saunalahti.fi (emh07.mail.saunalahti.fi
	[62.142.5.117]) by alsa0.perex.cz (Postfix) with ESMTP id 63E8D24BF1
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 12:34:12 +0100 (CET)
In-Reply-To: <s5h4pffj2j3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Claudio Matsuoka <cmatsuoka@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai kirjoitti:
> At Mon, 19 Nov 2007 22:46:31 -0200,
> Claudio Matsuoka wrote:
>> Hi,
>>
>> I'm adding latency control to an application and didn't find much
>> documentation about the pcm status functions aside from a very brief
>> description and the latency.c example. What exactly are the "trigger
>> timestamp" and "now timestamp" returned by
>> snd_pcm_status_get_trigger_tstamp() and snd_pcm_status_get_tstamp()?
> 
> The trigger_tstamp is the time-stamp at the last time the PCM status
> change occured.  For example, when the PCM is really triggered to
> start, or stopped, or XRUN, etc.  It won't be changed as long as the 
> PCM status is kept.
> 
> OTOH, the tstamp is the current timestamp (now).  But, this value has
> a slightly different meaning when tstamp_mode is set to
> SND_PCM_TSTAMP_MMAP.  Then it keeps the timestamp of the last period
> update time instead of the now.

Good explanation. How about adding this to the API documentation, too? 
Even a copy-paste of the above would be much much better than what's in 
there now (basically repetitions of the already quite verbose function 
names.)

-- Heikki Lindholm
