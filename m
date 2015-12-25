From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH 1/2] ALSA: hda - Add mic mute hotkey quirk
 for Lenovo ThinkCentre AIO
Date: Fri, 25 Dec 2015 10:19:00 +0800
Message-ID: <567CA794.8030103@canonical.com>
References: <1450928798-31191-1-git-send-email-hui.wang@canonical.com>
 <s5hvb7ouz09.wl-tiwai@suse.de> <s5hpoxwuw6s.wl-tiwai@suse.de>
 <567BBD64.6080103@canonical.com> <s5hk2o4uhfx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D2DA2666DA
 for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2015 03:19:07 +0100 (CET)
In-Reply-To: <s5hk2o4uhfx.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/24/2015 09:03 PM, Takashi Iwai wrote:
> On Thu, 24 Dec 2015 10:39:48 +0100,
> Hui Wang wrote:
>> On 12/24/2015 03:45 PM, Takashi Iwai wrote:
>>> On Thu, 24 Dec 2015 07:44:22 +0100,
>>> Takashi Iwai wrote:
>>>> On Thu, 24 Dec 2015 04:46:37 +0100,
>>>> Hui Wang wrote:
>>>>> From: Kailang <kailang@realtek.com>
>>>>>
>>>>> The Lenovo ThinkCenter AIO uses Line2 (NID 0x1b) to implement the
>>>>> micmute hotkey, here we register an input device and use Line2 unsol
>>>>> event to collect the hotkey pressing or releasing.
>>>>>
>>>>> In the meanwhile, the micmute led is controlled by GPIO2, so we
>>>>> use an existing function alc_fixup_gpio_mic_mute_hook() to control
>>>>> the led.
>>>>>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Signed-off-by: Kailang <kailang@realtek.com>
>>>> Is it mandatory expose this as a key event?  I mean, wouldn't it
>>>> suffice just toggle the mic mute by the driver itself?  User-space
>>>> will get the notification by the mixer status change in anyway.
>> We implement it to be an input device just because we need to meet the
>> X11 requirement, the X11 layer capture the key event instead of mixer
>> status. After the X11 get the keycode, It will set microphone to mute
>> from userspace, it is easy to do that by the driver itself, but X11 also
>> need to know the status change, since the X11 will show up an micmute
>> OSD according to status change, and needs to save the finial status
>> before reboot or poweroff. If we don't implement the input device, we
>> have to modify the X11 layer.
> Does the mute button this machine work in that way, too?
There is no mute button on this AIO machine, there is only a micmute 
button on the right side of the monitor.


>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
