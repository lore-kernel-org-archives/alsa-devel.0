From: "John L. Utz III" <jutz@dmx.com>
Subject: Re: Any CMedia CMI8788 "Oxygen" and ASUS Xonar D1
 "virtuoso" documentation available?
Date: Tue, 20 Jan 2009 08:30:26 -0800
Message-ID: <4975FC22.3060306@dmx.com>
References: <497121FE.6000906@dmx.com> <49743B02.90506@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id A477D1037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 17:31:49 +0100 (CET)
In-Reply-To: <49743B02.90506@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens;

thankyou for the response.

Clemens Ladisch wrote:
> John L. Utz III wrote:
>> I just tried to find the docs for the CMI8788 on www.cmedia.com.tw and i
>> was not successful.
> 
> That website has a datasheet which doesn't contain much of interest.

yah, i read that. :-(

> There is a datasheet with register specifications, but it is only
> available under NDA.
> 
>> Nor have i been able to find any virtuoso docs at www.asus.com.
> 
> The only difference between the CMI8787/CMI8788/AV100/AV200 chips is the
> label on top of the chip.

Oh, thankyou!

>> I know that Clemens wrote the driver, but I dont know if it was written
>> from scratch with docs or ported from a 4front driver.
> 
> I started with an ALSA driver that was written by someone at C-Media,
> but it was so incomplete and buggy that I started over from scratch.
> I never signed an NDA.

ok, understood.

>> currently, there are some bugs with channel mapping on the rear channel
>> in Surround40 mode that i would like to fix
> 
> In 4.0 mode, the "rear" channels go to the "surround" jack.  The
> "surround" and "back" jacks behave like described in the manual.

yup, that works.

> The PCM data from the computer is organized as (up to) four two-channel
> pairs.  There are four DACs that each play a two-channel pair of PCM
> data.  The "play routing" register contains four two-bit fields that
> specify, for each DAC, the number of the channel pair that is to be
> played on this DAC.  This allows rerouting (by exchanging some fields)
> or duplicating of channels pairs (by having the same source for multiple
> DACs).  All this is handled in the oxygen_update_dac_routing() function.

thankyou for the huge fat hint. :-)

we have some transposed channels when we run our app, i can probably fix 
this.....

> HTH
> Clemens
> 
