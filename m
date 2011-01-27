From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Fixed sampling freq UAC2 doubt
Date: Thu, 27 Jan 2011 09:14:29 +0100
Message-ID: <4D412965.7010704@ladisch.de>
References: <AANLkTinCZyrS6GDKfs3WerNrQ7DaF6_nMHLCaWqERmxC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7AA9C103A7E
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 09:14:11 +0100 (CET)
In-Reply-To: <AANLkTinCZyrS6GDKfs3WerNrQ7DaF6_nMHLCaWqERmxC@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Jassi Brar wrote:
>  While testing my under-development generic USB Audio Class 2.0 _gadget_ driver
> with ALSA's USB Audio Class driver, I came across an apparent discrepency.
> Or so do I think.
> 
> Page-98 Section 5.2.5.1.1 of 'Audio 20 final.pdf' specifies :-
> [In many cases, the Clock Source Entity represents a crystal
> oscillator based generator
>  with a single fixed frequency. In that case, the Set request is not supported.]
> 
> Here 'not supported' means setup requests for CUR/RANGE CS_SAM_FREQ_CONTROL
> should stall. Right ?

Strictly speaking, "is not" (instead of "might not be") implies that the
device _must_ stall.

> The snd_usb_hw_params in sound/usb/pcm.c apparently attempts to do that with
> disregard to Clock-Frequency-Control bitmask in bmControls field of the
> Clock Source Descriptor.
> 
> The confusion is, subs->cur_rate is initialized only if snd_usb_init_sample_rate
> succeeds. Which does SET control tranfer, albeit with the supported frequency.
> Couldn't a fixed sampling freq UAC2 compliant device refuse to work in
> that case, thereby failing any attempt to use the USB card?

Yes, it will fail.  This is a bug in the driver.


Regards,
Clemens
