From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio FTU issues
Date: Mon, 25 Jul 2011 15:07:56 +0200
Message-ID: <4E2D6AAC.7010707@ladisch.de>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>	<4E045058.6000405@showlabor.de>	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>	<4E04B42E.2080906@ladisch.de>
	<BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 097E924523
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jul 2011 15:04:15 +0200 (CEST)
In-Reply-To: <BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, =?UTF-8?B?QXVyw6lsaWVuIExlYmxv?=@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, =?UTF-8?B?bmQ=?= <blablack@gmail.com>
List-Id: alsa-devel@alsa-project.org

(Sorry for the delay, I don't have much free time.)

Daniel Mack wrote:
> On Fri, Jun 24, 2011 at 5:58 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> > I think the best solution would be to move the USB streaming into
> > a module, add implicit feedback support there, and create a separate
> > driver for the FTU and similar devices.
> 
> However, I'm not sure whether making a special driver for the FTU is
> really the way to go. Even though I haven't seen any device around yet
> that implements this in a class-compliant way, this type of streaming
> model is in fact part of the USB Audio specification, at least in
> version 2. It's more than likely that there will be more devices
> around in the future, and so it would be good to have support for it
> in the standard driver.

Only the parts that are different would go into the separate drivers.
This would be device detection, parsing of the descriptors, stream
management and configuration (i.e., choosing and setting alternate
settings, and class-specific interface/endpoint requests), and most of
the interfacing with the ALSA framework.  (USB Audio 1.0 and 2.0 are not
really compatible, so the latter might become a separate driver, too.)

Common parts (snd-usb-lib) would be the actual streaming (sending/
receiving packets, buffer handling), and whatever random stuff turns
out to be needed by multiple drivers.

> Can you outline how the API will look like?

Something like this:

	struct usb_pcm_stream;

	usb_pcm_stream_init(stream, snd_pcm_stream, usb_device, flags);
	usb_pcm_stream_destroy(stream);

	usb_pcm_stream_configure(stream, endpoint, rate, format);
	usb_pcm_stream_set_clock_source(stream, master_stream);

	usb_pcm_stream_start(stream);
	usb_pcm_stream_stop(stream);

	// helpers to implement ALSA PCM callbacks
	usb_pcm_stream_pcm_prepare(stream);
	usb_pcm_stream_pcm_trigger(stream, start);
	usb_pcm_stream_pcm_pointer(stream);

(There are obvious similarities with firewire/amdtp.c.)

As far as I can tell, this affects mostly urb.c.


Regards,
Clemens
