From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [RFC PATCH] Add combined clock support to Atmel
	SoC audio
Date: Tue, 07 Jun 2011 22:29:13 +1000
Message-ID: <4DEE1999.70208@bluewatersys.com>
References: <4CEC3A97.4040400@bluewatersys.com>
	<20110607100321.GB14633@build.ihdev.net>
Reply-To: Ryan Mallon <rmallon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E77E24438
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 14:29:29 +0200 (CEST)
In-Reply-To: <20110607100321.GB14633@build.ihdev.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sergey Lapin <slapin@ossfans.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, gwossum@acm.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 07/06/11 20:03, Sergey Lapin wrote:
> Hi, Ryan!
> 
> On Wed, Nov 24, 2010 at 11:05:11AM +1300, Ryan Mallon wrote:
>> The following patch is one that has been floating around in various
>> forms in our own internal trees for a while.
>>
>> The Atmel SSC peripheral has seperate TX and RX clocks which use
>> separate pins from the the micro. TF (frame) and TK (clock) for transmit
>> and RF and RK for receive. Not all codecs have separate frame and bit
>> clocks for transmit and receive so we want to be able to do both
>> playback and capture using a single set of pins.
>>
>> This patch introduces a combined clock mode for the Atmel SSC
>> peripheral. Which allows playback and capture to use a single set of
>> pins. Currently combined clock is only supported on the TF/TK pins (some
>> incomplete support exists for using RF/RK).
>>
>> I have tested this patch on our AT91SAM9G45 + TLV320AIC26 platform.
>> Playback and capture work individually. Simultaneous playback and
>> capture have been tested by connecting a loopback cable on the linein
>> and lineout jacks and then doing:
>>
>>   arecord -c 2 -f S16_LE -r 44100 > recording.wav &
>>   aplay 500hz_sine.wav
>>
>> This patch is posted as RFC since the approach is incomplete and a bit
>> hackish. I am mostly interested in knowing if this is a sensible
>> approach, and could be cleaned up for mainline inclusion, or if there is
>> a better way to do this.
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> 
> I think it is also important to submit code, which uses it.
> If you can't do it I might try to do this in a few days.
> Also worth mentioning codec slave mode requirement for this to work.

Agreed. I don't have any hardware at the moment. I had intended to post
support for audio on the Bluewater Systems Snapper 9260 and 9G20 modules
(this patch being a precursor to that support), but I am no longer
working at Bluewater. Did you manage to get your hardware working in the
end?

I don't think the patch is ready for merging as is. It is incomplete
(though I suspect support for tx on the rx pins probably isn't needed)
and Mark also had some comments last time round: Use symmetric_rates,
replace atomic type with proper lock, etc. I think I may have done some
of this already, so can try and dig it out.

Also, this email address will cease to exist soon. Can you please use my
rmallon@gmail.com account instead. I'll have a kernel patch out soon to
fix my mail address up.

~Ryan
