From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/4] ALSA: firewire: block .remove callback
	of bus
Date: Wed, 10 Oct 2018 17:14:12 +0900
Message-ID: <799718ca-e4c5-9122-00f8-8ae5f6db9589@sakamocchi.jp>
References: <20181010063502.4698-1-o-takashi@sakamocchi.jp>
 <s5hy3b6e0ys.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 47D312677F0
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2018 10:14:18 +0200 (CEST)
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so2141958pgq.5
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2018 01:14:17 -0700 (PDT)
In-Reply-To: <s5hy3b6e0ys.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 10 2018 16:04, Takashi Iwai wrote:
> On Wed, 10 Oct 2018 08:34:58 +0200,
> Takashi Sakamoto wrote:
>> In a discussion for devres support[1], I realize difference of unbind
>> behaviour of drivers in ALSA firewire stack and in the others. For
>> consistency behaviour inner the same subsystem for users, it's better
>> to imitate the behaviour.
>>
>> Additionally, blocking .remove function simplifies codes to releasing
>> device.
>>
>> This commit uses 'snd_card_free()' instead of
>> 'snd_card_free_when_closed()' in .remove function and performs
>> refactoring for release codes.
> 
> Would the hot-unplug behavior change with this patch?
> 
> For most of other drivers (but for USB), the actual hot-plug/unplug
> are unlikely scenario, hence blocking makes sense to assure the safety
> unbind.  (Yes, there is also PCI hotplug, but an audio device is
> rarely used there.)
> 
> But, FireWire is a beast to be plugged / unplugged more often, so the
> hot-unplug behavior change is more important to users.

In a point of user experience, a slight change there is. From ether bus
driver or sysfs nodes, unbind operation is successful. But it's blocked
till all ALSA character devices are released. The user use 'unbind'
sysfs node, command execution waits. In typical use cases of
desktop environment, it waits that pulseaudio releases the last ALSA
control character device.

In bus driver for IEEE 1394 bus, a call of .remove in device driver is
done in workqueue. This bus operations runs without blocking.

If unbind operation is blocked in command line, it means that any
program runs without no care of state of ALSA character devices. For
example, current implementation of alsactl has this bug in its monitor
mode[1]. The blocking state reminds users of this kind of bug of any
applications.

Anyway, hot-plugging/unplugging are still available.

Rather than the slight change, this patchset performs refactoring codes
for releasing devices. This removes complications of current code and
simplify error paths.

[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-September/140580.html

Thanks

Takashi Sakamoto
