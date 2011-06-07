From: Sergey Lapin <slapin@ossfans.org>
Subject: Re: [RFC PATCH] Add combined clock support to Atmel
	SoC audio
Date: Tue, 7 Jun 2011 05:51:48 -0400
Message-ID: <20110607095148.GA14633@build.ihdev.net>
References: <4CEC3A97.4040400@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from build.ossfans.org (unknown [178.63.197.118])
	by alsa0.perex.cz (Postfix) with ESMTP id F33B41039E1
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 11:51:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CEC3A97.4040400@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, gwossum@acm.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 24, 2010 at 11:05:11AM +1300, Ryan Mallon wrote:
> The following patch is one that has been floating around in various
> forms in our own internal trees for a while.
> 
> The Atmel SSC peripheral has seperate TX and RX clocks which use
> separate pins from the the micro. TF (frame) and TK (clock) for transmit
> and RF and RK for receive. Not all codecs have separate frame and bit
> clocks for transmit and receive so we want to be able to do both
> playback and capture using a single set of pins.
> 
> This patch introduces a combined clock mode for the Atmel SSC
> peripheral. Which allows playback and capture to use a single set of
> pins. Currently combined clock is only supported on the TF/TK pins (some
> incomplete support exists for using RF/RK).
> 
> I have tested this patch on our AT91SAM9G45 + TLV320AIC26 platform.
> Playback and capture work individually. Simultaneous playback and
> capture have been tested by connecting a loopback cable on the linein
> and lineout jacks and then doing:
> 
>   arecord -c 2 -f S16_LE -r 44100 > recording.wav &
>   aplay 500hz_sine.wav
> 
> This patch is posted as RFC since the approach is incomplete and a bit
> hackish. I am mostly interested in knowing if this is a sensible
> approach, and could be cleaned up for mainline inclusion, or if there is
> a better way to do this.
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
Tested-by: Sergey Lapin <slapin@ossfans.org>
