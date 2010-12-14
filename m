From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC/PATCH v6 03/12] media: Entities,
	pads and links
Date: Wed, 15 Dec 2010 07:30:26 +0800
Message-ID: <AANLkTimDa9_=8=hCQhzAjiF5seKBuO0VSyagGDedfK2_@mail.gmail.com>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<201012141300.57118.laurent.pinchart@ideasonboard.com>
	<4D0771CB.3020809@ladisch.de>
	<201012141525.02463.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 18D902441C
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 00:30:27 +0100 (CET)
Received: by eyg24 with SMTP id 24so741596eyg.24
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 15:30:26 -0800 (PST)
In-Reply-To: <201012141525.02463.laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/12/14 Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Hi Clemens,
>
> On Tuesday 14 December 2010 14:31:55 Clemens Ladisch wrote:
> > Laurent Pinchart wrote:
> > > On Monday 13 December 2010 17:10:51 Clemens Ladisch wrote:
> > >> TYPE_EXT describes entities that represent some interface to the
> > >> external world, TYPE_INT those that are internal to the entire device.
> > >> (I'm not sure if that distinction is very useful, but TYPE_SUBDEV
> seems
> > >> to be an even more meaningless name.)
> > >
> > > SUBDEV comes from the V4L2 world, and I agree that it might not be a
> very
> > > good name.
> > >
>

It is rather confusing since subdevice in ALSA has another specific meaning


 **** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: VT1702 Analog [VT1702 Analog]
  Subdevices: 1/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: VT1702 Analog [VT1702 Analog]
  Subdevices: 3/3
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2




>
> > >> EXT_SPEAKER also includes headphones; there might be made a case for
> > >> having those as a separate subtype.
> > >
> > > Shouldn't headphones be represented by an EXT_JACK_ANALOG ?
> >
> > Headphone jacks are jacks; there are also USB headphones.
>
> So EXT_SPEAKER are speakers not connected through a jack (USB, internal
> analog, ...) ?
>

How about internal microphone of those laptop ? ( mic array , ...)

How about those default device in HDA specification ( e.g. CD , AUX,
Telephony , Modem Line , Modem Headset)
