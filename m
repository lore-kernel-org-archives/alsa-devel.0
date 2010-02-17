From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Wed, 17 Feb 2010 11:44:20 +0800
Message-ID: <4f3252891002161944m197e60c1pbb600cab8e0fd483@mail.gmail.com>
References: <20100215192451.GA17938@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f198.google.com (mail-pz0-f198.google.com
	[209.85.222.198])
	by alsa0.perex.cz (Postfix) with ESMTP id AC3AD103853
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 04:44:21 +0100 (CET)
Received: by pzk36 with SMTP id 36so7842720pzk.23
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 19:44:20 -0800 (PST)
In-Reply-To: <20100215192451.GA17938@tango.0pointer.de>
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

2010/2/16 Lennart Poettering <mznyfn@0pointer.de>

> Heya,
>
> a while back I wrote a little tool "dbmeasure" which can be used to
> determine dB attenuation data for alsa mixer controls. I have now
> extended this little dB tools suite to include a tiny tool "dbverify"
> that can be used to verify the correctness of existing dB data exposed
> by the drivers. It should be relatively easy to use that tool,
> suitable even for non-guru folks who want to debug the dB information
> from alsa.
>
> http://git.0pointer.de/?p=dbmeasure.git
> git://git.0pointer.de/dbmeasure.git
>
> Just run "make" in a git checkout and then try:
>
>   $ ./dbverify Aureon51MkII Master 30 200
>
> That will verify the dB data of the "Master" control of the sound card
> that goes by the id "Aureon51MkII". It will compare the discrete
> volume steps 30 and 200: first it will play a full amplitude sine wave
> at mixer volume step 30, and then will change to mixer volume step
> 200, but attenuate the sine wave in software compensating for the
> volume change. So once you hear the sine wave attenuated by the hw,
> and once by the software. If the card's dB data is correct both sines
> should have the same volume.
>
> Now, playing around with this, I could verify what I already mentioned
> to Jarsolav elsewhere earlier: it seems that particularly USB cards
> seem to expose invalid dB data (at least all mine do). For example,
> for the above mentioned Aureon 5.1 it's really *way* off -- if you
> posess that card just run the line above, and listen to the
> difference. It's really bad. OTOH the dB data of the HDA cards I own
> is pretty accurate as it seems, at least I was unable to decide just
> by listening which sine wave was attenuated by sw, and which by hw.
>
> Getting back to the invalid dB data from the USB cards: the question
> is whether the USB descriptor data is badly parsed, and the dB
> mismatch hence systematic for USB cards, or if these cards are just
> crappy and include invalid data? In which case I wonder what we could
> do about that? The Aureon's dB range already looks suspicous, since
> both the max and the min dB value are < 0 (-47.69 to -1.97), so maybe
> we could add some heuristics to filter out data that already looks
> suspicous?
>
> Invalid dB data from the driver is a real problem for the "flat
> volume" logic in PA. We basically allow each app to control the full
> hw volume range individually, and then set the hw volume to the max of
> what all apps wanted and attenuate the other streams accordingly. On
> the Aureon this doesn't work at all, since the attenuation of the
> streams is miscalculated due to the invalid dB data.
>
> Lennart
>
>
Refer to README

WHAT YOU NEED?

         a) A sound card where input and output are synchronous
         b) A feedback cable that allows you to feed sound card output


how do I know my sound card support synchronous playback and  capture ?

do you program able to find out whether the sound card support synchronous
playback and  capture ?

do your result still valid if the sound card does not support synchronous
playback and  capture ?

do the result different if I use analog loop back of the ac97 codec instead
of a loop back cable ?
