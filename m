From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Triple implementation of
	WM8766	and	quadruple	WM8776!
Date: Tue, 13 Mar 2012 11:05:43 +0100
Message-ID: <4F5F1BF7.4070808@ivitera.com>
References: <201203122241.12234.linux@rainbow-software.org>	<4F5F1776.4020904@ladisch.de>
	<4F5F1905.7040609@ivitera.com> <s5hy5r4lt54.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189]) by alsa0.perex.cz (Postfix) with ESMTP id 5BB0D24525
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 11:05:44 +0100 (CET)
In-Reply-To: <s5hy5r4lt54.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>
List-Id: alsa-devel@alsa-project.org

Dne 13.3.2012 10:58, Takashi Iwai napsal(a):
>> .....
>>>
>>> I'd suggest to move the common parts of the three ice1712 drivers into
>>> separate files.  You could make the interface of those files similar to
>>> ASoC codec drivers to make later porting easier.
>>
>> How about a solution similar to AKM codecs in i2c/other? Several ice1724
>> cards make use of those modules, easy to support and re-use. IMO cleaner
>> approach than duplicating ICE1724 to the ASoC framework.
> 
> ASoC would be rather a "cleaner" approach, but moving the common code
> into i2c/other would be a "safer" approach.  It can be done without
> shifting the whole infrastructure of ice17xx and oxygen drivers,
> indeed.

That is very true. I am afraid we do not have all the cards physically
available to test a major overhaul of ice17xx.

Pavel.
