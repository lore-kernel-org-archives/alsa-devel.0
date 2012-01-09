From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH - ice1724 4/4] ALSA: ice1724 - Support for
 ooAoo SQ210a
Date: Mon, 09 Jan 2012 10:59:50 +0100
Message-ID: <4F0ABA96.10303@ivitera.com>
References: <1325797318-16333-1-git-send-email-pavel.hofman@ivitera.com>	<1325797318-16333-4-git-send-email-pavel.hofman@ivitera.com>
	<s5haa5ymu9b.wl%tiwai@suse.de> <4F0AA630.8000902@ivitera.com>
	<4F0AB263.1040003@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 39EAA1039FC
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 10:59:54 +0100 (CET)
In-Reply-To: <4F0AB263.1040003@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 9.1.2012 10:24, Clemens Ladisch napsal(a):
> Pavel Hofman wrote:
>> Dne 8.1.2012 10:13, Takashi Iwai napsal(a):
>>> pavel.hofman@ivitera.com wrote:
>>>> This card shares PCI ids with Chaintec AV710. Therefore, it will not be
>>>> detected automatically, it can only be activated by the module parameter
>>>> model=sq210a.
>>>
>>> Hrm, that's bad.  Do you know any other way to identify the device?
>>
>> I am afraid I do not.
> 
> There is already a conflict with the AV710; it appears all three vendors
> use some default ID.
> 
>> Plus I would not be surprised if the other cards with different
>> accessories produced by that company shared all the same PCI ids and
>> differed just in EEPROM configs (most likely incorrect too :-) )
> 
> Their CMI8788-based cards implement only features that are a subset of
> those supported by the generic Windows driver.  (I guess they ship
> an .ini file that disables things like 7.1 output on a stereo card (thus
> breaking other models with the same ID), but it's possible that they
> just don't bother.)

They do seem not to bother much, they do not supply windows drivers for
this one at all, people should just use generic Envy24 drivers by VIA
:-) But the price is right.

> 
> Pavel, please don't forget to update the sound card matrix:
> http://www.alsa-project.org/main/index.php/Matrix:Vendor-%E5%82%B2%E7%8E%8B

Thanks for pointing out. I will add the latin "ooAoo" to the chinese
name, I had no idea the company was already listed in the matrix :)

Pavel.
