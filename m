From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/2] soc-dapm or TWL4030: Runtime DAPM
	ordering problem
Date: Tue, 3 Aug 2010 03:56:40 +0100
Message-ID: <3C7676DA-EAAB-4C56-AD3A-2537EFEDF056@opensource.wolfsonmicro.com>
References: <1280732895-29010-1-git-send-email-peter.ujfalusi@nokia.com>
	<2EC9E5A5-E55F-4303-B6EF-2351B9440989@opensource.wolfsonmicro.com>
	<201008021359.11636.peter.ujfalusi@nokia.com>
	(sfid-20100802_115931_385588_45805DF2)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 46B7C10382A
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 04:56:47 +0200 (CEST)
In-Reply-To: <201008021359.11636.peter.ujfalusi@nokia.com>
	(sfid-20100802_115931_385588_45805DF2)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 2 Aug 2010, at 11:59, Peter Ujfalusi wrote:

> On Monday 02 August 2010 13:27:21 ext Mark Brown wrote:

>> With most things it's safer to implement the route change first -
>> especially in the analogue domain route changes tend to introduce DC
>> offsets so it's safer to set the route prior to powering up so the offset
>> changes don't get amplified. This is also very important when doing DC
>> offset correction, obviously there it's important to measure the offset of
>> the path you're actually trying to run rather than using whatever path was
>> there before.

> Sure, but what I'm telling is that we/I have basically two different scenarios 
> to fix for pop noise.

> A. When the user configures the capture routing, and starts the capture
> B. When the user changes the capture routing during active capture (analog to 
> digital, or back).

It feels like you're focusing in on one specific use case here - there's way more active->active transitions that are possible. For example, you could switch in bypass or start a second (unrelated) capture stream on devices that can support that. I think any change in DAPM needs to be motivated in more general terms than you're using here. For driver-specific changes this is fine but for changes in the generic code we need to think things through more generically.

> This might be not a problem for others, but since the TWL4030 has quite 
> complicated internal routings, and the controls for some of the routings are 
> scattered all around the register table with bits here and there, and 
> dependency to other bits, at least I'm not that happy that I need to handle 
> things differently...

I don't think the feature set is particularly unusual here, really - the main problem with TWL4030 appears to be the large number of magic "make the chip behave totally differently" bits that it has like with the selection between DSP and I2S modes.
