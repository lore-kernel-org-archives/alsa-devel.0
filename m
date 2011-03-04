From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [GIT PULL FOR 2.6.39] Media controller and OMAP3 ISP driver
Date: Fri, 04 Mar 2011 16:25:49 -0300
Message-ID: <4D713CBD.7030405@redhat.com>
References: <201102171606.58540.laurent.pinchart@ideasonboard.com> <4D6EA4EB.9070607@redhat.com> <201103031125.06419.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201103031125.06419.laurent.pinchart@ideasonboard.com>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, alsa-devel@alsa-project.org, Sakari Ailus <sakari.ailus@retiisi.org.uk>, Pawel Osciak <pawel@osciak.com>
List-Id: alsa-devel@alsa-project.org

Em 03-03-2011 07:25, Laurent Pinchart escreveu:
> Hi Mauro,
> 
> The following changes since commit 88a763df226facb74fdb254563e30e9efb64275c:
> 
>   [media] dw2102: prof 1100 corrected (2011-03-02 16:56:54 -0300)
> 
> are available in the git repository at:
>   git://linuxtv.org/pinchartl/media.git media-2.6.39-0005-omap3isp
> 
> The branch has been rebased on top of the latest for_v2.6.39 branch, with the
> v4l2-ioctl.c conflict resolved.
> 
> Antti Koskipaa (1):
>       v4l: v4l2_subdev userspace crop API
> 
> David Cohen (1):
>       omap3isp: Statistics
> 
> Laurent Pinchart (36):
>       v4l: Share code between video_usercopy and video_ioctl2
>       v4l: subdev: Don't require core operations
>       v4l: subdev: Add device node support
>       v4l: subdev: Uninline the v4l2_subdev_init function
>       v4l: subdev: Control ioctls support
>       media: Media device node support
>       media: Media device
>       media: Entities, pads and links
>       media: Entity use count
>       media: Media device information query

Hi Laurent,

You're using 'M' for the media control ioctl's, but I'm not seeing any patch
adding that range to the ioctl-number:
	Documentation/ioctl/ioctl-number.txt

In particular, according with the text, 'M' is used by several other drivers,
including audio, with doesn't sounds like a good idea to me.

So, please send me a patch, at the end of the series, reserving an unused range 
for the media controller and replacing the ioctl numbers that you've already
added to the new ioctl group.

Thanks!
Mauro
