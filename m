From: Hans Verkuil <hansverk@cisco.com>
Subject: Re: [GIT PULL FOR 2.6.39] Media controller and OMAP3
	ISP driver
Date: Mon, 7 Mar 2011 13:02:48 +0100
Message-ID: <201103071302.49323.hansverk@cisco.com>
References: <201102171606.58540.laurent.pinchart@ideasonboard.com>
	<201103061821.31705.laurent.pinchart@ideasonboard.com>
	<4D74C684.7090507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtp-iport-2.cisco.com (rtp-iport-2.cisco.com [64.102.122.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 94941103880
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 13:03:19 +0100 (CET)
In-Reply-To: <4D74C684.7090507@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, alsa-devel@alsa-project.org, Pawel Osciak <pawel@osciak.com>, Sakari Ailus <sakari.ailus@retiisi.org.uk>, Sylwester Nawrocki <snjw23@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Cohen <dacohen@gmail.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Monday, March 07, 2011 12:50:28 Mauro Carvalho Chehab wrote:
> Em 06-03-2011 14:21, Laurent Pinchart escreveu:
> > Hi Mauro,
> > 
> > On Sunday 06 March 2011 14:32:44 Mauro Carvalho Chehab wrote:
> >> Em 06-03-2011 08:38, Laurent Pinchart escreveu:
> >>> On Sunday 06 March 2011 11:56:04 Mauro Carvalho Chehab wrote:
> >>>> Em 05-03-2011 20:23, Sylwester Nawrocki escreveu:
> >>>>
> >>>> A somewhat unrelated question that occurred to me today: what happens
> >>>> when a format change happens while streaming?
> >>>>
> >>>> Considering that some formats need more bits than others, this could
> >>>> lead into buffer overflows, either internally at the device or
> >>>> externally, on bridges that just forward whatever it receives to the
> >>>> DMA buffers (there are some that just does that). I didn't see anything
> >>>> inside the mc code preventing such condition to happen, and probably
> >>>> implementing it won't be an easy job. So, one alternative would be to
> >>>> require some special CAPS if userspace tries to set the mbus format
> >>>> directly, or to recommend userspace to create media controller nodes
> >>>> with 0600 permission.
> >>>
> >>> That's not really a media controller issue. Whether formats can be
> >>> changed during streaming is a driver decision. The OMAP3 ISP driver
> >>> won't allow formats to be changed during streaming. If the hardware
> >>> allows for such format changes, drivers can implement support for that
> >>> and make sure that no buffer overflow will occur.
> >>
> >> Such issues is caused by having two API's that allow format changes, one
> >> that does it device-based, and another one doing it subdev-based.
> >>
> >> Ok, drivers can implementing locks to prevent such troubles, but, without
> >> the core providing a reliable mechanism, it is hard to implement a
> >> correct lock.
> >>
> >> For example, let's suppose that some driver is using mt9m111 subdev (I 
just
> >> picked one random sensor that supports lots of MBUS formats). There's
> >> nothing there preventing a subdev call for it to change mbus format while
> >> streaming. Worse than that, the sensor driver has no way to block it, as
> >> it doesn't know that the bridge driver is streaming or not.
> >>
> >> The code at subdev_do_ioctl() is just:
> >>
> >> case VIDIOC_SUBDEV_S_FMT: {
> >>         struct v4l2_subdev_format *format = arg;
> >>
> >>         if (format->which != V4L2_SUBDEV_FORMAT_TRY &&
> >>             format->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> >>                 return -EINVAL;
> >>
> >>         if (format->pad >= sd->entity.num_pads)
> >>                 return -EINVAL;
> >>
> >>         return v4l2_subdev_call(sd, pad, set_fmt, subdev_fh, format);
> >> }
> >>
> >> So, mc core won't be preventing it.
> >>
> >> So, I can't see how such subdev request would be implementing a logic to
> >> return -EBUSY on those cases.
> > 
> > Drivers can use the media_device graph_mutex to serialize format and 
stream 
> > management calls. A finer grain locking mechanism implemented in the core 
> > might be better, but we're not stuck without a solution at the moment.

Am I missing something here? Isn't it as simple as remembering whether the
subdev is in streaming mode (s_stream(1) was called) or not? When streaming
any attempt to change the format should return an error (unless the hardware
can handle it, of course).

This is the same as for the 'regular' V4L2 API.

Regards,

	Hans

> 
> Ok, i see. This is not the best world, as I suspect that developers will
> just try to enable media controller for a few devices without taking enough
> care to avoid buffer overflows.
> While we don't have a better way for doing it, please add a note at the 
kernel 
> api doc saying about that, briefly describing how to properly lock it, 
because
> this is not obvious at all.
> 
> Cheers,
> Mauro
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
