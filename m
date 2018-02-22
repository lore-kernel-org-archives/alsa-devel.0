From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/11] ASoC: rt5651: Avoid duplicating DMI
 quirks between codec and machine driver
Date: Thu, 22 Feb 2018 21:38:05 +0100
Message-ID: <8107ea4e-6f28-c31a-45bb-da80afecd137@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180221115452.GD8334@sirena.org.uk>
 <b2c6c047-eb86-a639-197e-b6aa1eae0ad5@redhat.com>
 <cc96d6a4-c8a5-1df5-8410-7671a73e6d4a@redhat.com>
 <20180222113548.GF5905@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C89A26782E
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 21:38:07 +0100 (CET)
Received: by mail-wr0-f195.google.com with SMTP id 34so11900926wre.13
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 12:38:07 -0800 (PST)
In-Reply-To: <20180222113548.GF5905@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 22-02-18 12:35, Mark Brown wrote:
> On Thu, Feb 22, 2018 at 12:08:29PM +0100, Hans de Goede wrote:
> 
>> So thinking more about this I think that having the codec driver only
>> check device-properties and completely killing platform_data is the best
>> way forward / best way to clean this up.
> 
>> Combined with either device-tree or the machine driver setting these device
>> properties for now, and in the future the ACPI tables can set these properties
>> directly and we can hopefully won't need to add new quirks to the machine
>> driver.
> 
> The device properties thing seems reasonable enough.  I'm still not
> super convinced the machine driver is the right place, but let's see the
> code.  I think ideally the arch code would have a way to put all the
> device property based quirks for these systems like we IIRC do for some
> DT fixups.

We've already tried something like that for fixing a similar situation
(not enough info in ACPI for the driver to function) for silead
touchscreens:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/platform/x86/silead_dmi.c

Note that this device-property providing driver can only be
builtin, it cannot be built as a module (otherwise we're back
to having ordering issues). We (Dmitry and I) have gotten quite
some flack about needlessly growing the bzImage size with data
only used on a small subset of x86 devices and this construction
is not something which I want to repeat (nor would advise
others to repeat).

We really need to have a way to have these quirks table in a module
which only loads on devices which need it. So in my mind the
machine driver is a good place for this.

Regards,

Hans
