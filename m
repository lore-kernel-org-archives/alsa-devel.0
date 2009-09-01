From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 1/3] ASoC: DaVinci: i2s,
 reduce underruns by combining into 1 element
Date: Tue, 01 Sep 2009 12:19:26 -0700
Message-ID: <4A9D73BE.8000901@boundarydevices.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090901105302.GD18651@sirena.org.uk>
	<4A9D669F.6090906@boundarydevices.com>
	<20090901190327.GA25706@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth02.csee.onr.siteprotect.com
	(smtpauth02.csee.onr.siteprotect.com [64.26.60.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B24B103858
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 21:19:39 +0200 (CEST)
In-Reply-To: <20090901190327.GA25706@opensource.wolfsonmicro.com>
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
> On Tue, Sep 01, 2009 at 11:23:27AM -0700, Troy Kisky wrote:
>> Mark Brown wrote:
> 
>>> Last time you submitted this I suggested changing this to make the
>>> default the other way round so that there's no breakage on existing
>>> boards which aren't designed for this channel swap behaviour.  Is there
>>> some reason not to do that?
> 
>> I think that it is better to make sure that they know the possible problems
>> disabling this may cause. Channels always swapped seems a lot better than
>> channels randomly swapped.
> 
> Of course, the other way of looking at it is that with the channel
> swapping you've got guaranteed breakage - it sounds less good if you say
> it that way :) How common are the channel swaps?
> 
I was getting a lot when playing videos. It mainly just sounded bad until I got
a stereo audio file with different frequency sine waves to understand better
what was happening. Then, you could hear the channels swap frequently, more
than once per second. If using sram, it is not an issue unless another device
is using the same TC. But sram isn't on by default either. And probably shouldn't
be since the newer chips don't have an underrun problem.


Does anyone else want to share their thoughts/ experience?

Thanks
Troy
