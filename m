From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/11] ASoC: rt5651: Avoid duplicating DMI
 quirks between codec and machine driver
Date: Wed, 21 Feb 2018 20:23:01 +0100
Message-ID: <b2c6c047-eb86-a639-197e-b6aa1eae0ad5@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180221115452.GD8334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 3750B267071
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 20:23:03 +0100 (CET)
Received: by mail-wr0-f194.google.com with SMTP id s5so7633636wra.0
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 11:23:03 -0800 (PST)
In-Reply-To: <20180221115452.GD8334@sirena.org.uk>
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

On 21-02-18 12:54, Mark Brown wrote:
> On Tue, Feb 20, 2018 at 11:15:01PM +0100, Hans de Goede wrote:
>> Instead of duplicating the DMI quirks between the codec and machine driver,
>> add a rt5651_set_pdata() codec private function which the machine driver
>> can use to pass in pdata.
> 
> It's not clear to me that this is a great idea.  The goal in general is
> to keep as much of the CODEC configuration in the CODEC driver as
> possible so we can move more towards generic machine drivers, this is
> moving us in the opposite drection quite dramatically.

Not really, instead of having Intel/ACPI specific quirks in the codec
driver it moves everything over to pdata, so in a way this unifies the
device-tree and ACPI paths.

Also to me it seems that the Intel specific machine driver is the
logical place to put quirks for Intel platforms rather then poluting the
platform-agnostic codec driver with this.

> That might get
> in the way of improvements we could be making when we get the component
> based changes further on and can avoid having all the DPCM stuff in the
> Intel drivers.
> 
> It is really unfortunate that ACPI based systems aren't embracing
> standards here and using this mess of open coded quirks but it feels
> like the way to do this is to keep the code as close as possible to well
> designed firmware interfaces and hope that they come round.

Both devicetree and ACPI code-paths are filling pdata and that is the
only thing the codec driver cares about after this patch. so this is
using a well designed interface (but a non firmware one). I can understand
if you would prefer to use the functions from include/linux/property.h
for this, but those simply do not work for ACPI platforms atm.

If you look further in this series then quirks for at least 2 more models
are added and I expect more to show up in the future, I really do not want
to duplicate these over 2 files.

One possible solution here would be to add device-properties to the codec
i2c-device from the machine-driver using device_add_properties() and make
the codec driver consume those.

This has probe-ordering issues, but those can be worked around by exporting
something like the rt5651_apply_pdata() function from this patch and make
the machine driver call that after it has attached the properties.

I'm not sure if this extra level of indirection buys us much though, the
DT binding maintainers will not accept binding docs for these kind of
kernel internal only device-properties until there are actual DT users
of them, so for now this would mainly add a bunch of extra code for
little gain.

Regards,

Hans
