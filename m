From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Different codecs for playback and capture?
Date: Thu, 04 Jun 2015 15:58:36 +0200
Message-ID: <5570598C.3020103@metafoo.de>
References: <alpine.DEB.2.02.1506031045380.22011@lnxricardw1.se.axis.com>
 <556F0E7F.80802@metafoo.de>
 <alpine.DEB.2.02.1506041000080.15001@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-080.synserver.de (smtp-out-080.synserver.de
 [212.40.185.80])
 by alsa0.perex.cz (Postfix) with ESMTP id A2EFB260661
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:58:37 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1506041000080.15001@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 06/04/2015 10:06 AM, Ricard Wanderlof wrote:
>
> On Wed, 3 Jun 2015, Lars-Peter Clausen wrote:
>
>> There has been support for multiple CODECs on the same DAI link for a while
>> now. Have a look at
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=88bd870f02dff5c9445286e185f21873f25a977f.
>>
>> Instead of setting the codec_name/codec_dai_name fields in the dai_link
>> create a snd_soc_link_component array with a entry for each of the CODECs
>> and assign that to the codecs field in the DAI link.
>>
>> I'm not too sure how well it works if one CODEC is playback only and the
>> other is capture only and there might be some issues. But this is the way to
>> go and if there are problems fix them.
>
> Ok, thanks.
>
> Actually, in the case in question, there is no real codec for capture,
> it's a MEMS microphone with an I2S output. So patching the codec (which is
> playback only) driver to simply allow capture actually accomplishes the
> desired result, but that's not a viable solution of course, and is only
> proof-of-hardware.
>
> I can't seem to find a simple driver for a MEMS microphone though,
> although since there is actually nothing really to configure on the device
> itself (it has no configuration port, just an I2S output), perhaps I
> should simply be using a dummy driver (snd-soc-dummy) that basically
> enables capture?

snd-soc-dummy is only meant to be used for links which do not have any CODEC 
at all. It is kind of a stop-gap solution until the framework gains the 
capability to support such links natively.

Even if your device does not have any configuration registers it will still 
have constraints like the supported sample rates, sample-widths, etc. You 
should create a driver describing these capabilities. This ensures that the 
driver will work when the device is connected to a host side CPU DAI that 
supports e.g. sample-rates outside the microphones range. The AK4554 driver 
is an example of such a driver.

- Lars
