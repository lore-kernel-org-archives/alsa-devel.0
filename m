From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Fri, 15 Oct 2010 09:23:15 +0200
Message-ID: <4CB80163.5060107@ladisch.de>
References: <4CAAD212.9090805@ladisch.de> <4CAC804A.8040806@showlabor.de>
	<4CAC89EA.8080207@ladisch.de> <4CACA471.2000504@showlabor.de>
	<4CAD6AA2.4050205@ladisch.de>
	<20101007081010.GZ7159@buzzloop.caiaq.de>
	<4CADB077.3060907@showlabor.de> <4CAEB9AC.1060208@ladisch.de>
	<20101012071831.GA7159@buzzloop.caiaq.de>
	<4CB419D0.70808@showlabor.de>
	<20101012102600.GB7159@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 3A78C103BBA
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 09:21:55 +0200 (CEST)
In-Reply-To: <20101012102600.GB7159@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> > > I have an untested patch ready which should add support for implicit
> > > feedback, but I'm uncertain about the condition when to activate this
> > > mode.

For UAC2 devices, when the descriptors say so.
For UAC1 devices, never (because UAC1 does not have this mode).
It looks as if all UAC1-like devices that need this are actually marked
as vendor-specific, so we have quirks for them anyway.

> I attached a patch below, only compile-tested. Please also check the USB
> ID again, as I'm not sure whether you sent the right lsusb dump (the
> device name looks suspicious).

The actual device name is correct; the "DFU" was taken by lsusb from the
usb.ids file and is wrong.  (I've submitted the correct name.)

>  static int snd_usb_audio_next_packet_size(struct snd_usb_substream *subs)
>  {
> +		frames = min(capture->frame_count, subs->maxframesize);
> +		capture->frame_count -= frames;

This assumes that both streams are running continuously, and you have to
make sure to start them at the same time to prevent the frame_count from
overflowing or underflowing.  In my UA-101 driver, I ensure that the
buffer fill level is the same for both streams by submitting each
playback packet with the same frame count as the corresponding capture
packet; but I'm not sure which algorithm is more robust in practice.

> +		/* if this stream is in implicit feedback mode, start the
> +		 * capture stream now as the playback stream relies on the
> +		 * amount of data we see on the capture IN endpoint.
> +		 */
> +		if (subs->stream->implicit_feedback && !capture->running) {
> +			int ret;
> +			capture->ops.retire = retire_paused_capture_urb;

set_interface?

> +			ret = start_urbs(capture, runtime);
> +			if (ret)
> +				return ret;
> +		}
> +
>  		return start_urbs(subs, runtime);

I think you have to wait for the first capture packet to be received
before you can start submitting playback URBs.


Regards,
Clemens
