From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [git pull] [PATCH 0/7] add support for many Roland
 and Yamaha devices
Date: Fri, 09 Aug 2013 20:18:17 +0200
Message-ID: <52053269.2050706@ladisch.de>
References: <51CC9D8B.7060601@ladisch.de> <1670669.usJAXLJcqQ@kamdesktop>
 <5204EBD4.2040504@ladisch.de> <4161390.DqJ0fEoIrV@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 6F500265804
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 20:18:43 +0200 (CEST)
In-Reply-To: <4161390.DqJ0fEoIrV@kamdesktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Keith A. Milner" <maillist@superlative.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Keith A. Milner wrote:
> On Friday 09 Aug 2013 15:17:08 Clemens Ladisch wrote:
>> Keith A. Milner wrote:
>>> I will mention, if it is of any importance, that I get the following when
>>> the driver is loaded:
>>>
>>> [ 3340.089613] snd-usb-audio: probe of 1-6.2:1.2 failed with error -5
>>
>> That looks like the MIDI interface.
>> Do you have the MIDI ports (see "amidi -l")?
>
> No MIDI ports show up. Nor are there any on the device or any that I'm aware
> of that are "internal" to the device.

The descriptors says there are two ports, and the driver should be able
to detect them.

>> Is there any error message in the system log?
>
> Not really.

Please recompile the kernel with the option "More verbose debug"
(CONFIG_SND_DEBUG_VERBOSE) enabled and try again.


Regards,
Clemens
