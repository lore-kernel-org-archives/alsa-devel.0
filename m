From: Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [RFC PATCH v8 1/4] media: Media Device Allocator
	API
Date: Sun, 9 Dec 2018 09:27:36 -0200
Message-ID: <20181209092715.50a7e4e4@coco.lan>
References: <cover.1541109584.git.shuah@kernel.org>
 <e474dd16f1d6443c12b1361376193c9d0efcced6.1541109584.git.shuah@kernel.org>
 <20181119085931.GA28607@amd>
 <73c22137-9c7a-75c8-8cd1-3736c63c2d40@kernel.org>
 <20181209080944.GA7561@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FE522677E4
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2018 12:27:52 +0100 (CET)
In-Reply-To: <20181209080944.GA7561@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, shuah <shuah@kernel.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Em Sun, 9 Dec 2018 09:09:44 +0100
Pavel Machek <pavel@ucw.cz> escreveu:

> On Thu 2018-12-06 08:33:14, shuah wrote:
> > On 11/19/18 1:59 AM, Pavel Machek wrote:  
> > >On Thu 2018-11-01 18:31:30, shuah@kernel.org wrote:  
> > >>From: Shuah Khan <shuah@kernel.org>
> > >>
> > >>Media Device Allocator API to allows multiple drivers share a media device.
> > >>Using this API, drivers can allocate a media device with the shared struct
> > >>device as the key. Once the media device is allocated by a driver, other
> > >>drivers can get a reference to it. The media device is released when all
> > >>the references are released.  
> > >
> > >Sounds like a ... bad idea?
> > >
> > >That's what new "media control" framework is for, no?
> > >
> > >Why do you need this?  
> > 
> > Media control framework doesn't address this problem of ownership of the
> > media device when non-media drivers have to own the pipeline. In this case,
> > snd-usb owns the audio pipeline when an audio application is using the
> > device. Without this work, media drivers won't be able to tell if snd-usb is
> > using the tuner and owns the media pipeline.
> > 
> > I am going to clarify this in the commit log.  
> 
> I guess I'll need the explanation, yes.
> 
> How can usb soundcard use the tuner? I thought we'd always have
> userspace component active and moving data between tuner and usb sound
> card?

It sounds that the description of the patch is not 100%, as it seems
that you're not seeing the hole picture.

This is designed to solve a very common usecase for media devices
where one physical device (an USB stick) provides both audio
and video.

That's, for example, the case of cameras with microphones and 
TV USB devices. Those usually expose the audio via standard
USB Audio Class, and video either via USB Video Class or via
some proprietary vendor class.

Due to the way USB Audio Class is handled, it means that two
independent drivers will provide the pipelines for a single
physical USB bridge.

The same problem also applies to more sophisticated embedded devices,
like on  SOCs designed to be used on TVs and Set Top Boxes, where the
hardware pipeline has both audio and video components on it, logically
mapped into different drivers (using Linux DTV API, V4L2 API and ALSA).

On such kind of devices, it is important to have a way to see
and control the entire audio and video pipeline present on them 
through a single media controller device, specially if one wants
to provide a hardware pipeline within the SoC that won't be 
copying data between Kernel-userspace.

Now, if the audio is implemented on a separate device (like an
Intel HDA compatible chipset at the motherboard), it should
be exposed as a separate media controller.

So, for example, a system that has both an USB audio/video
stick and an Intel HDA-compatible chipset, both exposed via
the media controller, will have two media controller devices,
one for each physically independent device.

On the other hand, an SoC designed for TV products will likely
expose a single media controller, even if each part of the
pipeline is exposed via independent Linux device drivers.

Thanks,
Mauro
