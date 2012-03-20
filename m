From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: paravirtualized alsa kernel driver for XEN
Date: Tue, 20 Mar 2012 14:10:14 +0100
Message-ID: <4F6881B6.2020903@ladisch.de>
References: <4F6769A9.6090200@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 08D1F103BA8
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 14:06:44 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D5BA6218C5
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 09:06:41 -0400 (EDT)
In-Reply-To: <4F6769A9.6090200@citrix.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Stefano Panella wrote:
> I have been reading the documentation on "Writing an ALSA Driver" and I
> am still not completely clear on the meaning of the "pointer" callback
> in the pcm operations.
>
> 1) In case of a playback stream, is the pointer referring to wich sample
> is currently playing on the DAC or to which is it the last frame read by
> the HW from the alsa memory buffer?

It's the position of the first frame not yet read from the memory buffer.

The delay between the DMA and the DAC output would be reported by
adjusting runtime->delay, but drivers usually do not bother to do this,
except when this delay becomes rather large because of additional
queueing, e.g., in the USB driver.

> 4) is there any test I could run to check I have implemented correctly
> the "pointer" callback? Or any application which would need very high
> "pointer" precision like frame precision?

PulseAudio.
Or run mplayer and look at the A-V value in the status line.


Regards,
Clemens
