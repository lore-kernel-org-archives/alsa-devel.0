From: Tim Hewett <tghewett2@onetel.com>
Subject: Re: Discovery of device characteristics
Date: Wed, 20 Feb 2013 21:38:00 +0000
Message-ID: <0AAD2327-63B2-41DE-B351-59A1378BCFE4@onetel.com>
References: <B053C7AF-BC91-4B13-B3AE-963AB6CC988C@onetel.com>
 <512531DC.6010701@ladisch.de>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-beusergroup.xen.exoware.net (smtp.beusergroup.co.uk
 [213.229.88.3]) by alsa0.perex.cz (Postfix) with ESMTP id F38DA265B72
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 22:38:01 +0100 (CET)
In-Reply-To: <512531DC.6010701@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Tim Hewett <tghewett2@onetel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

Many thanks for your reply.

I think today I may have found "the" solution, it seems to work at least.

The problem seems to be that the nested loops (each of which was testing sample rate, channel format and number of channels) were only calling snd_pcm_hw_params_any() at the top of the outer loop, so (e.g.) the next sample rate was tested after a previous one had been set. It seems that once one sample rate has been set, it isn't possible to test another one until the params are reset.

Now all the params are tested in the innermost loop, where snd_pcm_hw_params_any() is now called just before all the tests for each possible combination in isolation.

Separately I'm trying to find an API for being notified when devices are added/removed. If you (CC: anyone else) could point me in the right direction I'd be very grateful.

Regards,

Tim.


On 20 Feb 2013, at 20:28, Clemens Ladisch <clemens@ladisch.de> wrote:

> Tim Hewett wrote:
>> I'm writing software looking to discover the available sample rates,
>> channel formats etc. for a device. I have been taking the approach of
>> testing a sample rate from a list of potential rates, then setting the
>> device to that rate to then test the channel formats etc..
>> 
>> It works ok usually but keeps failing to detect that the device
>> supports 24-bit channel formats, both for SND_PCM_FORMAT_S24_LE/BE and
>> SND_PCM_FORMAT_S24_3LE/3BE. It detects the 16-bit formats without any
>> problem.
> 
> Which device (driver) is this?
> 
>> Online source taken from http://download.atmark-techno.com/misc/demos/usb-audio-a500-howto/hw_params.c
>> does detect the 24-bit format but doesn't set the sample rate first -
>> each characteristic is tested in isolation - snd_pcm_hw_params_any()
>> is called before each one.
> 
> snd_pcm_hw_params_any() is called only once; the configurations space
> isn't reduced as long as no set* function is called.
> 
>> I am wondering if my way is not the correct way to determine device
>> characteristics.
> 
> Your way sounds correct, but the driver code that sets the parameter
> constraints might not be, or the device really doesn't support 24 bits
> at the sample rate you've set.
> 
> 
> Regards,
> Clemens
