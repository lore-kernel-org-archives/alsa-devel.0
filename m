From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
 cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 10:04:50 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002170924570.28127@eeebox2.perex-int.cz>
References: <4B7A5268.5050704@ladisch.de>
	<alpine.LNX.2.00.1002160912140.28127@eeebox2.perex-int.cz>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<4B7B2E9F.3080809@audioscience.com>
	<20100217001047.GB6766@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BEBC110384B
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 10:04:50 +0100 (CET)
In-Reply-To: <20100217001047.GB6766@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 17 Feb 2010, Lennart Poettering wrote:

> Yepp, that's the exactly what I was asking, Jaroslav's measurements
> suggested to shift one of the mixer controls from 0..x dB to -x..0 dB
> and I was just wondering why, since we don't define the ref level in
> ALSA, hence the shift is kinda arbitrary...

I think that having a reference level is good for users. For example, 
some AC97 codecs have Line Out range from -94.5dB .. 0dB , Mixed Line In 
is in range -34.5dB .. 12dB. So if I set 0dB to Line In and 0dB to Line 
Out, I would expect to get (if analog parts of soundcard are not 
assymetric) identical output level as input level.

For USB card as I mentioned, I got Line Out from range -48dB..0dB and Line 
In in 0dB..48dB. I would assume from the first look to the alsamixer 
volume bars that the Line In gain is too much.

It's about consistency for users. Rule <0dB attenuation >0dB gain matches 
this criterium.

The second question is if the represented dB range and scale reported from 
the driver (hardware and audio chip datasheets) really matches the 
hardware and how we can measure these values. I suspect a lot of trouble 
here, because the analog parts of soundcards might have strange curves - 
it's probably thing you deal with in PA now.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
