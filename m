From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/2] ALSA: control: limit life time of
 user-defined element set
Date: Tue, 6 Sep 2016 11:16:28 +0900
Message-ID: <6cc7e474-64f0-d74e-61bd-e6428929f984@sakamocchi.jp>
References: <1472983616-16254-1-git-send-email-o-takashi@sakamocchi.jp>
 <c05a8424-724d-89a1-7a70-c2365420d7d7@ladisch.de>
 <s5hpoojd3k8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 2D77E2666AC
 for <alsa-devel@alsa-project.org>; Tue,  6 Sep 2016 04:16:31 +0200 (CEST)
In-Reply-To: <s5hpoojd3k8.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: jimmy@spalge.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 5 2016 01:37, Takashi Iwai wrote:
> On Sun, 04 Sep 2016 17:38:20 +0200,
> Clemens Ladisch wrote:
>>
>> Takashi Sakamoto wrote:
>>> ALSA control core allows applications to add arbitrary element sets to an
>>> instance of control device, while removal of the element sets is voluntarily
>>> done by some applications. This is not convenient to certain situations.
>>
>> This was originally designed for softvol, where the user-defined element
>> should behave as much as possible as a hardware control.
>>
>>> My large concern is whether there's any applications to open a file descriptor
>>> just to add any element sets.
>>
>> alsactl restore
>
> Yes, and this is actually 99% of use cases for now: restoring the
> persistent softvol element at the boot time.

Aha. I didn't realize alsactl calls library APIs to add control element 
sets. I was just aware of PCM softvol plugin. Thanks for your notification.

> A similar idea to implement a process-bound user-space kctl has popped
> up a few times in the past, but it's never realized, since no one
> could find it really useful / demanded.

For my information, if possible, would you please show pointers to the 
proposals?

> You may say that it can be used for some application-specific volume or
> such, but what would be it exactly?

I have a plan for a daemon program in user land. It allows ALSA 
applications to control DSP configurations of audio and music units on 
IEEE 1394 bus, via ALSA control character device.

Currently, drivers for the units are in ALSA firewire stack[1], while 
they support no control elements, just support packet streaming 
functionality, because we can achieve it in user land. For example, 
there're already some Python 3 scripts in hinawa-utils[2] to configure 
the units from user space via firewire character device, with a help of 
libhinawa[3].

When detecting some audio and music units on IEEE 1394 bus, the daemon 
program adds some element sets and start listening to them. If ALSA 
control applications changes state of elements in the element sets, the 
daemon catches the event and configure these units by hardware-specific 
ways.

Currently, this idea is just for audio and music units on IEEE 1394 bus. 
But I think we can utilize it for USB audio devices with vendor-specific 
features, without adding more vendor-dependent codes to kernel land.

> Once when we have a real use case, I'm not against adding such a
> change.  But of course as long as it doesn't break the current way of
> softvol usage with the persistent user kctl.

Apparently, this patch breaks the combination of 'PCM softvol plugin' 
and 'alsactl restore'. I think it better to add a new flag such as 
'SNDRV_CTL_ELEM_ACCESS_USER_BOND_TO_FD' to perform automatic removal.

[1] 
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/firewire
[2] https://github.com/takaswie/hinawa-utils/
[3] https://github.com/takaswie/libhinawa/


Regards

Takashi Sakamoto
