From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Fri, 15 Oct 2010 16:21:41 +0200
Message-ID: <4CB86375.2050703@ladisch.de>
References: <4CAC89EA.8080207@ladisch.de> <4CACA471.2000504@showlabor.de>
	<4CAD6AA2.4050205@ladisch.de>
	<20101007081010.GZ7159@buzzloop.caiaq.de>
	<4CADB077.3060907@showlabor.de> <4CAEB9AC.1060208@ladisch.de>
	<20101012071831.GA7159@buzzloop.caiaq.de>
	<4CB419D0.70808@showlabor.de>
	<20101012102600.GB7159@buzzloop.caiaq.de>
	<4CB80163.5060107@ladisch.de> <20101015085939.GA25380@wok>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A517F103890
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 16:20:29 +0200 (CEST)
In-Reply-To: <20101015085939.GA25380@wok>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> On Fri, Oct 15, 2010 at 09:23:15AM +0200, Clemens Ladisch wrote:
> > Daniel Mack wrote:
> > > > > I have an untested patch ready which should add support for implicit
> > > > > feedback, but I'm uncertain about the condition when to activate this
> > > > > mode.
> > 
> > For UAC2 devices, when the descriptors say so.
> > For UAC1 devices, never (because UAC1 does not have this mode).
> 
> Yes, but UAC1 also doesn't support other things like high speed
> transfers in the specs, still the Linux driver supports it, right?

Mostly with quirks.  Devices marked as UAC1 would not work in Windows
if they required anything not implemented in all more or less current
Windows versions; I don't know if any such device actually exists.

The Linux driver support is a default that is hoped to work with most
quirky devices, to reduce the amount of quirk code.  In the particular
case of UAC1 high speed support, I just added what the Audigy 2 NX
happened to do, because that was the device I had, and the extensions
to UAC1 looked plausible.

> I think we can interpret the ISO endpoint usage bits for this, and if a
> UAC1 device sets them, it should be ok for the Linux driver. Or is there
> any other detail in the spec we could use for judging?

For practical purposes, we cannot start the capture stream without it
being requested by a program when there is more than one possible sample
format/rate for it.

> > >  static int snd_usb_audio_next_packet_size(struct snd_usb_substream *subs)
> > >  {
> > > +		frames = min(capture->frame_count, subs->maxframesize);
> > > +		capture->frame_count -= frames;
> > 
> > This assumes that both streams are running continuously, and you have to
> > make sure to start them at the same time to prevent the frame_count from
> > overflowing or underflowing. 
> 
> The caputure stream must be running continuously, yes. Otherwise, the
> driver can't know how many data it should send.

If the capture stream was started some time before the playback stream,
the counter will be quite huge, and the driver will send lots of
maximum-sized packets, which will eventually overflow the device's
buffer.

If some capture packet gets lost due to an error, the playback stream
will try to compensate for that perceived lower rate.  Since this
protocol does not have sample counters, we cannot work around this; the
best idea probably is to stop the stream (xrun).  It's also possible for
a playback packet to get lost; we cannot do anything about that.

> But the counter can't actually underflow; if there is no more data to
> be sent, the counter will drop to zero, which makes the output stream
> send zero-length packets.

Using a default rate for the initial packets might make more sense.

(The audio output of the TUSB3200 chip will lock up if it gets several
zero-length packets, but that thing is full-speed and adaptive.)

> > In my UA-101 driver, I ensure that the
> > buffer fill level is the same for both streams by submitting each
> > playback packet with the same frame count as the corresponding capture
> > packet; but I'm not sure which algorithm is more robust in practice.
> 
> Yes, I do exactly the same in my proprietary driver for the Native
> Instruments devices, but it seems harder to implement in the generic
> driver. The problem I see with my current approach is that the jitter is
> higher - we now always send the maximum frame size or zero length.

This is called "blocking mode" in FireWire audio, and most FW devices
use it.  There the jitter doesn't matter as much because the packet
frequency is always 8 kHz.

> > > +		/* if this stream is in implicit feedback mode, start the
> > > +		 * capture stream now as the playback stream relies on the
> > > +		 * amount of data we see on the capture IN endpoint.
> > > +		 */
> > > +		if (subs->stream->implicit_feedback && !capture->running) {
> > > +			int ret;
> > > +			capture->ops.retire = retire_paused_capture_urb;
> > 
> > set_interface?
> 
> You mean usb_set_interface()? Why should that be neccessary?

To tell the device that the capture interface is supposed to send data.
Furthermore, any specification-compliant device has a zero-sized
endpoint, or no endpoint at all, in the default alternate setting.


Regards,
Clemens
