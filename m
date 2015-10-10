From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] ALSA: usb-audio: Fix max packet
	size	calculation for USB audio
Date: Sat, 10 Oct 2015 10:48:33 +0200
Message-ID: <5618D0E1.1000308@ladisch.de>
References: <alpine.DEB.2.02.1510100012390.7332@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id A37C4260436
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 10:49:22 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1510100012390.7332@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Ricard Wanderlof wrote:
> The addition of 0xffff ("almost 1" in Q16.16 format), resulting
> in the rounding up of the resulting value, was in the wrong place,
> as it is the resulting packet size that needs to be rounded up
> to the nearest integer (e.g. if the resulting packet size is
> calculated as 55.125 bytes, we need a packet of 56 bytes),
> rather than the rate value (ep->freqmax).
>
> Tested with an Edirol UA-5 both at 44.1 kHz and 96 kHz.
>
> Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
> ---
> V2: Added tested device to commit message. No other changes.
>
> Since this clearly is a sensitive part of the code, here follows a lengthy
> rationale with examples to illustrate the problem.

There is a maximum size for USB packets, but not for git commit messages. :)

> [...]
> The problem here is that the addition of 0xffff is in the wrong place. We don't
> want the rounding up to take place on the frequency, but on the resulting
> packet size.

Packets must not contain partial frames, so the rounding must take place
on the number of frames per packet.

> Let's take an example. We have a sample rate of 96 kHz, so our
> ep->freqn is 786432 (see usb_high_speed_rate()). Add 25% (line 612) and we get
> 983040.  The calculated maxsize is then ((983040 + 65535) * 8) >> 16 = 127 .

That code was intended to round correctly, but it's obviously wrong
because the result is not an integer multiple of the frame size.

(Please write Q16.16 values in hex.)

> However, if we do the number of bytes calculation in a less obscure way it's
> more apparent what the true corresponding packet size is: we get
> (96000 * 1.25 / 8000) * 8 = 120

The value inside the parentheses is the number of frames per packet, and
must be rounded.

> This is also corroborated by the wMaxPacketSize check on line 616. Assume
> that wMaxPacketSize = 108

It would not make sense to have a value that is not a multiple of the
frame size.  (I'm not saying that it doesn't occur in practice ...)


Regards,
Clemens
