From: Kenth Andersson <kenth@popwire.com>
Subject: Re: DSnoop Latency
Date: Fri, 7 Oct 2005 15:51:46 +0200
Message-ID: <EB74F7D1-C8C7-4E7E-9855-9DC1A81E6B4E@popwire.com>
References: <997BA7FD-4755-47D7-8AB9-1DBCB4FEE445@popwire.com> <s5hy855a1q1.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.popwire.com (mail.popwire.com [62.20.78.55])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8951D164
	for <alsa-devel@alsa-project.org>; Fri,  7 Oct 2005 15:52:16 +0200 (MEST)
In-Reply-To: <s5hy855a1q1.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'll try to explain my problem more precise

Alsa version: 1.0.8

My problem is that if I set the sound card to 22050Hz and try to  
capture 10 seconds of sound (22050 * 10 samples). This would take  
precisely 10 seconds because it's realtime, but through dsnoop it  
takes more then 10 seconds, about 160 samples to long time if dsnoop  
is initialized to 8000 Hz and then tries to resample to 22050. This  
is a big problem then trying to capture live sound and stream it over  
network in realtime, because I can't get all the sound in realtime  
through dsnoop.

DSnoop settings:
rate 8000
period_size 1024
period_time 0
buffer_size 4096

The reason why i got rate 8000 Hz and capture at 22050 Hz it that I  
got another process doing the same thing at 8000Hz (at the same time).
I read 1024 samples each time from dsnoop.

Does this explain my problem?

/Kenth


On Oct 7, 2005, at 3:36 PM, Takashi Iwai wrote:

> At Fri, 7 Oct 2005 15:01:03 +0200,
> Kenth Andersson wrote:
>
>>
>> Hi,
>>
>> I'm using a M-Audio Delta 44 sound card which is 4 mono channels. I'm
>> using DSnoop
>> plugin to divide this 4 mono channels into two virtual sound cards,
>> cline1-2, each with a stereo configuration.
>>
>> My setup is as follows:
>> I got two live sound streams running, streaming sound over the  
>> network
>> from cline1 I'm capturing 8000 mono s16_le sound
>> from cline2 I'm capturing 22050 stereo s16_le sound
>>
>> I'm running this on a P4 3,2GHz HT Machine and it uses about 20%  
>> of CPU.
>>
>
> First of all:  which ALSA version?
>
>
>> My problem is that there are BIG latency in the stereo stream, why is
>> that?
>>
>
> How BIG do you mean?  Any objective number, even approximately?
>
>
>>  I understand that dsnoop
>> has to do a sample rate conversion from input sample rate to both
>> 8000 and 22050, but it looks like this
>> conversion is very slow, without using all my CPU.
>>
>
> I don't think it's the conversion layer.
> Or it might be the period-size misalignment problem.
> Try 24kHz on one side, for example (assuming that dmix slave is
> running on 48kHz).
>
>
>> 1. Anybody know anything about this, it it possible to prevent the
>> latency?
>> 2. Does anyone know of a better solution then dsnoop, that don't have
>> this latency?
>>
>
> You mixed up two things: CPU usage and the latency.  In theory, both
> have nothing to do with each other.
>
> The latecy of dsnoop depends on its configuration.  Suppose you're
> using "dsnoop" PCM without extra setup, its period size is 1024
> frames.  This exactly defines the latency.
>
>
> Takashi
>
>



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
