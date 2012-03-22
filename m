From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: paravirtualized alsa kernel driver for XEN
Date: Thu, 22 Mar 2012 13:09:09 +0100
Message-ID: <4F6B1665.6070402@ladisch.de>
References: <4F6769A9.6090200@citrix.com> <4F6881B6.2020903@ladisch.de>
	<4F69AA8B.3080409@citrix.com> <4F69D9B4.9000909@ladisch.de>
	<4F6B0B86.20603@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id BC64D24638
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 13:05:41 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 95CC721642
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 08:05:39 -0400 (EDT)
In-Reply-To: <4F6B0B86.20603@citrix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefano Panella <stefano.panella@citrix.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Stefano Panella wrote:
> The backend in dom0 is a userspace process using portaudio on top of alsa.
> The process is running in realtime priority and is calling a callback to
> feed data every 64 frames.
> In the callback I copy 64 frames from the shared pages to the portaudio
> buffer and update the HW pointer in an other shared page accordingly.

If PortAudio requires to use a callback, this is the only algorithm
that you can implement.

> Would it be possible to run the backend in dom0 kernel space and to use
> my shared pages from the alsa-driver in the VM as real pages for the HW?

No, the buffer pages are always under the control of and allocated by
the actual driver (some devices might have special requirements, or do
not support mmap at all).

If the actual driver support mmap, you would have to map these dom0
pages into the VM, and I guess this is not possible. (?)


As far as I can see, you have two options:

1) Stay with the current algorithm.  You get an additional latency
   corresponding to dom0's buffer size, and your process is forced to
   wake up every 64 frames (or whatever PortAudio is configured for).

2) Replace PortAudio with ALSA in the backend, and implement the copy
   callback in your driver.  Any call of snd_pcm_write*() in the VM will
   result in one or more calls to your driver's copy(), which should end
   up as a call to snd_pcm_write*() in dom0.  (Using the copy callback
   also implies that the driver does not support mmap.)


Regards,
Clemens
