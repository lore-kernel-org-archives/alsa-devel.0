From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v8 0/7] TDA1997x HDMI video reciver
Date: Wed, 7 Feb 2018 10:09:14 +0100
Message-ID: <7cf38465-7a79-5d81-a995-9acfbacf5023@xs4all.nl>
References: <1517948874-21681-1-git-send-email-tharvey@gateworks.com>
 <c7771c44-a9ff-0207-38f6-28bcc06ccdee@xs4all.nl>
 <CAJ+vNU1oiM0Y0rO-DHi57nVOqnw60A7pn_1=h5b46-BrY7_p2Q@mail.gmail.com>
 <605fd4a8-43ab-c566-57b6-abb1c9f8f0f8@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <605fd4a8-43ab-c566-57b6-abb1c9f8f0f8@xs4all.nl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: linux-media <linux-media@vger.kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Steve Longerbeam <slongerbeam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>
List-Id: alsa-devel@alsa-project.org

On 02/07/18 09:22, Hans Verkuil wrote:
> On 02/07/2018 12:29 AM, Tim Harvey wrote:
>> Media Controller ioctls:
>>                 fail: v4l2-test-media.cpp(141): ent.function ==
>> MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN
> 
> Weird, this shouldn't happen. I'll look into this a bit more.

Can you run 'mc_nextgen_test -e -i' and post the output?

It's found in contrib/test.

Thanks!

	Hans
