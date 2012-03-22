From: Stefano Panella <stefano.panella@citrix.com>
Subject: Re: paravirtualized alsa kernel driver for XEN
Date: Thu, 22 Mar 2012 11:22:46 +0000
Message-ID: <4F6B0B86.20603@citrix.com>
References: <4F6769A9.6090200@citrix.com> <4F6881B6.2020903@ladisch.de>
	<4F69AA8B.3080409@citrix.com> <4F69D9B4.9000909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SMTP.EU.CITRIX.COM (smtp.ctxuk.citrix.com [62.200.22.115])
	by alsa0.perex.cz (Postfix) with ESMTP id A95DE245FF
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 12:13:54 +0100 (CET)
In-Reply-To: <4F69D9B4.9000909@ladisch.de>
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

On 21/03/12 13:37, Clemens Ladisch wrote:
> Stefano Panella wrote:
>> On 20/03/12 13:10, Clemens Ladisch wrote:
>>> The delay between the DMA and the DAC output would be reported by
>>> adjusting runtime->delay, but drivers usually do not bother to do this,
>>> except when this delay becomes rather large because of additional
>>> queueing, e.g., in the USB driver.
>>
>> ok, I was wondering about applications like skype, trying to do some
>> background noise cancellation, or to eliminate echo when using speakers.
>> I was thinking in this case the delay should be accurate for Playback
>> and Capture as well, or am I wrong?
>
> If the sound data is regularly moved from the VM's buffer to the host's
> buffer, then the additional latency of the host is big enough that it's
> worth reporting.
>
> If you map the host's buffer into the VM's address space, there is no
> additional latency, but I don't know if this is feasible.  If not, you
> could also use the pcm_ops.copy callback to copy the data from the VM
> to the host as soon as the application writes it.
>
My PV alsa driver is allocating some non contiguous pages for the audio 
buffer and the get_page callback is called to retrieve the position of 
every page. These pages are also mapped from the backend in dom0.

The backend in dom0 is a userspace process using portaudio on top of alsa.
The process is running in realtime priority and is calling a callback to 
feed data every 64 frames.
In the callback I copy 64 frames from the shared pages to the portaudio 
buffer and update the HW pointer in an other shared page accordingly.

Would it be possible to run the backend in dom0 kernel space and to use 
my shared pages from the alsa-driver in the VM as real pages for the HW 
instead to go all the way from 
userspace->portaudio->alsalib->alsa-kernel-layer->Real-HW ?

>> Who is currently the linux kernel alsa driver mantainer?
>
> See "SOUND" in the MAINTAINERS file.
OK
>
>
> Regards,
> Clemens

Thanks again very much and regards,

Stefano
