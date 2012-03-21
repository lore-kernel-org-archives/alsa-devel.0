From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: paravirtualized alsa kernel driver for XEN
Date: Wed, 21 Mar 2012 14:37:56 +0100
Message-ID: <4F69D9B4.9000909@ladisch.de>
References: <4F6769A9.6090200@citrix.com> <4F6881B6.2020903@ladisch.de>
	<4F69AA8B.3080409@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6456E103E31
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 14:34:34 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DE8A82169E
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 09:34:24 -0400 (EDT)
In-Reply-To: <4F69AA8B.3080409@citrix.com>
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
> On 20/03/12 13:10, Clemens Ladisch wrote:
> > The delay between the DMA and the DAC output would be reported by
> > adjusting runtime->delay, but drivers usually do not bother to do this,
> > except when this delay becomes rather large because of additional
> > queueing, e.g., in the USB driver.
>
> ok, I was wondering about applications like skype, trying to do some
> background noise cancellation, or to eliminate echo when using speakers.
> I was thinking in this case the delay should be accurate for Playback
> and Capture as well, or am I wrong?

If the sound data is regularly moved from the VM's buffer to the host's
buffer, then the additional latency of the host is big enough that it's
worth reporting.

If you map the host's buffer into the VM's address space, there is no
additional latency, but I don't know if this is feasible.  If not, you
could also use the pcm_ops.copy callback to copy the data from the VM
to the host as soon as the application writes it.

> Who is currently the linux kernel alsa driver mantainer?

See "SOUND" in the MAINTAINERS file.


Regards,
Clemens
