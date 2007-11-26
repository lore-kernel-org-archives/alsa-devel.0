From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: Re: POSIX clocks and ALSA
Date: Mon, 26 Nov 2007 12:04:57 +0200
Message-ID: <474A9A49.1030208@cs.helsinki.fi>
References: <474A763E.7090001@cs.helsinki.fi>
	<Pine.LNX.4.61.0711260848180.7571@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh07.mail.saunalahti.fi (emh07.mail.saunalahti.fi
	[62.142.5.117]) by alsa0.perex.cz (Postfix) with ESMTP id 73548247B7
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 11:04:59 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0711260848180.7571@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela kirjoitti:
> On Mon, 26 Nov 2007, Heikki Lindholm wrote:
> 
>> Hello,
>>
>> Some years ago there was some talk about UST support in Linux, but the 
>> support never happened. With the hrtimers patch (and I'm not quite sure 
>> if even earlier?) CLOCK_MONOTONIC would seem like a fairly good UST time 
>> source. What I'd like to see, is a selectable clock for ALSA 
>> timestamping, e.g. something like snd_sw_params_clock(..., clockid_t 
>> clk). Would this seem plausible? I don't know that much about ALSA 
>> internals, so, no idea whether different clocks on different 
>> pcms/whatever would quickly turn into an unmanageable mess.
> 
> We are aware about this extension and I already proposed an 
> implementation. I hope to implement it soon. Timestamps are not used in 
> driver internally.

I had a look at the proposal and the thread at
http://thread.gmane.org/gmane.linux.alsa.devel/45237/focus=45573
I don't know about the history of SNDRV_PCM_IOCTL_TSTAMP, but since it 
currently seems unused I don't see a problem reusing it for something 
(else). However, I think that it'd be nicer to define the API to use a 
POSIX clock id instead of some arbitrary constants, because there have 
been/are other clocks on Linux, for example, CLOCK_SGI_CYCLE. An update 
to pcm_status might also be in order to tell which clock is being used.

-- Heikki Lindholm
