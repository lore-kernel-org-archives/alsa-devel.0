From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HD-audio runtime PM
Date: Mon, 25 Nov 2013 11:25:46 +0100
Message-ID: <529325AA.7060208@canonical.com>
References: <s5hli0gmyxt.wl%tiwai@suse.de>	<5292EF19.1040900@canonical.com>	<s5hli0dx84h.wl%tiwai@suse.de>	<52931677.4070609@canonical.com>
 <s5hr4a4bznw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C4D52260840
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 11:25:46 +0100 (CET)
In-Reply-To: <s5hr4a4bznw.wl%tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/25/2013 10:26 AM, Takashi Iwai wrote:
> At Mon, 25 Nov 2013 10:20:55 +0100,
> David Henningsson wrote:
>>
>> On 11/25/2013 08:17 AM, Takashi Iwai wrote:
>>> At Mon, 25 Nov 2013 07:32:57 +0100,
>>> David Henningsson wrote:
>>>>
>>>> On 11/22/2013 12:57 PM, Takashi Iwai wrote:
>>>>> Hi,
>>>>>
>>>>> after my previous fix, the runtime PM seems working stably finally.
>>>>> However, there seem still some glitches:
>>>>>
>>>>> 1. The wakeup via jack or HDMI/DP detection doesn't seem to work on my
>>>>>   test machines.  WAKEEN is set properly.  And its value can be read
>>>>>   correctly at the point of runtime resume, too.
>>>>
>>>> Hi and thanks for working on this.
>>>>
>>>> I've been trying to reproduce the above, but I can't seem to activate
>>>> runtime PM at all. I can't seem to get a callback to runtime_suspend,
>>>> and further investigation shows that
>>>> /sys/class/sound/card0/power/runtime_status shows "unsupported".
>>>
>>> You need to adjust power/control of the parent PCM device,
>>> i.e. /sys/devices/pci/*/power/control.  The following udev rule should
>>> work for HD-audio.  Give it a try.
>>>
>>>   ACTION=="add", SUBSYSTEM=="pci", ATTR{class}=="0x040300", TEST=="power/control", ATTR{power/control}="auto"
>>
>> I tried this rule, but it did not make any difference -
>> /sys/class/sound/card0/device/power/control was still on. (And I did
>> proofread the rule...)
> 
> This (and other sound/*) doesn't matter.  Only the entry in the PCI
> device counts.  It's the runtime PM of the PCI device after all.
> (Remember that the runtime PM callbacks are set only on this device.)

But /sys/class/sound/card0/device is just a symlink for
/sys/devices/pci0000:00/0000:00:03.0 - is this not the PCI device you're
talking about?

Anyway, power/runtime_status is always active, and power/usage_count is
always 1. (And pulseaudio is not running, and nothing else is using any
/dev/snd/* files.)

> You can put a printk in azx_runtime_suspend().  For Haswell, it should
> work as is with 3.13-rc1.

I guess I could test that, but I doubt it would help...

> For IvyBridge, check sound-unstable test/hda branch.  I'll try to
> merge to sound git tree once after brushing up and submitting for
> review.

Ok. I currently have nothing Ivybridge to check with.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
