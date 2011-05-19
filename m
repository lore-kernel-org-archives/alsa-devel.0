From: Bhupesh SHARMA <bhupesh.sharma@st.com>
Subject: RE: Audio Video synchronization for data received from a HDMI
 receiver chip
Date: Thu, 19 May 2011 19:10:00 +0800
Message-ID: <D5ECB3C7A6F99444980976A8C6D896384DF11B6342@EAPEX1MAIL1.st.com>
References: <D5ECB3C7A6F99444980976A8C6D896384DF1137013@EAPEX1MAIL1.st.com>
 <201105180832.52333.hverkuil@xs4all.nl>
 <D5ECB3C7A6F99444980976A8C6D896384DF11B615E@EAPEX1MAIL1.st.com>
 <201105190855.58027.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201105190855.58027.hverkuil@xs4all.nl>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: "Charlie X. Liu" <charlie@sensoray.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "g.liakhovetski@gmx.de" <g.liakhovetski@gmx.de>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > Hi Hans,
> >
> > I have another doubt regarding the framework choice for the entire
> > system that I have, especially the video part of the system. The
> overall
> > system is similar to the one depicted below:
> >
> > HDMI data --> HDMI receiver chip --> Video Port IP on SoC --> System
> DDR
> >
> > HDMI data is received from external world (from say a set-up box or
> dvd player),
> > which is fed to the HDMI receiver chip on-board and then parallel
> data lines feed
> > this data to a Video Port IP on the SoC which has a DMA master
> interface and
> > hence can push the data thus received directly on system DDR.
> >
> > Now, I can figure out that there will be two drivers required here:
> > # HDMI receiver chip driver (which is essentially a v4l2 subdev being
> controller via I2C)
> > # Video Port driver (which is a v4l2 bridge driver)
> >
> > Is my understanding correct?
> 
> Yes.

Thanks for clarifying this.

> > Are there any HDMI receiver subdev driver and video bridge driver
> already available which I can
> > use for reference?
> 
> Video bridge drivers are easier: examples are in
> drivers/media/video/s5p-fimc
> or in drivers/media/video/davinci. Note that you should use the new
> videobuf2
> framework instead of the older videobuf framework. s5p-fimc is using
> vb2 already.
> but the vpif capture and display drivers in the davinci directory do
> not.

I quickly had a look at the s5p-fimc and davinci approaches, but I found that
the video bridge drivers supported in both the Samsung and TI SoCs,
support video post-processing operations whereas in our case the Video Port
IP performs almost no additional processing and only passes the unpacked RBG
raw data received from HDMI bus to system DDR via a DMA master interface.

So as such these are no format conversion operations(rgb-to-yuv or vice-versa),
image resizing operations (cropping, scaling..) and image quality operations
(filtering, distortion removal) available in the H/W block.

What should be the correct choice in such a case?
 
> With regards to HDMI receivers: these are still under development. One
> example
> is here:
> http://git.linuxtv.org/hverkuil/cisco.git?a=shortlog;h=refs/heads/cobal
> t
> 
> This tree contains a driver for the adv7604 HDMI/Graphics receiver. It
> is fairly
> simplistic at the moment, our internal driver is developed a lot
> further but I
> haven't had the chance yet to update the git tree with our latest code
> (Cisco
> is developing this driver). In addition the HDMI API for V4L2 is still
> under
> development. It requires some V4L2 core support to be merged first
> (control events)
> before we can continue with that.

Ok, I will have a look at the git tree. Thanks for sharing the same.

> >
> > Also will the audio ALSA driver fit as a subdev driver in the entire
> system?
> 
> No, although I have heard that the ALSA developers are looking at a
> subdev-like
> approach. There are several V4L drivers that support ALSA as a separate
> driver
> (cx18 for example). This is usually not a problem.

Ok, I will have a look at the cx18 driver.

Regards,
Bhupesh
