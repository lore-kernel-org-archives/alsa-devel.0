From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 1/3] ASoC: DaVinci: i2s,
 reduce underruns by combining into 1 element
Date: Tue, 01 Sep 2009 13:42:02 -0700
Message-ID: <4A9D871A.0@boundarydevices.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090901105302.GD18651@sirena.org.uk>
	<4A9D669F.6090906@boundarydevices.com>
	<20090901190327.GA25706@opensource.wolfsonmicro.com>
	<4A9D73BE.8000901@boundarydevices.com>
	<20090901202855.GA26626@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth02.csee.onr.siteprotect.com
	(smtpauth02.csee.onr.siteprotect.com [64.26.60.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 20B3C103807
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 22:42:11 +0200 (CEST)
In-Reply-To: <20090901202855.GA26626@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: avm@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Sep 01, 2009 at 12:19:26PM -0700, Troy Kisky wrote:
>> Mark Brown wrote:
> 
>>> Of course, the other way of looking at it is that with the channel
>>> swapping you've got guaranteed breakage - it sounds less good if you say
>>> it that way :) How common are the channel swaps?
> 
>> I was getting a lot when playing videos. It mainly just sounded bad until I got
>> a stereo audio file with different frequency sine waves to understand better
>> what was happening. Then, you could hear the channels swap frequently, more
>> than once per second. If using sram, it is not an issue unless another device
> 
> So, very often under heavy load then?   That'd be consistent with simlar
> problems on other devices.  Part of the trouble here is that things like
> video can make the channel swap more noticable - if stereo is used to
> track the movement of an object on screen the channel swap would stop
> the effect tying in with the visuals.
> 
>> is using the same TC. But sram isn't on by default either. And probably shouldn't
>> be since the newer chips don't have an underrun problem.
> 
> Hrm, that suggests that if it's enabled at all the default should depend
> on the chip in use?
> 
That seems unnecessarily complex to me. As long as platform data can
specify what you need, you'll eventually get it right. If tracking of
an object is always wrong because of a channel swap, that is easier
to notice, and debug, and fix, then if the tracking is only occasionally
wrong. I'd much rather have a repeatable bug. And most codecs do allow
you to swap the left and right channels. So, for most people, the fix
will not be to disable channel combining.


Troy
