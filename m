From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 13:55:08 +0000
Message-ID: <ad2655cb1002170555l462981cheff2b1798a14c9d0@mail.gmail.com>
References: <20100216143200.GB25489@tango.0pointer.de>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
	<20100217001047.GB6766@tango.0pointer.de>
	<alpine.LNX.2.00.1002170924570.28127@eeebox2.perex-int.cz>
	<20100217130612.GD24165@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by alsa0.perex.cz (Postfix) with ESMTP id BA45A103858
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 14:55:09 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so214038fgg.2
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 05:55:09 -0800 (PST)
In-Reply-To: <20100217130612.GD24165@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 17 February 2010 13:06, Lennart Poettering <mznyfn@0pointer.de> wrote:
> On Wed, 17.02.10 10:04, Jaroslav Kysela (perex@perex.cz) wrote:
>
>> The second question is if the represented dB range and scale reported from
>> the driver (hardware and audio chip datasheets) really matches the
>> hardware and how we can measure these values. I suspect a lot of trouble
>> here, because the analog parts of soundcards might have strange curves -
>> it's probably thing you deal with in PA now.
>
> Yes, that is indeed the problem.
>
> For PA I don't care whether the dB curve reported by ALSA might be
> shifted relative to some reference level, what matters is that
> otherwise the curve reflects properly how volume increases with higher
> discrete volume settings.
>

So what you want it this.
Example 1:
If there are 2 gain controls between the CPU and the line-out.
A is at 0dB
B is at 0dB

If one changes A to +3dB and B to -3dB and one was playing a quiet
sound (so no distortion), the result should sound very similar, volume
wise, to the original 0dB, 0dB state.

Example 2:
There is one gain control between the CPU and the line-out that we are
interested in.
A is at 0dB.

If one changes A to +3dB and at the same time modify the source signal
digitally by -3dB, the result should sound very similar, volume wise,
to the original.

You would have to build your test tool so that it would detect
distortion as well as levels.This way you could also find out where
the limits really are in the chain.

This is a good aim, but I still think getting the correct 0dB points
is more important to ensure the best audio quality.
I personally think that PA should just set the hardware ALSA controls
to 0dB and do all the volume control in software within PA.
The 0dB points in hardware should result in the best sound quality.

James
