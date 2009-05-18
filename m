From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] ALSA vs. dedicated char device for a USB
 Audio Class gadget driver
Date: Mon, 18 May 2009 10:39:24 +0200
Message-ID: <4A111EBC.2010606@ladisch.de>
References: <20090515201519.7C347BCE6@ip-64-139-1-69.sjc.megapath.net>
	<200905171925.23956.laurent.pinchart@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id BA6CB244BF
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 10:39:28 +0200 (CEST)
In-Reply-To: <200905171925.23956.laurent.pinchart@skynet.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Laurent Pinchart <laurent.pinchart@skynet.be>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Laurent Pinchart wrote:
> The applicable techniques require knowledge of both the audio clock and the
> SOF clock in a common place. My driver has no access to the audio clock. All
> it knows about is the SOF clock.
> 
> There are only two options I can think of.
> 
> The first one is to use an asynchronous endpoint and sent the occasional
> smaller or bigger packet (or duplicate/drop one sample). As the driver can't
> access the audio clock it needs to derive the information from the amount of
> data present in the ALSA ring buffer. To be honest I'm not sure if that will
> be possible at all, as the application will write data at a non-constant rate.

The ALSA API assumes that the device controls the audio clock and that
the application derives its own speed from that, not the other way
round.

> The second one, which sounds easier, at least on the driver side, is to use a
> synchronous endpoint with a fixed packet size. The application will perform
> rate matching (duplicating/dropping a sample or resampling the audio stream)
> using the audio clock and the SOF clock. What I'm still unsure about is how
> the application can access the audio clock and the SOF clock through ALSA, but
> I suppose that's possible.

The ALSA API doesn't give you access to the SOF clock.


What you want to do is not possible (or impracticably hard) with the
ALSA API; I strongly suggest that you define your own API for your
audio gadget driver so that SOF clock information is made available to
the application, and that packet sizes can be directly controlled by the
application.


Best regards,
Clemens
