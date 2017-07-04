From: Fulup Ar Foll <fulup.arfoll@iot.bzh>
Subject: Re: ioctl(fd, SNDRV_CTL_IOCTL_ELEM_REPLACE,
 ... not working from userspace ?
Date: Tue, 4 Jul 2017 17:20:13 +0200
Message-ID: <7a2134e7-6aab-1bcb-c7a0-7ed6b7fb9ac5@iot.bzh>
References: <c7599ba3-f6c3-bb46-c08d-efff67ca60e9@iot.bzh>
 <a8252c34-c9ac-22d9-589d-ff2af5ea1188@ladisch.de>
 <071d305a-2941-4417-4f6e-f9f7d605a510@iot.bzh>
 <bc4bbe47-3ba7-d432-0861-10023bb7fe1d@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 69936266884
 for <alsa-devel@alsa-project.org>; Tue,  4 Jul 2017 17:20:17 +0200 (CEST)
Received: by mail-wm0-f48.google.com with SMTP id 62so199459172wmw.1
 for <alsa-devel@alsa-project.org>; Tue, 04 Jul 2017 08:20:17 -0700 (PDT)
In-Reply-To: <bc4bbe47-3ba7-d432-0861-10023bb7fe1d@sakamocchi.jp>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

Thank you very much for this long and detail explanation.

I already tested user-defined control to enable missing hardware or 
expose functionalities (ex: volume ramp-up/down, or volume control on a 
Unicens network where ALSA driver does not expose any mixer interface).

It looks like renaming existing hardware controls to normalize a sound 
card API is a no go option. I may add missing capabilities but if I 
understand you correctly renaming exiting controls to make hardware 
fully transparent to the application is not an option.

In order to implement a HAL (hardware Abstraction Layer) would you 
recommend a plugin that would proxy every controls/PCM or does ALSA 
propose some other unknown API that could help ?

Cars may have pretty complex audio configuration and in the ideal world 
we would like to use a unique ALSA UCM config and make application 
completely ignorant of the actual configuration.

Fulup

On 04/07/17 02:00, Takashi Sakamoto wrote:
> Hi,
> 
> On Jul 4 2017 01:50, Fulup Ar Foll wrote:
>> At kernel level the iotcl point onto ./sound/core/control.c and calls
>> snd_ctl_elem_add_user(ctl, argp, 1) that itself calls snd_ctl_elem_add
>>
>> Looking at this code I do not understand why the replace iotcl is
>> refused. Nevertheless it seems more to come from some lacking data in ly
>> ctrlinfo than because of access right (I'm testing as root)
> 
> ALSA control core in kernel land is designed to maintain two types of
> control element set; one is added by drivers in kernel land, another is
> added by userspace applications. The macro, 'SNDRV_CTL_ELEM_ACCESS_USER'
> is for distinction of the latter type from the former type. Both type of
> control element set can be handled by userspace applications in the same
> way (read/write/poll/ioctl with SNDRV_PCM_IOCTL_XXX), however they have
> different effects.
> 
> Typically, users utilize the former type of control element set to
> configure hardware features with helps of kernel drivers. On the other
> hand, the latter type of control element set has no direct relations to
> hardware. There's a need for userspace applications to handle any events
> relevant to the latter type of control element set when achieving some
> actual effects. At present, there's a few cases to use the latter type;
> e.g. softvol PCM plugin in alsa-lib utilizes the latter control element
> set to add alternative control element set for PCM frame resampling[1].
> 
> The issued operation, SNDRV_CTL_IOCTL_ELEM_REPLACE, is designed just for
> the latter type of control element set. Therefore, you got no success
> from this operation for the former type of control element set. When
> attempting to get success, you need to add the latter type of control
> element set in advance, then issue the operation for the added control
> element set. You can see a test program in alsa-lib[2] for the latter
> type of control element set, for your information.
> 
> But I know that implementations for the latter type of control element
> set has been long-abandoned. For recent years I had been fixing them but
> some bugs might be still left, perhaps. If you still receive some errors
> from this operation for the latter type of control element set, please
> report how to reproduce it (some programs are preferable). I'm willing
> to investigate and fix the bug.
> 
> [1] src/pcm/pcm_softvol.c
> http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_softvol.c
> [2] test/user-ctl-element-set.c
> http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=test/user-ctl-element-set.c
> 
> 
> Regards
> 
> Takashi Sakamoto
> 
