From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ALSA: hda - Add mic mute hotkey quirk
 for Lenovo ThinkCentre AIO
Date: Thu, 24 Dec 2015 17:39:48 +0800
Message-ID: <567BBD64.6080103@canonical.com>
References: <1450928798-31191-1-git-send-email-hui.wang@canonical.com>
 <s5hvb7ouz09.wl-tiwai@suse.de> <s5hpoxwuw6s.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hpoxwuw6s.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/24/2015 03:45 PM, Takashi Iwai wrote:
> On Thu, 24 Dec 2015 07:44:22 +0100,
> Takashi Iwai wrote:
>> On Thu, 24 Dec 2015 04:46:37 +0100,
>> Hui Wang wrote:
>>> From: Kailang <kailang@realtek.com>
>>>
>>> The Lenovo ThinkCenter AIO uses Line2 (NID 0x1b) to implement the
>>> micmute hotkey, here we register an input device and use Line2 unsol
>>> event to collect the hotkey pressing or releasing.
>>>
>>> In the meanwhile, the micmute led is controlled by GPIO2, so we
>>> use an existing function alc_fixup_gpio_mic_mute_hook() to control
>>> the led.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Kailang <kailang@realtek.com>
>> Is it mandatory expose this as a key event?  I mean, wouldn't it
>> suffice just toggle the mic mute by the driver itself?  User-space
>> will get the notification by the mixer status change in anyway.
We implement it to be an input device just because we need to meet the 
X11 requirement, the X11 layer capture the key event instead of mixer 
status. After the X11 get the keycode, It will set microphone to mute 
from userspace, it is easy to do that by the driver itself, but X11 also 
need to know the status change, since the X11 will show up an micmute 
OSD according to status change, and needs to save the finial status 
before reboot or poweroff. If we don't implement the input device, we 
have to modify the X11 layer.


> More specifically, what I thought of is symmetry: if a mute switch is
> implemented in a hard-coded way, we may follow the similar logic for
> the mic mute, too.  OTOH, if a mute switch is handled in an open way
> using the normal key code, we should follow that for the mic mute,
> too, like this patch provides.
After the X11 get the keycode, It will do some change for this keycode 
((8bit)XF11keycode=keycode+0x10).  The keycode of KEY_MUTE is 113, it is 
ok to do the change, but the keycode of KEY_MICMUTE is 248, It will 
overflow if add 0x10 to it, so the X11 developer choose another keycode 
to be the micmute, the keycode they chose is KEY_F20.

If you search XF86AudioMicMute in the xkeyboard-config-2.14/symbols/inet 
(in the 2.14 tarball file) of 
http://freedesktop.org/wiki/Software/XKeyboardConfig/, you will find the 
keycode map to X11 micmute is KEY_F20 instead of KEY_MICMUTE.

>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
