From: Daniel Mack <zonque@gmail.com>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Fri, 15 Oct 2010 10:59:40 +0200
Message-ID: <20101015085939.GA25380@wok>
References: <4CAC89EA.8080207@ladisch.de> <4CACA471.2000504@showlabor.de>
	<4CAD6AA2.4050205@ladisch.de>
	<20101007081010.GZ7159@buzzloop.caiaq.de>
	<4CADB077.3060907@showlabor.de> <4CAEB9AC.1060208@ladisch.de>
	<20101012071831.GA7159@buzzloop.caiaq.de>
	<4CB419D0.70808@showlabor.de>
	<20101012102600.GB7159@buzzloop.caiaq.de>
	<4CB80163.5060107@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A422103C0B
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 10:59:45 +0200 (CEST)
Received: by wyb32 with SMTP id 32so428042wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2010 01:59:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CB80163.5060107@ladisch.de>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 15, 2010 at 09:23:15AM +0200, Clemens Ladisch wrote:
> Daniel Mack wrote:
> > > > I have an untested patch ready which should add support for implicit
> > > > feedback, but I'm uncertain about the condition when to activate this
> > > > mode.
> 
> For UAC2 devices, when the descriptors say so.
> For UAC1 devices, never (because UAC1 does not have this mode).

Yes, but UAC1 also doesn't support other things like high speed
transfers in the specs, still the Linux driver supports it, right?

I think we can interpret the ISO endpoint usage bits for this, and if a
UAC1 device sets them, it should be ok for the Linux driver. Or is there
any other detail in the spec we could use for judging?

> >  static int snd_usb_audio_next_packet_size(struct snd_usb_substream *subs)
> >  {
> > +		frames = min(capture->frame_count, subs->maxframesize);
> > +		capture->frame_count -= frames;
> 
> This assumes that both streams are running continuously, and you have to
> make sure to start them at the same time to prevent the frame_count from
> overflowing or underflowing. 

The caputure stream must be running continuously, yes. Otherwise, the
driver can't know how many data it should send. But the counter can't
actually underflow; if there is no more data to be sent, the counter
will drop to zero, which makes the output stream send zero-length
packets.

> In my UA-101 driver, I ensure that the
> buffer fill level is the same for both streams by submitting each
> playback packet with the same frame count as the corresponding capture
> packet; but I'm not sure which algorithm is more robust in practice.

Yes, I do exactly the same in my proprietary driver for the Native
Instruments devices, but it seems harder to implement in the generic
driver. The problem I see with my current approach is that the jitter is
higher - we now always send the maximum frame size or zero length.

> > +		/* if this stream is in implicit feedback mode, start the
> > +		 * capture stream now as the playback stream relies on the
> > +		 * amount of data we see on the capture IN endpoint.
> > +		 */
> > +		if (subs->stream->implicit_feedback && !capture->running) {
> > +			int ret;
> > +			capture->ops.retire = retire_paused_capture_urb;
> 
> set_interface?

You mean usb_set_interface()? Why should that be neccessary?

> > +			ret = start_urbs(capture, runtime);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +
> >  		return start_urbs(subs, runtime);
> 
> I think you have to wait for the first capture packet to be received
> before you can start submitting playback URBs.

Hmm, Felix - can you try this? I thought as long as the capture stream
doesn't see any data, it just sends out zero-length packets, which
should be ok. Or do I miss anything?

Thanks,
Daniel
