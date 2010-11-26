From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: ALSA Multichannel through HDMI
Date: Fri, 26 Nov 2010 04:16:45 +0200
Message-ID: <4CEF188D.9040605@iki.fi>
References: <20100112045102.GA29735@localhost>	<20100113045238.GB26275@localhost>	<eb9000ab1001122055s54bc6697t6103def1e8ae64ae@mail.gmail.com>	<20100113050254.GA28475@localhost>	<AANLkTim8zHRTc0F2CcfoXtxDkH2kpYajCuheo7GoQ4zW@mail.gmail.com>	<ickmvo$kkf$1@dough.gmane.org>	<AANLkTi=d7RHy4KgSS7yB+deAq=JnFabbA9qfwH8WQCG2@mail.gmail.com>	<4CEE3F1E.4010405@iki.fi>	<AANLkTikYpKak6C5Oz=c0OxiG8FaD2qqzn7siW0kMJgzs@mail.gmail.com>	<4CEE4B29.5090808@iki.fi>	<AANLkTi=9SMLG1vYjDAPUjQJaBwzOJSMchbE+oUVGcgRN@mail.gmail.com>	<4CEEB6DF.2060905@iki.fi>	<AANLkTim7O0vvRcQdYBmTNDnBwFhF-RskfOLtbCnKU_5M@mail.gmail.com>	<4CEEE9F9.6040405@iki.fi>	<AANLkTikRP7WnWc1k20qW-nZtOtNcfNimVOcxbf2uC8jD@mail.gmail.com>	<4CEEEE0C.9090803@iki.fi>	<AANLkTikS4C6GS2EuqdA_D58y4h9qCMBEWPSoO7JdhC9g@mail.gmail.com>	<AANLkTi=4CjtW0dY=1
 =kbPXEUu5N8MWYAoudMq409nKTi@mail.gmail.com>	<4CEF067C.8090807@iki.fi>	<AANLkTim9T0-oVTi1PZxD86y0y2YKX5Ctcm3eG63U7i0X@mail.gmail.com>
	<AANLkTimoyrYASyD4g0nv+F81Lcsg=Y23caXKVF5hyK_C@mail.gmail .com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sypressi.dnainternet.net (sypressi.dnainternet.net
	[83.102.40.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 05C84103C9C
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 03:16:50 +0100 (CET)
In-Reply-To: <AANLkTimoyrYASyD4g0nv+F81Lcsg=Y23caXKVF5hyK_C@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Ettedgui <john.ettedgui@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 26.11.2010 04:02, John Ettedgui wrote:
> On Thu, Nov 25, 2010 at 5:08 PM, John Ettedgui <john.ettedgui@gmail.com> wrote:
>> On Thu, Nov 25, 2010 at 4:59 PM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
>>> On 26.11.2010 02:53, John Ettedgui wrote:
>>>> On Thu, Nov 25, 2010 at 3:34 PM, John Ettedgui <john.ettedgui@gmail.com> wrote:
>>>>> On Thu, Nov 25, 2010 at 3:15 PM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
>>>>>> On 26.11.2010 01:11, John Ettedgui wrote:
>>>>>>> On Thu, Nov 25, 2010 at 2:58 PM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
>>>>>>>> On 26.11.2010 00:42, John Ettedgui wrote:
>>>>>>>>> On Thu, Nov 25, 2010 at 11:19 AM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
>>>>>>>>>> On 25.11.2010 14:21, John Ettedgui wrote:
>>>>>>>>>>> On Thu, Nov 25, 2010 at 3:40 AM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
>>>>>>>>>>>> On 25.11.2010 13:09, John Ettedgui wrote:
>>>>>>>>>>>>> On Thu, Nov 25, 2010 at 2:49 AM, Anssi Hannula <anssi.hannula@iki.fi> wrote:
>>>>>>>>>>>>>> On 25.11.2010 06:12, John Ettedgui wrote:
>>>>>>>>>>>>>>> I'm actually trying to get a 5.1 setup working without passthrough, if
>>>>>>>>>>>>>>> I use mplayer with passthrough my receiver behaves just fine, but I am
>>>>>>>>>>>>>>> trying to send the 6 channels from the computer.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I was actually told that the current ALSA driver for radeon's hdmi
>>>>>>>>>>>>>>> does not support more than 2 channels, and that would explain why I'm
>>>>>>>>>>>>>>> getting this behavior. Is that true though?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Yes.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> However, strangely your log output seems to show the intel's hdmi parser
>>>>>>>>>>>>>> being used instead:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> ALSA sound/pci/hda/patch_intelhdmi.c:842: hdmi_setup_stream: NID=0x2,
>>>>>>>>>>>>>>> stream=0x1, new-format=0x11
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Were you just trying some patch at the time?
>>>>>>>>>>>>>
>>>>>>>>>>>>> yes Wu gave me a patch to try against the kernel, I'm guessing this is
>>>>>>>>>>>>> the reason you see something unexpected.
>>>>>>>>>>>>
>>>>>>>>>>>> Did 6 channels work with that patch? (possibly with a wrong channel order)
>>>>>>>>>>> Not any better as far as I remember.
>>>>>>>>>>
>>>>>>>>>> OK. Did 2 channel audio continue to work with it?
>>>>>>>>>>
>>>>>>>>>> If you are not sure, here's the patch doing the same thing against
>>>>>>>>>> current alsa driver:
>>>>>>>>>> http://stuff.onse.fi/0001-ALSA-hda-Use-generic-HDMI-code-for-ATI-HDMI-codecs.patch
>>>>>>>>>>
>>>>>>>>>> Confirming that would help (it would allow to switch the ATI chip to use
>>>>>>>>>> the generic parser instead of the ATI-specific one), though not with the
>>>>>>>>>> multichannel issue (see below).
>>>>>>>>>>
>>>>>>>>>> [...]
>>>>>>>>>>
>>>>>>>>>>>>> Since I just moved to jack/rca cables I'm in no hurry anymore, but is
>>>>>>>>>>>>> there any reason why the driver cannot work with more than 2 channels?
>>>>>>>>>>>>
>>>>>>>>>>>> I don't really know (it is simply not implemented).
>>>>>>>>>>> Alright.
>>>>>>>>>>>>
>>>>>>>>>>>>> Anything I could do to help with that?
>>>>>>>>>>>>
>>>>>>>>>>>> Possibly. But see above, so that we won't try the same things you
>>>>>>>>>>>> already tried :)
>>>>>>>>>>>>
>>>>>>>>>>> Sure :)
>>>>>>>>>>
>>>>>>>>>> Looking again at the the alsa info output you provided, I don't think I
>>>>>>>>>> have any great ideas. It looks like the chip simply reports that it
>>>>>>>>>> supports a maximum of 2 channels.
>>>>>>>>>>
>>>>>>>>>> One option could be hardcoding "chans = 8;" in generic_hdmi_build_pcms()
>>>>>>>>>> in sound/pci/hda/patch_hdmi.c (assuming you have the above patch and 2
>>>>>>>>>> channel audio works with it). However, I find it rather unlikely that it
>>>>>>>>>> would make any difference.
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> Anssi Hannula
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Anssi,
>>>>>>>>> the patch fails on my kernel, I cannot find the hda_codec_preset
>>>>>>>>> manually in there either.
>>>>>>>>> Did you want me to try that against a 2.6.37 rc instead of a 2.6.36?
>>>>>>>>
>>>>>>>> For 2.6.36 I think you can just use your earlier patch.
>>>>>>>>
>>>>>>>> Note that on that kernel generic_hdmi_build_pcms() is
>>>>>>>> intel_hdmi_build_pcms() in patch_intelhdmi.c.
>>>>>>>>
>>>>>>> ok
>>>>>>>> BTW, I've just been informed by another ATI user that his card was
>>>>>>>> actually stereo-only, while he thought earlier it was multichannel
>>>>>>>> capable. So, are you sure your card is a multichannel one?
>>>>>>>> (if not, it would explain why the card says it is not)
>>>>>>>>
>>>>>>>> --
>>>>>>>> Anssi Hannula
>>>>>>>>
>>>>>>> Yes, it works fine in Window  so I believe the hardware part is good.
>>>>>>
>>>>>> And you are sure it is multichannel PCM, and not e.g. multichannel DTS
>>>>>> or multichannel AC-3 with on-the-fly compression, which are possible
>>>>>> with stereo hdmi as well?
>>>>>>
>>>>>> Just making sure :)
>>>>>>
>>>>>> --
>>>>>> Anssi Hannula
>>>>>>
>>>>>
>>>>> Well, I have not super tested it, but the reason I believe it is is
>>>>> simple, when I use passthrough my receiver says Dolby digital or
>>>>> something like that, but in Windows just going around or playing games
>>>>> it says Multichannel.
>>>
>>> Sounds ok then.
>>>
>>>>> I'll get the patch applied in a few minutes, I was running out of
>>>>> memory and my system was getting really slow... :)
>>>>>
>>>>
>>>> I am not sure if I did it right but now I don't even get hdmi sound
>>>> working anymore.
>>>> It is not listed in aplay-l, and dmesg gives me this:
>>>> [drm:radeon_dvi_detect] *ERROR* HDMI Type A-1: probed a monitor but
>>>> no|invalid EDID
>>>>
>>>> I've attached the patch I used, since I could not used the previous
>>>> one I had to hack it, maybe I broke something?
>>>> (I have not set channels to 8 yet, just changed the parser)
>>>
>>> The patch looks ok. The above error message is weird, as it comes from
>>> the display driver which should not be affected by the patch at all.
>>>
>>> I'll look at the code later (tomorrow maybe). Until then I'd advise you
>>> to retry without the patch and with the patch again, just to make sure
>>> this is not some unrelated issue...
>>> Also, post the whole dmesg when it works (2 channel, without patch), and
>>> when it doesn't (with patch).
>>>
>>> --
>>> Anssi Hannula
>>>
>> Following your message I restarted my computer and that error was
>> gone, yet there is still nothing display in aplay -l / aplay -L about
>> hdmi anymore.
>> I'll go back to my non patched kernel and see what it does.
>>
> With the non-patched kernel I get back my hdmi in aplay -l, so it
> looks like the patch messed up something.

Indeed.

> I really think that when I tried it before it did not do that, but it
> was so long ago that I could be wrong...

Well, the driver has changed since then, it could be more strict now :)

> Anyway here are the 2 dmesgs (not sure if they'll help though).

Indeed, there doesn't seem to be any difference. Maybe try with
CONFIG_SND_DEBUG_VERBOSE?

-- 
Anssi Hannula
