From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Intel alsa sound request for Laptops
Date: Sun, 29 Jan 2017 14:23:13 +0100
Message-ID: <8f6ead3c-32f3-fe85-b37e-b7a286e607ac@metafoo.de>
References: <DBXPR04MB334548B939F29F8E6E24790F3490@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hwpdf9nzt.wl-tiwai@suse.de>
 <DBXPR04MB334D7AB20A0F4C15ADD0CB2F3490@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5htw8j9bsu.wl-tiwai@suse.de>
 <DBXPR04MB334707A6AE3893371F3297DF3480@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hr33m9ugc.wl-tiwai@suse.de>
 <DBXPR04MB334ED59C445FC8FA14DC8EEF3480@DBXPR04MB334.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EC2C266C89
 for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2017 14:23:14 +0100 (CET)
In-Reply-To: <DBXPR04MB334ED59C445FC8FA14DC8EEF3480@DBXPR04MB334.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Frankish <john.frankish@outlook.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 01/29/2017 09:15 AM, John Frankish wrote:
>>>>>>> For two or three kernel versions of alsa divers now, HDMI has 
>>>>>>> been the default alsa device on my laptop (Dell Latitude E7240) - this does not make logical sense.
>>>>>>>
>>>>>>> In the latest kernel version I use, 4.2.9, alsa sound will not 
>>>>>>> work at all unless I load the i915 kernel driver
>>>>>>> - this does not make logical sense and means that I cannot use Xvesa.
>>>>>>>
>>>>>>> Is it possible to make an alsa feature request for analogue 
>>>>>>> sound to be the default alsa device on laptops and for alsa sound to work without the need to load the i915 kernel driver?
>>>>>>>
>>>>>> It's a configuration issue.  Pass the module option if you prefer the secondary device:
>>>>>>
>>>>>> options snd-hda-intel index=1,0
>>>>>>
>>>>> Sure, I realise I can do that, but it's not the point and it's awkward to do so with the "live CD-type" distro I use (tinycorelinux).
>>>>>
>>>>> Laptop sound should work in standalone mode by default - i.e. if 
>>>>> laptop uses analogue sound for its built-in speakers then the alsa default should be analogue sound.
>>>>>
>>>>> The above notwithstanding, analogue sound should work without needing to load the i915 kernel driver.
>>>>>
>>>> For a smart automation, use PulseAudio.  It's exactly for such a purpose.
>>>>
>>>> The kernel driver assigns each device just in the order how they are enumerated.
>>>> In the case of HD-audio, it's the order of PCI devices.
>>>> It's nothing different from any other PCI drivers.
>>>>
>>> OK, but I should not have to add bloat like pulseaudio in order to have basic sound functionality.
>>>
>> For getting the basic sound functionality, you have to set up something.
>> You're asking the high-level automation, hence you need something like PA.
>>
> I'm not asking for high level automation, I'm asking that when I boot my laptop with alsa the built-in speakers work by default

That's OK and a reasonable request. But the thing is other people want to
use other default configurations, e.g. use the speakers in their HDMI
monitor by default. This is why at the kernel level ALSA does not get
involved with policy decisions and leaves this to userspace audio policy
managers such as PulseAudio.

If you don't want to use such a policy manager that's also OK, but then you
have to take care of policy management yourself by e.g. writing a ALSA
configuration file or manually specifying your preferred audio playback
device when starting a audio playback application.
