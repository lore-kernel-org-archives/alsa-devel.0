From: melwyn lobo <linux.melwyn@gmail.com>
Subject: Re: XRUN handling
Date: Tue, 6 Jul 2010 23:16:03 +0530
Message-ID: <AANLkTim93O9PgptYEdBkAf_x7reIf_1DxbHCYjLdfVLB@mail.gmail.com>
References: <AANLkTim_2xOjhFHcfyMvgceAQZEauWYIbY8QV-0jnBWw@mail.gmail.com>
	<AANLkTikRHAHhDXEEcejT5BqiJXiIaQX-lhg3zqTljcnq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CE8E52462D
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 19:46:14 +0200 (CEST)
Received: by gwb11 with SMTP id 11so192239gwb.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Jul 2010 10:46:13 -0700 (PDT)
In-Reply-To: <AANLkTikRHAHhDXEEcejT5BqiJXiIaQX-lhg3zqTljcnq@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 6, 2010 at 9:46 PM, James Courtier-Dutton
<james.dutton@gmail.com> wrote:
> On 6 July 2010 06:03, melwyn lobo <linux.melwyn@gmail.com> wrote:
>> Hi all,
>> I have noticed when an Xrun occurs, the bytes between the hw_ptr and
>> appl_ptr are not copied when both hw and appl pointers are reset in
>> snd_pcm_prepare().
>>
>> Is my analysis correct? If so how do we ensure correct behaviour ie
>> byte accuracy after Xrun.
>>
>
> When an Xrun occurs, all bets are off. You should reset the sound card
> buffers and start again.
> The best thing to do is try to track down why the Xrun occurs in the
> first place and stop it happening.
> It most likely occurs because some other device is keeping the CPU
> from servicing the interrupt correctly.
> Normally graphics card drivers, hard disk drivers or file system code
> causes this problem.
Thanks James.
We would not like to change the core vanilla kernel available as is
from kernel.org
apart from adding our own platform software of course.
For software robustness, we need to ensure that even after an XRUN
no data is missed.

> Look at low latency and real time patches for the Linux kernel.
>
> Kind Regards
>
> James
>

Thanks Clemens,

>When the ALSA framework tells the driver to stop, and then resets the
>pointers, the driver cannot avoid doing this.
>
>
>Applications have two choices how xruns are to be handled:
>1) Stop the stream; the application must then reset the stream (by
> reparing it).  This mode is selected by using a stop_threshold that
>  is lower than the buffer_size.  This is the default mode.
>2) Continue playing.  The device will play old data from the ring
>  buffer, until the application has caught up and written new data
>  to the buffer.  This mode is selected by setting stop_threshold to
>  the boundary value.
>
>
>Regards,
>Clemens

I have already done the above and issues are as under:
1. Stopping the stream after stop_threshold does ensure that garbage data is not
played, but, as said earlier, the remaining bytes within the buffer
are discarded
by the application. Not acceptable for us (assuming we use only standard aplay)
2. Continuing to run the the ring buffer produces garbage which can be
done away with by using silence_size and silence_threshold. And if the
application still does not get processor time for some reason, the
hw_ptr will overrun the appl_ptr by more than buffer_size and trigger
a bug in snd_pcm_playback_silence().

I am using 2.6.32.8. Are there any patches for xrun handling between
this and the latest versions of the kernel that I could use.

Regards
M.
