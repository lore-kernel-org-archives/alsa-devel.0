From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] alsa: support module on-demand loading for
 seq and timer
Date: Tue, 23 Nov 2010 16:56:32 +0100
Message-ID: <AANLkTi=j4XA5r4DSBdZKxLJNvoAQzR+daXu0UzjcvLo4@mail.gmail.com>
References: <1290508964.1164.3.camel@yio> <4CEBE1B1.4070906@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A910D103A9D
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 16:56:49 +0100 (CET)
Received: by gxk21 with SMTP id 21so7884gxk.38
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 07:56:48 -0800 (PST)
In-Reply-To: <4CEBE1B1.4070906@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, jkysela@redhat.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 23, 2010 at 16:45, Clemens Ladisch <clemens@ladisch.de> wrote:
> Kay Sievers wrote:
>> If CONFIG_SND_DYNAMIC_MINORS is used, assign /dev/snd/seq and
>> /dev/snd/timer the usual static minors, and export specific
>> module aliases to generate udev module on-demand loading
>> instructions: ...
>> As soon as userspace accesses any of these nodes, the in-kernel
>> module-loader will load the module, and the device can be used.
>
> Is this another mechanism than sound/core/sound.c::autoload_device()?
> Because in this case, that function can go away.

No, the kernel needs to match the minor to the module name to load.

>> +++ b/sound/core/seq/seq.c
>> +MODULE_ALIAS_CHARDEV(CONFIG_SND_MAJOR, SNDRV_MINOR_SEQUENCER);
>> +MODULE_ALIAS("devname:snd/seq");
>
> The device name that alsa-lib tries to use for autoloading is actually
> /dev/aloadSEQ.

That might need to be changed then, if something depends on that, but
nothing ever tries to open /dev/snd/seq. These names will never exist
on any usual system where CONFIG_SND_DYNAMIC_MINORS is used.

>> This is part of systemd's effort to get rid of unconditional
>> module load instructions and needless init scripts.
>
> So you're going to add the entries for card driver autoloading
> (/dev/aloadC*), too?

No, we only ever handle single-instance devices with a single fixed
dev_t, not ones with an arbitrary number of device instances.

Card drivers are loaded by hardware matches today, not on-demand, and
not by an card number.

There are no configured numbered module aliases for sound cards
anymore, that can't work with today's setups.

Kay
