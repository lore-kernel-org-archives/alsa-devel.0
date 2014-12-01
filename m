From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 21/30] ALSA: oxfw: Change the way to name
	card
Date: Mon, 01 Dec 2014 12:21:55 +0100
Message-ID: <547C4F53.1030306@ladisch.de>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
 <1417190379-4172-22-git-send-email-o-takashi@sakamocchi.jp>
 <s5hbnnpbxxs.wl-tiwai@suse.de> <547A9E1B.7060004@sakamocchi.jp>
 <s5h4mthay31.wl-tiwai@suse.de> <547BA5F2.4040401@sakamocchi.jp>
 <s5hzjb792z3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 20406260309
 for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2014 12:22:19 +0100 (CET)
In-Reply-To: <s5hzjb792z3.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Takashi Sakamoto wrote:
>> On Nov 30 2013 17:31, Takashi Iwai wrote:
>>>>> So, this ends up with the identical strings for both driver and
>>>>> shortname?  This doesn't sound like an improvement.
>>>>
>>>> Basically, hard-coded strings can be replaced by strings read from
>>>> config-rom on the devices. My original intension of this commit is
>>>> following to this.
>>>>
>>>> But FWSpeakers/FireWave has long strings for vendor/model strings on
>>>> config-rom, therefore his commit can obsolete long name only.
>>>>
>>>> Actually this patch is a help for later patch:
>>>> [PATCH 26/30] ALSA: oxfw: Add support for Behringer/Mackie devices
>>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-November/084818.html
>>>
>>> But still it's not applied to LaCie and other that have device_info,
>>> no?  So they'll end up with the even shorter names than now.
>>>
>>> I'd be better to create a short_name from "Vendor Model" where
>>> driver_name can be a fallback of model name.
>>
>> Any reasons?
>
> Read again: it'll be "shorter name than now".
>
> Basically it's strange to have a very same string for both driver and
> shrotname.  The shortname is a more detailed description usually
> including both vendor and model names while the driver is the unique
> identifier string.

(While the driver name often is name of the driver, it is also used to
select one of the configuration files in /usr/share/alsa/cards/.  The
FireWave and the LaCie speakers are often used for 'normal' 5.1 and 2.0
playback, and need different configurations, so I used different driver
names for these.

For these two devices, the driver name should stay the same.  All the
other snd-oxfw device are (semi)pro devices where it does not really
make sense to define devices like "surround51", so the driver name does
not matter and might as well be "OXFW".)

As for the shortname, it is not an internal identifier but typically
displayed to identify the device for the user.  Something like
"FWSpeakers" might be recognizable, but I'd prefer the old "FireWire
Speakers".


Regards,
Clemens
