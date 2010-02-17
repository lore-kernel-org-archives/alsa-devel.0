From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 15:35:41 +0100
Message-ID: <20100217143540.GA404@tango.0pointer.de>
References: <20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
	<20100217001047.GB6766@tango.0pointer.de>
	<alpine.LNX.2.00.1002170924570.28127@eeebox2.perex-int.cz>
	<20100217130612.GD24165@tango.0pointer.de>
	<ad2655cb1002170555l462981cheff2b1798a14c9d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AF721038A4
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 15:36:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ad2655cb1002170555l462981cheff2b1798a14c9d0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 17.02.10 13:55, James Courtier-Dutton (james.dutton@gmail.com) wrote:

> So what you want it this.
> Example 1:
> If there are 2 gain controls between the CPU and the line-out.
> A is at 0dB
> B is at 0dB
> 
> If one changes A to +3dB and B to -3dB and one was playing a quiet
> sound (so no distortion), the result should sound very similar, volume
> wise, to the original 0dB, 0dB state.

Exactly.

> Example 2:
> There is one gain control between the CPU and the line-out that we are
> interested in.
> A is at 0dB.
> 
> If one changes A to +3dB and at the same time modify the source signal
> digitally by -3dB, the result should sound very similar, volume wise,
> to the original.

Exactly. And this second case is what dbverify from my little tool set
verifies.

> You would have to build your test tool so that it would detect
> distortion as well as levels.This way you could also find out where
> the limits really are in the chain.

I am not sure I want to get lost in complexities like that. My
simplified world where all elements in the pipeline are perfect,
linear multiplicators is oh so cozy, that I am happy to keep my eyes
shut and ignore that the actual filters implemented in the various
elements might be vastly more complex.

In fact dbmeasure and dbverify pick a 440Hz tone for their tests, so
all the volume factors I measure and rely on focus on one point in the
frequency spectrum and leave it at that.

Of course, this is a drastic simplification, but it should be
good enough on most cards and for desktop audio.

> This is a good aim, but I still think getting the correct 0dB points
> is more important to ensure the best audio quality.
> I personally think that PA should just set the hardware ALSA controls
> to 0dB and do all the volume control in software within PA.
> The 0dB points in hardware should result in the best sound quality.

I don't think this would be a good idea. In a lot of hardware you
definitely want to make as much use of the built-in volume adjustment
capabilities as you can. For example, on my integrated USB speakers
you may control the built-in amplifier with the alsa mixer, and that's
definitely much better than attenuating the 16bit PCM stream and
having the USB speakers amplifier constantly configured to a very high
volume level.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
