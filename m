From: Sylwester Nawrocki <snjw23@gmail.com>
Subject: Re: [GIT PULL FOR 2.6.39] Media controller and OMAP3 ISP driver
Date: Sat, 05 Mar 2011 15:29:08 +0100
Message-ID: <4D7248B4.9090003@gmail.com>
References: <201102171606.58540.laurent.pinchart@ideasonboard.com>	<201103031125.06419.laurent.pinchart@ideasonboard.com>	<4D71471D.6060808@redhat.com>	<201103051252.12342.hverkuil@xs4all.nl> <AANLkTi=SS3CBkKUdovU33SQi=s9gNprZszKaMrkRGqGy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=SS3CBkKUdovU33SQi=s9gNprZszKaMrkRGqGy@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab@redhat.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, alsa-devel@alsa-project.org, Sakari Ailus <sakari.ailus@retiisi.org.uk>, Pawel Osciak <pawel@osciak.com>
List-Id: alsa-devel@alsa-project.org

Hi David,

On 03/05/2011 02:04 PM, David Cohen wrote:
> Hi Hans,
> 
> On Sat, Mar 5, 2011 at 1:52 PM, Hans Verkuil<hverkuil@xs4all.nl>  wrote:
>> On Friday, March 04, 2011 21:10:05 Mauro Carvalho Chehab wrote:
>>> Em 03-03-2011 07:25, Laurent Pinchart escreveu:
...
>>>>        v4l: Group media bus pixel codes by types and sort them alphabetically
>>>
>>> The presence of those mediabus names against the traditional fourcc codes
>>> at the API adds some mess to the media controller. Not sure how to solve,
>>> but maybe the best way is to add a table at the V4L2 API associating each
>>> media bus format to the corresponding V4L2 fourcc codes.
>>
>> You can't do that in general. Only for specific hardware platforms. If you
>> could do it, then we would have never bothered creating these mediabus fourccs.
>>
>> How a mediabus fourcc translates to a pixelcode (== memory format) depends
>> entirely on the hardware capabilities (mostly that of the DMA engine).
> 
> May I ask you one question here? (not entirely related to this patch set).
> Why pixelcode != mediabus fourcc?
> e.g. OMAP2 camera driver talks to sensor through subdev interface and
> sets its own output pixelformat depending on sensor's mediabus fourcc.
> So it needs a translation table mbus_pixelcode ->  pixelformat. Why
> can't it be pixelformat ->  pixelformat ?
> 

Let me try to explain, struct v4l2_mbus_framefmt::code (pixelcode)
describes how data is transfered/sampled on the camera parallel or serial bus.
It defines bus width, data alignment and how many data samples form a single
pixel.

struct v4l2_pix_format::pixelformat (fourcc) on the other hand describes how
the image data is stored in memory.
 
As Hans pointed out there is not always a 1:1 correspondence, e.g. 

1. Both V4L2_MBUS_FMT_YUYV8_1x16 and V4L2_MBUS_FMT_YUYV8_2x8 may being 
translating to V4L2_PIX_FMT_YUYV fourcc,

2. Or the DMA engine in the camera host interface might be capable of
converting single V4L2_MBUS_FMT_RGB555 pixelcode to V4L2_PIX_FMT_RGB555
and V4L2_PIX_FMT_RGB565 fourcc's. So the user can choose any of them they
seem most suitable and the hardware takes care of the conversion. 

What translations are available really depends on the hardware, so how
could we define a standard translation table? IMO it should be realized
in each driver on an individual basis.

Regards,
Sylwester

> Regards,
> 
> David
> 
>>
>> A generic V4L2 application will never use mediabus fourcc codes. It's only used
>> by drivers and applications written specifically for that hardware and using
>> /dev/v4l-subdevX devices.
>>
>> Regards,
>>
>>         Hans
>>
