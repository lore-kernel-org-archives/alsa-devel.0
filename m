From: David Cohen <dacohen@gmail.com>
Subject: Re: [GIT PULL FOR 2.6.39] Media controller and OMAP3 ISP driver
Date: Mon, 7 Mar 2011 14:06:13 +0200
Message-ID: <AANLkTikYvi64V3bmYx=jn3JwvznQ6WT6YM4EmQjzO4ym@mail.gmail.com>
References: <201102171606.58540.laurent.pinchart@ideasonboard.com>
	<201103051402.34416.laurent.pinchart@ideasonboard.com>
	<4D727F64.7040805@redhat.com>
	<201103052148.06603.laurent.pinchart@ideasonboard.com>
	<4D74C82A.9050406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4D74C82A.9050406@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, alsa-devel@alsa-project.org, Sakari Ailus <sakari.ailus@retiisi.org.uk>, Pawel Osciak <pawel@osciak.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 7, 2011 at 1:57 PM, Mauro Carvalho Chehab
<mchehab@redhat.com> wrote:
> Em 05-03-2011 17:48, Laurent Pinchart escreveu:
>> Hi Mauro,

Hi Mauro,

>>
>> On Saturday 05 March 2011 19:22:28 Mauro Carvalho Chehab wrote:
>>> Em 05-03-2011 10:02, Laurent Pinchart escreveu:
>>>> Hi Mauro,
>>>>
>>>> Thanks for the review. Let me address all your concerns in a single mail.
>>>>
>>>> - ioctl numbers
>>>>
>>>> I'll send you a patch that reserves a range in Documentation/ioctl/ioctl-
>>>> number.txt and update include/linux/media.h accordingly.
>>>
>>> Ok, thanks.
>>
>> "media: Pick a free ioctls range" at the top of the
>> http://git.linuxtv.org/pinchartl/media.git?a=shortlog;h=refs/heads/media-2.6.39-0005-
>> omap3isp branch
>
> Added in the end of my quilt series.
>>
>>>> - private ioctls
>>>>
>>>> As already explained by David, the private ioctls are used to control
>>>> advanced device features that can't be handled by V4L2 controls at the
>>>> moment (such as setting a gamma correction table). Using those ioctls is
>>>> not mandatory, and the device will work correctly without them (albeit
>>>> with a non optimal image quality).
>>>>
>>>> David said he will submit a patch to document the ioctls.
>>>
>>> Ok.
>>
>> Working on that.
>
> Laurent/David, any news on that?

Yes. Sakari has written a first documentation and I'm complementing
with statistic's specific usage information.

Regards,

David
