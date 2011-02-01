From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Digital IO and SPDIF format
Date: Tue, 01 Feb 2011 17:32:01 +0100
Message-ID: <4D483581.6050507@ladisch.de>
References: <12de1c06449.-3167568757226561582.4620295999935056878@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id CCD31245B2
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 17:31:51 +0100 (CET)
In-Reply-To: <12de1c06449.-3167568757226561582.4620295999935056878@zoho.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Torsten Schenk <torsten.schenk@zoho.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Torsten Schenk wrote:
> - if 6fire's clock and playback device's clock differ, should I use
> playback device's clock (no interpolation of samples but capturing
> tool might have invalid sample rate information) or the 6fire's clock
> (samples need to be interpolated somehow)?

You should never change the captured samples.  A digital frame might
be transporting AC-3/DTS data.

> - should I receive a whole spdif block (usually 192 spdif frames) and
> use the information I got from the block (f.ex. left/right channel
> bits) before copying it to alsa or should I directly copy every frame
> to alsa?

When copying data from the URB buffer to ALSA's buffer, copy only the
frames that are actually present.  Why would you need the whole block
for this?

> Am I correct in assuming that SNDRV_PCM_FORMAT_IEC958_SUBFRAME_XX
> samples are formatted like in the specification?

Er ... the format of these samples is what the old revision of the
CMI8738 chip requires.

> If you know of any tool that is able to handle this format

alsa-lib/src/pcm/pcm_iec958.c


Regards,
Clemens
