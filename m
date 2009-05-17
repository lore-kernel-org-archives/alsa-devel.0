From: Laurent Pinchart <laurent.pinchart@skynet.be>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB
	Audio Class gadget driver
Date: Sun, 17 May 2009 18:49:44 +0200
Message-ID: <200905171849.44957.laurent.pinchart@skynet.be>
References: <20090514181808.9ABB1BCE6@ip-64-139-1-69.sjc.megapath.net>
	<200905151752.58040.laurent.pinchart@skynet.be>
	<4A0DA08A.4040104@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.irobotique.be (perceval.irobotique.be [92.243.18.41])
	by alsa0.perex.cz (Postfix) with ESMTP id EA810244DC
	for <alsa-devel@alsa-project.org>;
	Sun, 17 May 2009 18:45:53 +0200 (CEST)
In-Reply-To: <4A0DA08A.4040104@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Steve Calfee <stevecalfee@gmail.com>, Hal Murray <hmurray@megapathdsl.net>, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Friday 15 May 2009 19:04:10 Clemens Ladisch wrote:
> Laurent Pinchart wrote:
> > On Friday 15 May 2009 17:07:30 Clemens Ladisch wrote:
> > > Laurent Pinchart wrote:
> > > > When streaming audio data from a real audio device to USB, the audio
> > > > clock comes from the real audio device and is beyond control of the
> > > > USB Audio Class gadget driver.
> > >
> > > In this case, you have _two_ clocks, the clock of the actual audio
> > > device, and the USB SOF clock.  What you need to know is the relative
> > > speed of these clocks, because that determines the number of samples
> > > per USB frame.
> >
> > If I use a synchronous endpoint, isn't the number of samples per frame
> > determined by the nominal sampling rate and the nominal SOF frequency ?
>
> Yes, but in _this_ case, the second case, you cannot use a synchronous
> endpoint.  Since the real audio device controls the rate, this would be
> an asynchronous endpoint.

Even if I resample the audio stream using the SOF clock ? As you pointed 
before, ALSA was designed around an asynchronous model. I need an audio clock 
to control the output of audio data. If I can't use the SOF clock, and as my 
driver can't access the audio input clock, the driver will not be able to copy 
data asynchronously from the ALSA ring buffer.

> > > I'd guess that your gadget driver does not have access to the real
> > > audio device, so it is the application that must do the measurement.
> >
> > That's right. The gadget driver doesn't care if data comes from a file or
> > a real audio device.
>
> I'd guess you don't want to restrict your gadget to reading from a file,
> so you'll have to implement an asynchronous endpoint, and reading from
> a file is just an uninteresting special case.

Then I need to either provide the driver with an audio clock from the 
userspace application (ALSA doesn't have any mechanism for that, as it assumes 
the device provides an audio clock), or check periodically how much data is 
available in the ALSA ring buffer. This is made even more complex by the fact 
that packets can vary by +/- 1 byte only according to your last e-mail.

> > > The ALSA API has no mechanism to tell the driver how fast to play, so
> > > it looks as if you have to write you own device driver.
> >
> > If I use a synchronous endpoint I can solve the problem on the driver
> > side. There would still be a problem on the application side, as the
> > audio source clock will obviously not be synchronous with the USB SOF
> > clock. The userspace application will request audio data at a nominal
> > rate equal to the nominal sample frequency advertised on USB, and will
> > need to perform rate matching between its source (real audio device) and
> > sink (USB driver). Is that (at least relatively) easy to do with ALSA ?
>
> It is possible, but not trivially easy.
>
> To measure the rate of the real audio device, you have to continually
> (or regularly) correlate the sample position (derived from
> snd_pcm_delay()) and some time stamp.  Using the computer's time would
> introduce a third clock, so I'd guess you should use the USB SOF
> interrupts as timer ticks (so your driver should notify the application
> of SOFs).
>
> With these measurements, you have the audio device rate, measured in
> (i.e., relative to) the USB SOF rate.  With this relation, you can do
> the rate matching; or you could use it to adjust the packet sizes of
> the asynchronous endpoint, which I think is much easier.

How can I adjust the asynchronous endpoint packet sizes in the driver if I 
can't access the audio clock there ?

> > I suppose this is a common use case for all audio streaming
> > applications such as internet radios, as in that case audio data
> > streamed over the network will not be synchronous with the sound card
> > audio clock and thus need to be resampled in the audio player before
> > being sent to the sound card.
>
> Or the player uses a buffer that is big enough so that there is enough
> data even if the sound card runs faster than the server.  :-)

Lazy players :-)

Best regards,

Laurent Pinchart
