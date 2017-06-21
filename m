From: Hui Wang <hui.wang@canonical.com>
Subject: Re: Dell USB audio driver workaround
Date: Wed, 21 Jun 2017 08:05:26 +0800
Message-ID: <87859ca2-cb2a-9258-cf43-99d0c2908278@canonical.com>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A32FFC@RTITMBSV09.realtek.com.tw>
 <s5h1t6jxgh5.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A33059@RTITMBSV09.realtek.com.tw>
 <s5h37qzm63e.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A330E6@RTITMBSV09.realtek.com.tw>
 <s5h4mbd93c1.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A3313B@RTITMBSV09.realtek.com.tw>
 <s5hvb3t7me0.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A332FD@RTITMBSV09.realtek.com.tw>
 <s5hlh4j18l6.wl-tiwai@suse.de>
 <70632d2d-05c9-e6d7-2ba2-b67d0d10e44a@canonical.com>
 <s5hinjybmav.wl-tiwai@suse.de>
 <d7251f99-ead2-382e-b6bf-a9f0506aaea8@canonical.com>
 <1497968348.4228.14.camel@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E856126680F
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 02:05:34 +0200 (CEST)
In-Reply-To: <1497968348.4228.14.camel@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanuk@iki.fi>, Takashi Iwai <tiwai@suse.de>
Cc: svillar@igalia.com, alsa-devel@alsa-project.org, Kailang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 06/20/2017 10:19 PM, Tanu Kaskinen wrote:
> On Thu, 2017-06-15 at 17:40 +0800, Hui Wang wrote:
>> On 06/14/2017 11:50 PM, Takashi Iwai wrote:
>>> On Wed, 14 Jun 2017 04:29:13 +0200,
>>> Hui Wang wrote:
>>>> In this thread, I added tanuk@iki.fi and svillar@igalia.com since they
>>>> reported or discussed similar bugs recently
>>>> (https://www.spinics.net/lists/alsa-devel/msg62460.html and
>>>> https://bugs.freedesktop.org/show_bug.cgi?id=100711).
>>>>
>>>> Right now, we are trying to enable the USB audio for the Dell dock
>>>> stations TB16[1] and WD15[2]. For usb audio part, they have the same
>>>> design, they use realtek alc4020 USB bridge and alc3263 codec, and
>>>> there are one headset jack on the front panel and one speaker output
>>>> jack on the rear panel, but due to some reason (probably it is the
>>>> firmware's problem), the alsa mixers can't reflect there is speaker or
>>>> headset on them, as a result the pulseaudio can't handle the headset
>>>> or speaker correctly.
>>>>
>>>> Right now, the pulseaudio can find a playback device and a record
>>>> device, it is the output and input device for that headset jack, but
>>>> pulseaudio does not think they are headphone and Mic, pulseaudio think
>>>> they are just USB analog output and input devices; for the speaker
>>>> jack, the pulseaudio can't find it at all. so through pulseaudio, we
>>>> can't play any sound to that speaker jack.
>>>>
>>>> This is the output and input devices listed by alsa-utils:
>>>>
>>>> !!Aplay/Arecord output
>>>> !!--------------------
>>>>
>>>> APLAY
>>>>
>>>> **** List of PLAYBACK Hardware Devices ****
>>>> ...
>>>> card 1: Audio [USB Audio], device 0: USB Audio [USB Audio]
>>>>     Subdevices: 1/1
>>>>     Subdevice #0: subdevice #0
>>>> card 1: Audio [USB Audio], device 1: USB Audio [USB Audio #1]
>>>>     Subdevices: 1/1
>>>>     Subdevice #0: subdevice #0
>>>>
>>>> ARECORD
>>>>
>>>> **** List of CAPTURE Hardware Devices ****
>>>> ...
>>>> card 1: Audio [USB Audio], device 0: USB Audio [USB Audio]
>>>>     Subdevices: 1/1
>>>>     Subdevice #0: subdevice #0
>>>>
>>>>
>>>>
>>>>
>>>> And we can use alsa-utils command to play sound to speaker jack:
>>>> $ aplay -D plughw:CARD=1,DEV=1 /usr/share/sounds/speech-dispatcher/test.wav
>>>>
>>>> I don't know how to fix this problem in the kernel driver, if we can
>>>> let driver export standard mixers, this issue will be fixed. But it
>>>> looks like the mixers depend on the firmware, we can't change the
>>>> firmware, so probably we can't fix it in the kernel driver.
>>> Right, there are multiple problems.  One is the firmware problem as
>>> you mentioned.  With the old firmware, the USB descriptor and the
>>> behavior of the device are unstable / inconsistent.
>>>
>>> Even with the fixed firmware, USB audio driver in general may assign
>>> PCM streams depending on the descriptor, and the name can't be set
>>> consistently per purpose.  So, it can't appear like "Headphone Stream"
>>> or "Line Out Stream".  The only sensible way I can think of is to
>>> apply some static mappings for creation of the streams, like the mixer
>>> mapping for some devices.
>>>
>>> This is, however, only a part of the iceberg.  A bigger problem is
>>> that USB-audio driver doesn't handle the jack detection usually by
>>> itself.  The jack detection part belongs to the HID, and it should be
>>> handled by a different driver.  That is, if any, PA would need to
>>> resolve the corresponding input device and deal with the input events.
>>> That's a mess.
>> Yes, the USB-audio jack detection is a bigger problem. Since the current
>> USB-audio driver does not export JACK to the userspace, the PA does not
>> check jack plugging/unplugging at all. If a USB-audio adapter is plugged
>> in, the PA will treat it as a USB headpone+microphone, will think this
>> device is ready to work, then users can select this sound card via UI
>> program to play or record sound.
>>
>>>> Another way to fix it is to add a conf to pulseaudio, in the conf, we
>>>> add one profile for headset(hw:%f,0,0) and one profile for
>>>> speaker(hw:%f,1,0), this is the draft patch I sent to
>>>> pulseaudio-discuss mail list:
>>>> https://lists.freedesktop.org/archives/pulseaudio-discuss/2017-May/028252.html
>>>>
>>>> Do you have any idea to fix this problem? Thanks in advance. And below
>>>> are some logs I collected on the TB16, if you need more logs, just
>>>> tell me, I will collect them for you.
>>> I'm in favor of the configuration specific to the device.  Still we'd
>>> need a few fixups in the kernel side, too.  Other "perfect solutions"
>>> would be hard to achieve, I'm afraid.
>> Thanks for your advice.
>>
>> Through PA, users can't select speaker (hw:%f,1,0) to work, this is a
>> more urgent problem.
>>
>> Hi Tanu,
>>
>> If you have time, could you please take a look at the patch I sent to
>> pulseaudio-discuss?
> I applied your pulseaudio patch now, sorry for the delay.
>

Thanks.
