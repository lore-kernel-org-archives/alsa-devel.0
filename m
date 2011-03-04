From: David Cohen <dacohen@gmail.com>
Subject: Re: [GIT PULL FOR 2.6.39] Media controller and OMAP3 ISP driver
Date: Fri, 4 Mar 2011 22:14:38 +0200
Message-ID: <AANLkTimpZJbBMz476r53+AqxRZ=PsiRv=rt-dX9_WZw+@mail.gmail.com>
References: <201102171606.58540.laurent.pinchart@ideasonboard.com>
	<4D6EA4EB.9070607@redhat.com>
	<201103031125.06419.laurent.pinchart@ideasonboard.com>
	<4D71471D.6060808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4D71471D.6060808@redhat.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, alsa-devel@alsa-project.org, Sakari Ailus <sakari.ailus@retiisi.org.uk>, Pawel Osciak <pawel@osciak.com>
List-Id: alsa-devel@alsa-project.org

Hi Mauro,

On Fri, Mar 4, 2011 at 10:10 PM, Mauro Carvalho Chehab
<mchehab@redhat.com> wrote:
> Em 03-03-2011 07:25, Laurent Pinchart escreveu:
>> Hi Mauro,
>>
>> The following changes since commit 88a763df226facb74fdb254563e30e9ef=
b64275c:
>>
>> =C2=A0 [media] dw2102: prof 1100 corrected (2011-03-02 16:56:54 -030=
0)
>>
>> are available in the git repository at:
>> =C2=A0 git://linuxtv.org/pinchartl/media.git media-2.6.39-0005-omap3=
isp
>>
>> The branch has been rebased on top of the latest for_v2.6.39 branch,=
 with the
>> v4l2-ioctl.c conflict resolved.
>>
>> Antti Koskipaa (1):
>> =C2=A0 =C2=A0 =C2=A0 v4l: v4l2_subdev userspace crop API
>>
>> David Cohen (1):
>> =C2=A0 =C2=A0 =C2=A0 omap3isp: Statistics
>>
>> Laurent Pinchart (36):
>> =C2=A0 =C2=A0 =C2=A0 v4l: Share code between video_usercopy and vide=
o_ioctl2
>> =C2=A0 =C2=A0 =C2=A0 v4l: subdev: Don't require core operations
>> =C2=A0 =C2=A0 =C2=A0 v4l: subdev: Add device node support
>> =C2=A0 =C2=A0 =C2=A0 v4l: subdev: Uninline the v4l2_subdev_init func=
tion
>> =C2=A0 =C2=A0 =C2=A0 v4l: subdev: Control ioctls support
>> =C2=A0 =C2=A0 =C2=A0 media: Media device node support
>> =C2=A0 =C2=A0 =C2=A0 media: Media device
>> =C2=A0 =C2=A0 =C2=A0 media: Entities, pads and links
>> =C2=A0 =C2=A0 =C2=A0 media: Entity use count
>> =C2=A0 =C2=A0 =C2=A0 media: Media device information query
>> =C2=A0 =C2=A0 =C2=A0 media: Entities, pads and links enumeration
>> =C2=A0 =C2=A0 =C2=A0 media: Links setup
>> =C2=A0 =C2=A0 =C2=A0 media: Pipelines and media streams
>> =C2=A0 =C2=A0 =C2=A0 v4l: Add a media_device pointer to the v4l2_dev=
ice structure
>> =C2=A0 =C2=A0 =C2=A0 v4l: Make video_device inherit from media_entit=
y
>> =C2=A0 =C2=A0 =C2=A0 v4l: Make v4l2_subdev inherit from media_entity
>> =C2=A0 =C2=A0 =C2=A0 v4l: Move the media/v4l2-mediabus.h header to i=
nclude/linux
>> =C2=A0 =C2=A0 =C2=A0 v4l: Replace enums with fixed-sized fields in p=
ublic structure
>> =C2=A0 =C2=A0 =C2=A0 v4l: Rename V4L2_MBUS_FMT_GREY8_1X8 to V4L2_MBU=
S_FMT_Y8_1X8
>> =C2=A0 =C2=A0 =C2=A0 v4l: Group media bus pixel codes by types and s=
ort them alphabetically
>
> The presence of those mediabus names against the traditional fourcc c=
odes
> at the API adds some mess to the media controller. Not sure how to so=
lve,
> but maybe the best way is to add a table at the V4L2 API associating =
each
> media bus format to the corresponding V4L2 fourcc codes.

That would be good. OMAP2 camera driver also needs such table.

Br,

David

>
> Cheers,
> Mauro
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
