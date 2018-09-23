From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/7] ALSA: core: Add managed card creation
Date: Sun, 23 Sep 2018 17:08:14 +0900
Message-ID: <e42b6193-a0ac-dad8-b9fd-4920a6e157c5@sakamocchi.jp>
References: <20180920155502.7534-1-tiwai@suse.de>
 <20180920155502.7534-3-tiwai@suse.de>
 <3e095236-3b06-c8b3-220b-6af99bc65c9e@sakamocchi.jp>
 <s5hd0t7uzqr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id CDE722676A7
 for <alsa-devel@alsa-project.org>; Sun, 23 Sep 2018 10:08:19 +0200 (CEST)
Received: by mail-pl1-f194.google.com with SMTP id b97-v6so7804130plb.0
 for <alsa-devel@alsa-project.org>; Sun, 23 Sep 2018 01:08:19 -0700 (PDT)
In-Reply-To: <s5hd0t7uzqr.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 21 2018 15:32, Takashi Iwai wrote:
> On Fri, 21 Sep 2018 05:01:31 +0200,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> On Sep 21 2018 00:54, Takashi Iwai wrote:
>>> Per popular demands, this patch adds a new ALSA core API function,
>>> snd_devm_card_new(), to create a snd_card object in a managed way via
>>> devres.  When a card object is created by this new function, it's
>>> released automatically at the device release.  It includes also the
>>> call of snd_card_free().
>>>
>>> However, the story isn't that simple.  A caveat is that We have to
>>> call snd_card_new(), more specifically, the disconnection part, at
>>> very first of the whole resource release procedure.  This assures that
>>> the exposed devices are deleted and sync with the all accessing
>>> processes getting closed.
>>>
>>> For achieving it, snd_card_register() adds a new devres action to
>>> trigger snd_card_free() automatically when the given card object is a
>>> "managed" one.  Since usually snd_card_register() is the last step of
>>> the initialization, this should work in most cases.
>>>
>>> With all these tricks, some drivers can get rid of the whole the
>>> driver remove callback.
>>>
>>> About a bit of implementation details: the patch adds two new flags to
>>> snd_card object, managed and releasing.  The former indicates that the
>>> object was created via snd_devm_card_new(), and the latter is used for
>>> avoiding the double-free of snd_card_free() calls.  Both flags are
>>> fairly internal and likely uninteresting to normal users.
>>>
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>>    include/sound/core.h |  5 +++
>>>    sound/core/init.c    | 95 ++++++++++++++++++++++++++++++++++++++++++--
>>>    2 files changed, 96 insertions(+), 4 deletions(-)
>>
>> In my opinion, the new 'snd_devm_card_new()' is not good in hot-plug
>> scenario. It brings kernel oops for processes to touch released device
>> data relevant to target devices.
>>
>> For example, for devices connected to each buses, some helper
>> functions are available to up/down reference count of 'struct device':
>>   - PCIe: pci_dev_get()/pci_dev_put()
>>   - USB: usb_get_intf()/usb_put_intf()
>>   - IEEE 1394: fw_unit_get()/fw_unit_put()
>>
>> In hot-plug scenario, drivers need to increment the reference counter in
>> .probe() callback. In .remove/.disconnect callback, the reference
>> counter should be kept but just set disconnect state to sound
>> card/device instances. When .private_free callback of sound card device,
>> the reference is decremented. This is required to enable userspace
>> applications to handle disconnect processes and avoid kernel oops by
>> touching released device data related to the connected bus.
>>
>> As a quick glance, existent drivers for devices on PCIe/USB are not
>> programmed with enough care of this point. It's prior to fix them for
>> your 'caveat'.
>>
>> ...but it's likely for me to get wrong understanding design of whole
>> existent driver in sound subsystem. I'm happy to receive your
>> indications against my misunderstanding.
> 
> It should work as long as the whole remove procedure is performed
> after snd_card_free().  With the use of devres, typically you can drop
> the whole remove() callback, and that's it.
> 
> Basically a device hot-unplug is nothing but the driver unbinding from
> the device.  Under the normal situation, the driver core calls its
> remove() callback, then releases the rest via devres in the reverse
> order.  When remove() is empty, it'll just perform the devres release.
> So, when snd_card_free() is performed at the beginning of devres
> release, the call order is as if you were calling snd_card_free() at
> remove() callback.

I'm OK to discuss for a case of unbinding as more-popular cases.

> The snd_card_free() syncs with the release of the all active files,
> i.e. it waits until all accesses get released, then proceed to the
> further procedures to free resources, including the call of
> private_free.  Hence this call itself should be safe, as long as it's
> called at first.

I overlooked that snd_card_free() calls 'wait_for_completion()'. Thanks
for your indication. As you said, no worries.

Here I have another concern about timing for processes to return from
unbinding operation. For example:

echo '0000:0a:00.1' > /sys/bus/pci/drivers/snd_hda_intel/unbind

This process returns when the other processes close all of ALSA
character devices related to the sound card because wait for completion
is executed in context of the process. Well-programmed userspace
applications are expected to release the character devices when
received -ENODEV from ioctl(2) or EPOLLERR/EPOLLNVAL from poll(2) to
the character devices.

I don't know exactly that it's acceptable to block a process which
performs unbinding, depending on behaviours of the other processes.
In a point of safe ABI, it's worth for us to consider or decide a
policy for the point.

> The rest of resource free is left to devres, and devres guarantees the
> resource free in the reverse order.  That's the reason that it'd be
> best to use devres for the whole resources.  Mixing up both devres and
> normal resources needs a careful handling of the release order.


Thanks

Takashi Sakamoto
