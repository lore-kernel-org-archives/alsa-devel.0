From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: driver silence callback
Date: Thu, 24 Mar 2011 08:21:36 +0100
Message-ID: <4D8AF100.90209@ladisch.de>
References: <4D8A910D.6030604@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 82D9910397B
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 08:20:10 +0100 (CET)
In-Reply-To: <4D8A910D.6030604@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eliot Blennerhassett wrote:
> Is the driver's silence callback meant to be able to *overwrite* some
> part of the audio buffer that has already been written e.g. via the
> playback *copy* callback?

No.

> I'm looking at the case in pcm_lib.c snd_pcm_playback_silence() where
> "when runtime->silence_size >= runtime->boundary - fill processed area
> with silence immediately"

When underrun detection is disabled, this mechanism can be used to fill
some part of the buffer with silence immediately after the hardware has
read from this part of the buffer, so that in case of an underrung, not
the old data but silence is played.

In other words, the silence callbacks initializes the buffer, while the
copy callback later fills the same part of the buffer with actual data.

> In the case of my (older) hardware, once audio has been written via the
> copy callback, it is gone (into a fifo), there is no way to overwrite
> with silence.

Ensure that on a FIFO underrun, silence is played.  This might be the
default on your hardware anyway.  :)


Regards,
Clemens
