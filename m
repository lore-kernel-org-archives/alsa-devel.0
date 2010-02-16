From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Tue, 16 Feb 2010 21:48:18 +0000
Message-ID: <ad2655cb1002161348p7be432a1qb5fcf28804ef5c00@mail.gmail.com>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f209.google.com (mail-fx0-f209.google.com
	[209.85.220.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 77AAC2445F
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 22:48:19 +0100 (CET)
Received: by fxm1 with SMTP id 1so6960218fxm.4
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 13:48:18 -0800 (PST)
In-Reply-To: <20100216154015.GA612@tango.0pointer.de>
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

On 16 February 2010 15:40, Lennart Poettering <mznyfn@0pointer.de> wrote:
>
> I remember that a while back we had a discussion on alsa-devel
> regarding the fact that ALSA does not define relative to what the dB
> values reported by the mixer elements actually are measured. Some
> mixer controls export dB values relative to max amplification (e.g. my
> integrated USB speakers here), others relative to the output of some
> other mixer element, and others relative to different standard or
> not-so-standard output voltages. =A0And there is no API to figure out
> what the base is.
>
> Now, what Jaroslav listed above suggests that he chose carefully where
> he put 0dB. I was just wondering about that. Jaroslav, how did you
> choose where to put 0dB?
>

I think what you are trying to do is actually quite difficult.
The rules are very simple for digital controls. At 0dB the gain is 0
and the attenuation is 0 so the value going into the control will be
identical to the value after the control.
The trouble starts at the analogue stages.
First we would want to decide on what output we actually want.
I think this would depend on the sound card itself. Pro sound cards
can output a different set of levels than consumer sound cards.
I think the only way to fix the current problem is to determine a
sound card that has the correct levels and controls, and then
calibrate other sound cards from that.
It will take a long time.
Up until now, the best we have been able to do is read data sheets and
use the values form the data sheets.

I guess a good start would be what digital values should create what
voltages on the line output?
One can then at least get the 0dB point set right.

Kind Regards

James
