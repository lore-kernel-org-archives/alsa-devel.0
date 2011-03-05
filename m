From: David Cohen <dacohen@gmail.com>
Subject: Re: [GIT PULL FOR 2.6.39] Media controller and OMAP3 ISP driver
Date: Sat, 5 Mar 2011 15:04:21 +0200
Message-ID: <AANLkTi=SS3CBkKUdovU33SQi=s9gNprZszKaMrkRGqGy@mail.gmail.com>
References: <201102171606.58540.laurent.pinchart@ideasonboard.com>
	<201103031125.06419.laurent.pinchart@ideasonboard.com>
	<4D71471D.6060808@redhat.com>
	<201103051252.12342.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201103051252.12342.hverkuil@xs4all.nl>
Sender: linux-media-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, alsa-devel@alsa-project.org, Sakari Ailus <sakari.ailus@retiisi.org.uk>, Pawel Osciak <pawel@osciak.com>
List-Id: alsa-devel@alsa-project.org

Hi Hans,

On Sat, Mar 5, 2011 at 1:52 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote=
:
> On Friday, March 04, 2011 21:10:05 Mauro Carvalho Chehab wrote:
>> Em 03-03-2011 07:25, Laurent Pinchart escreveu:
>> > Hi Mauro,
>> >
>> > The following changes since commit 88a763df226facb74fdb254563e30e9=
efb64275c:
>> >
>> > =C2=A0 [media] dw2102: prof 1100 corrected (2011-03-02 16:56:54 -0=
300)
>> >
>> > are available in the git repository at:
>> > =C2=A0 git://linuxtv.org/pinchartl/media.git media-2.6.39-0005-oma=
p3isp
>> >
>> > The branch has been rebased on top of the latest for_v2.6.39 branc=
h, with the
>> > v4l2-ioctl.c conflict resolved.
>> >
>> > Antti Koskipaa (1):
>> > =C2=A0 =C2=A0 =C2=A0 v4l: v4l2_subdev userspace crop API
>> >
>> > David Cohen (1):
>> > =C2=A0 =C2=A0 =C2=A0 omap3isp: Statistics
>> >
>> > Laurent Pinchart (36):
>> > =C2=A0 =C2=A0 =C2=A0 v4l: Share code between video_usercopy and vi=
deo_ioctl2
>> > =C2=A0 =C2=A0 =C2=A0 v4l: subdev: Don't require core operations
>> > =C2=A0 =C2=A0 =C2=A0 v4l: subdev: Add device node support
>> > =C2=A0 =C2=A0 =C2=A0 v4l: subdev: Uninline the v4l2_subdev_init fu=
nction
>> > =C2=A0 =C2=A0 =C2=A0 v4l: subdev: Control ioctls support
>> > =C2=A0 =C2=A0 =C2=A0 media: Media device node support
>> > =C2=A0 =C2=A0 =C2=A0 media: Media device
>> > =C2=A0 =C2=A0 =C2=A0 media: Entities, pads and links
>> > =C2=A0 =C2=A0 =C2=A0 media: Entity use count
>> > =C2=A0 =C2=A0 =C2=A0 media: Media device information query
>> > =C2=A0 =C2=A0 =C2=A0 media: Entities, pads and links enumeration
>> > =C2=A0 =C2=A0 =C2=A0 media: Links setup
>> > =C2=A0 =C2=A0 =C2=A0 media: Pipelines and media streams
>> > =C2=A0 =C2=A0 =C2=A0 v4l: Add a media_device pointer to the v4l2_d=
evice structure
>> > =C2=A0 =C2=A0 =C2=A0 v4l: Make video_device inherit from media_ent=
ity
>> > =C2=A0 =C2=A0 =C2=A0 v4l: Make v4l2_subdev inherit from media_enti=
ty
>> > =C2=A0 =C2=A0 =C2=A0 v4l: Move the media/v4l2-mediabus.h header to=
 include/linux
>> > =C2=A0 =C2=A0 =C2=A0 v4l: Replace enums with fixed-sized fields in=
 public structure
>> > =C2=A0 =C2=A0 =C2=A0 v4l: Rename V4L2_MBUS_FMT_GREY8_1X8 to V4L2_M=
BUS_FMT_Y8_1X8
>> > =C2=A0 =C2=A0 =C2=A0 v4l: Group media bus pixel codes by types and=
 sort them alphabetically
>>
>> The presence of those mediabus names against the traditional fourcc =
codes
>> at the API adds some mess to the media controller. Not sure how to s=
olve,
>> but maybe the best way is to add a table at the V4L2 API associating=
 each
>> media bus format to the corresponding V4L2 fourcc codes.
>
> You can't do that in general. Only for specific hardware platforms. I=
f you
> could do it, then we would have never bothered creating these mediabu=
s fourccs.
>
> How a mediabus fourcc translates to a pixelcode (=3D=3D memory format=
) depends
> entirely on the hardware capabilities (mostly that of the DMA engine)=
=2E

May I ask you one question here? (not entirely related to this patch se=
t).
Why pixelcode !=3D mediabus fourcc?
e.g. OMAP2 camera driver talks to sensor through subdev interface and
sets its own output pixelformat depending on sensor's mediabus fourcc.
So it needs a translation table mbus_pixelcode -> pixelformat. Why
can't it be pixelformat -> pixelformat ?

Regards,

David

>
> A generic V4L2 application will never use mediabus fourcc codes. It's=
 only used
> by drivers and applications written specifically for that hardware an=
d using
> /dev/v4l-subdevX devices.
>
> Regards,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Hans
>
> --
> Hans Verkuil - video4linux developer - sponsored by Cisco
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
