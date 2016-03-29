From: =?UTF-8?Q?Bernhard_=c3=9cbelacker?= <bernhardu@vr-web.de>
Subject: Re: bytcr_rt5640, baytrail: trying to get audio working
Date: Wed, 30 Mar 2016 00:50:29 +0200
Message-ID: <56FB06B5.1060900@vr-web.de>
References: <56F82886.6010002@vr-web.de> <56F9C676.6000907@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0.vr-web.de (mx1.vr-web.de [195.200.35.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 561AD2669C6
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 00:50:33 +0200 (CEST)
In-Reply-To: <56F9C676.6000907@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Pierre-Louis,
thank you for your answers and your efforts.

Kind regards,
Bernhard

PS.: Could some info from a preinstalled Android of any help?


Am 29.03.2016 um 02:04 schrieb Pierre-Louis Bossart:
> If you modified the interrupt order then it's a Baytrail-CR device and 
> you will need to use the firmware that makes use of SSP0 (SSP2 is not 
> connected in this package). I am working to enable SSP0 routing directly 
> without the need for a new firmware but I haven't had time to test it.
> 
> That said, we've not been successful so far with such Baytrail-CR 
> devices. So far the issue seem to be in the SSP0-AIF2 connection; if you 
> do a loopback within the DSP things work fine. Without access to the 
> schematics and the board information it's not straightforward to solve 
> the problem.
> Note also that Baytrail-CR devices typically use different microphones 
> and speaker settings (differential mics, mono speakers typically) so you 
> may need to add some quirks.

Just for reference if someone gets here via search engine:

I have tried the firmware [1] and put it under /lib/firmware/intel/fw_sst_0f28.bin
with the modified interrupt order and linux 4.5.0-rc7+, entered the
amixer sequence and the speaker-test.

I saw with that also no obvious errors in dmesg.
Interrupts are also counted.
The clicks on device open and close are not to hear anymore.
But unfortunately it stays silent.

[1] https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/plain/intel/fw_sst_0f28_ssp0.bin?h=byt
