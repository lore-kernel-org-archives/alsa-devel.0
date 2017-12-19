From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v5 4/6] media: i2c: Add TDA1997x HDMI receiver driver
Date: Tue, 19 Dec 2017 12:49:06 +0100
Message-ID: <CAOFm3uGB13QHDHOyS7MNfhBa+=HPWyVDtboHhw2R3K0PTLHaJQ@mail.gmail.com>
References: <1513447230-30948-1-git-send-email-tharvey@gateworks.com>
 <1513447230-30948-5-git-send-email-tharvey@gateworks.com> <3ae0ee4d-e754-1e97-33ed-d1fedf442dfb@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ae0ee4d-e754-1e97-33ed-d1fedf442dfb@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Steve Longerbeam <slongerbeam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Hans Verkuil <hverkuil@xs4all.nl>
List-Id: alsa-devel@alsa-project.org

Tim,

On Tue, Dec 19, 2017 at 12:12 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> On 16/12/17 19:00, Tim Harvey wrote:
>> Add support for the TDA1997x HDMI receivers.
>>
>> Cc: Hans Verkuil <hverkuil@xs4all.nl>
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

<snip>

>> --- /dev/null
>> +++ b/drivers/media/i2c/tda1997x.c
>> @@ -0,0 +1,3520 @@
>> +/*
>> + * Copyright (C) 2017 Gateworks Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + */

Would you mind using the new SPDX tags documented in Thomas patch set
[1] rather than this fine but longer legalese?  Thank you!

[1] https://lkml.org/lkml/2017/12/4/934

--
Cordially
Philippe Ombredanne
