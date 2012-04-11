From: Stefano Panella <stefano.panella@citrix.com>
Subject: Re: paravirtualized alsa kernel driver for XEN
Date: Wed, 11 Apr 2012 18:08:30 +0100
Message-ID: <4F85BA8E.3080805@citrix.com>
References: <4F6769A9.6090200@citrix.com> <4F6881B6.2020903@ladisch.de>
	<4F69AA8B.3080409@citrix.com> <4F69D9B4.9000909@ladisch.de>
	<4F6B0B86.20603@citrix.com> <4F6B1665.6070402@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SMTP.EU.CITRIX.COM (smtp.eu.citrix.com [62.200.22.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 2375F104159
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Apr 2012 18:59:19 +0200 (CEST)
In-Reply-To: <4F6B1665.6070402@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On 22/03/12 12:09, Clemens Ladisch wrote:
> Stefano Panella wrote:
>> The backend in dom0 is a userspace process using portaudio on top of alsa.
>> The process is running in realtime priority and is calling a callback to
>> feed data every 64 frames.
>> In the callback I copy 64 frames from the shared pages to the portaudio
>> buffer and update the HW pointer in an other shared page accordingly.
>
> If PortAudio requires to use a callback, this is the only algorithm
> that you can implement.
>
>> Would it be possible to run the backend in dom0 kernel space and to use
>> my shared pages from the alsa-driver in the VM as real pages for the HW?
>
> No, the buffer pages are always under the control of and allocated by
> the actual driver (some devices might have special requirements, or do
> not support mmap at all).
>
> If the actual driver support mmap, you would have to map these dom0
> pages into the VM, and I guess this is not possible. (?)
>
>
> As far as I can see, you have two options:
>
> 1) Stay with the current algorithm.  You get an additional latency
>     corresponding to dom0's buffer size, and your process is forced to
>     wake up every 64 frames (or whatever PortAudio is configured for).
>
> 2) Replace PortAudio with ALSA in the backend, and implement the copy
>     callback in your driver.  Any call of snd_pcm_write*() in the VM will
>     result in one or more calls to your driver's copy(), which should end
>     up as a call to snd_pcm_write*() in dom0.  (Using the copy callback
>     also implies that the driver does not support mmap.)
>
>
I am now switching to write the backend using alsa + dmix + dsnoop 
directley since I did not manage to get information about precise timing 
in .

I would like echo cancellation to work in the guest but I am getting a 
bit lost and I am not certain anymore which would be the best approch.

I have available for sure:

1) a set of shared pages, used for:
- playback buffer
- capture buffer
- general purpose commands/events/flags

2) a way to send notification from the backend resulting in an interrupt 
in the guest pv alsa kernel driver.
- I use it at the moment to send a period interrupt

3) a way to have a callback executed in the backend code triggered from 
the guest alsa driver, like as I use for:
-prepare
-trigger
-open
-close

My question is now:

To make echo cancellation work in the guest the guest needs to know 
exactly which sample in the buffer is going in and out, right?

How can I design my alsa backend userspace program and the pv alsa 
kernel driver for the guest to do this?

Is there any echo cancellation test program to check pv alsa driver in 
the guest + backend alsa app in dom0 are working well without douing a 
skype call every time?

What would be very critical in the guest pv alsa driver?
- Should the first audio sample be played/captured right after the 
trigger or it can happen at later time (runtime->delay maybe could be 
setted)?
- should the pointer callback reflect the sample being currently 
played/captured?
- what should the pointer callback return in case of a fixed delay in 
playback and capture?
- do I need an interrupt every period triggered from the backend or can 
I use the hrtimer as in the dummy sound card example?
-in order to only use the copy callback, and remove mmap support, what 
should I do?


On the backend application side:
- how using dmix, dsnoop, asym plugins affects sample position accuracy 
using snd_pcm_delay, snd_pcm_avail, snd_pcm_status_get_delay ?
- how could I be woken up exactly every period using dmix, dsnoop, asym 
plugins?

Sorry for these many questions but I have been doing experiments so far 
and all is working well but echo cancellation and I would like to know 
if I completely misunderstood something.

Thanks for all your patience,

Regards,

Stefano

> Regards,
> Clemens
