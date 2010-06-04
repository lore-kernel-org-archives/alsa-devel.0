From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: External samplerate changes, UAC2 clock topologies
Date: Fri, 4 Jun 2010 21:49:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006042130390.5693@eeebox2.perex-int.cz>
References: <20100604124635.GL2698@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E29B510384C
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jun 2010 21:49:37 +0200 (CEST)
In-Reply-To: <20100604124635.GL2698@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 4 Jun 2010, Daniel Mack wrote:

> Hi,
>
> when I implemented the basics for parsing the UAC2 clock functions, I
> came across some principal questions I would like to discuss.
>
> As I wrote in the commit log, UAC2 supports a number of clock units
> which can be combined to complex topologies. The single unit types are
>
> - clock sources (can be fixed, variable, programmable and synced to the
>   USB clock)
> - clock switches, which let the host decide which one out of many input
>   pins appears on its output pin
> - clock multipliers, which have a numerator and a denominator, and both
>   can be read-only or read-write, respectively
>
> A clock source has controls for its frequency and its validity,
> a clock selector has a control to control its current state, and
> a clock multiplier has controls for its numerator and denominator
>
> The driver is currently able to walk the graph of connected units in
> order to find CLOCK_SOURCE descriptors as end-leafs. This is mandatory
> as all requests for sample rate queries have to be sent to this unit
> type.
>
> This raises the first question, as the driver can only know which sample
> rates are supported in the currently selected combination of selectors.
> Once the user changes any of them (which is currently already possible
> as clock selectors are exported as mixer controls), everything can
> change. And this can even happen while the stream is active, because
> there's currently no check about whether the clock selector is part of
> the actively used path.
>
> The second issue I see is that a clock can lose its validity. A
> real-life example is an external S/PDIF connected device which provides
> a clock and which is suddenly disconnected. Firmwares are expected to
> notify the host about such cases, and these messages are trivial to
> dispatch. However, I wonder how the driver should react on this. From
> a user's perspective, it would be best to just make the driver find
> another clock path which reports a valid clock source endpoint, changes
> the sample rate accordingly and continues streaming. There would be
> a gap in the stream of course, but at least it would not kill the
> applications or require major exception handling in userspace.

But what's better? Get a wrong stream or notify application that something 
went in a different way than settled in the parameter setup phase?

> I wonder which approaches are actually possible to implement, which
> details in the ALSA core would need to be extended, and so on.
>
> Any oppinions? Has this been done before for any other audio hardware
> supported by ALSA?

If a stream parameter changes, the driver should interrupt streaming 
immediatelly. The check should be in the trigger() callback (-EIO error 
code) and if the stream is already running - it should be put to the
SNDRV_PCM_STATE_DRAINING (capture) to let the application obtain the 
captured samples until the parameter change. Just call snd_pcm_stop() with 
the new state for the substream. For playback, the stream should be put 
to the SNDRV_PCM_STATE_OPEN state to wait to settle new parameters from 
an application (it means that all I/O ops will return -EBADFD).

I implemented this behaviour in pdaudiocf driver (sound/pcmcia/pdaudiocf) 
- for the capture direction.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
