From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Discovery of device characteristics
Date: Wed, 20 Feb 2013 21:28:12 +0100
Message-ID: <512531DC.6010701@ladisch.de>
References: <B053C7AF-BC91-4B13-B3AE-963AB6CC988C@onetel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 972FE264EBF
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 21:29:15 +0100 (CET)
In-Reply-To: <B053C7AF-BC91-4B13-B3AE-963AB6CC988C@onetel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Hewett <tghewett2@onetel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tim Hewett wrote:
> I'm writing software looking to discover the available sample rates,
> channel formats etc. for a device. I have been taking the approach of
> testing a sample rate from a list of potential rates, then setting the
> device to that rate to then test the channel formats etc..
>
> It works ok usually but keeps failing to detect that the device
> supports 24-bit channel formats, both for SND_PCM_FORMAT_S24_LE/BE and
> SND_PCM_FORMAT_S24_3LE/3BE. It detects the 16-bit formats without any
> problem.

Which device (driver) is this?

> Online source taken from http://download.atmark-techno.com/misc/demos/usb-audio-a500-howto/hw_params.c
> does detect the 24-bit format but doesn't set the sample rate first -
> each characteristic is tested in isolation - snd_pcm_hw_params_any()
> is called before each one.

snd_pcm_hw_params_any() is called only once; the configurations space
isn't reduced as long as no set* function is called.

> I am wondering if my way is not the correct way to determine device
> characteristics.

Your way sounds correct, but the driver code that sets the parameter
constraints might not be, or the device really doesn't support 24 bits
at the sample rate you've set.


Regards,
Clemens
