From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v4 3/5] media: i2c: Add TDA1997x HDMI
	receiver driver
Date: Thu, 14 Dec 2017 15:26:57 +0100
Message-ID: <bce9c2cb-060a-afc2-4ce5-1e2c90c241a5@xs4all.nl>
References: <1511990397-27647-1-git-send-email-tharvey@gateworks.com>
 <1511990397-27647-4-git-send-email-tharvey@gateworks.com>
 <1a1be5d7-caed-6cba-c97a-dbb70e119fa3@xs4all.nl>
 <CAJ+vNU0NKZizung9+1zsd1RZBrDbBgk+A8mVJ76bQysjCUoaKw@mail.gmail.com>
 <CAJ+vNU1L5MkP0DuiwjKXY75id3Brzq+9M9DfcZOXbvzVgaUdXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb3-smtp-cloud9.xs4all.net (lb3-smtp-cloud9.xs4all.net
 [194.109.24.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 5390826732A
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 15:26:59 +0100 (CET)
In-Reply-To: <CAJ+vNU1L5MkP0DuiwjKXY75id3Brzq+9M9DfcZOXbvzVgaUdXQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, linux-media <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 14/12/17 00:35, Tim Harvey wrote:
>>> Close. What is missing is a check of the AVI InfoFrame: if it has an explicit
>>> colorimetry then use that. E.g. check for HDMI_COLORIMETRY_ITU_601 or ITU_709
>>> and set the colorspace accordingly. Otherwise fall back to what you have here.
>>>
>>
>> This function currently matches adv7604/adv7842 where they don't look
>> at colorimetry (but I do see a TODO in adv748x_hdmi_fill_format to
>> look at this) so I don't have an example and may not understand.
>>
>> Do you mean:
>>
>>        format->colorspace = V4L2_COLORSPACE_SRGB;
>>        if (bt->flags & V4L2_DV_FL_IS_CE_VIDEO) {
>>                 if ((state->colorimetry == HDMI_COLORIMETRY_ITU_601) ||
>>                     (state->colorimetry == HDMI_COLORIMETRY_ITU_709))
>>                         format->colorspace = state->colorspace;
>>                 else
>>                         format->colorspace = is_sd(bt->height) ?
>>                                 V4L2_COLORSPACE_SMPTE170M :
>> V4L2_COLORSPACE_REC709;
>>         }
>>
>> Also during more testing I've found that I'm not capturing interlaced
>> properly and know I at least need:
>>
>> -        format->field = V4L2_FIELD_NONE;
>> +        format->field = (bt->interlaced) ?
>> +                V4L2_FIELD_ALTERNATE : V4L2_FIELD_NONE;
>>
>> I'm still not quite capturing interlaced yet but I think its an issue
>> of setting up the media pipeline improperly.
>>
> 
> Hans,
> 
> Did you see this question above? I'm not quite understanding what you
> want me to do for filling in colorspace and don't see any examples in
> the existing drivers that appear to look at colorimetry for this.

Yeah, I missed that question. I started answering that yesterday, but then
I realized that it would be better if I would make a helper function for
v4l2-dv-timings. The rules are complex so coding that in a single place
that everyone can use is the smart thing to do.

I hope to finish it tomorrow (too many interruptions today).

Regards,

	Hans
