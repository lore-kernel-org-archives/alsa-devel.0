From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: gusclassic alsa configuration
Date: Wed, 21 Jan 2009 23:50:37 +0200
Message-ID: <20090121215037.GC4996@sci.fi>
References: <20090121223507.778f954d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.welho.com (smtp6.welho.com [213.243.153.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EAA31037E3
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 22:50:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090121223507.778f954d.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 21, 2009 at 10:35:07PM +0100, Krzysztof Helt wrote:
> Hi,
> =

> I have given another go to fix Gravis Ultrasound configuration for ALSA =

> and I have found a working configuration. The Gravis Classic card uses
> non-mmap and non-interleaved sound format so aplay fails with standard
> configuration. Even worse, no default pcm device is defined so someone
> who wants just install Linux on old computer won't get any sound.
> =

> I have modified the GUS.conf from the /usr/share/alsa/cards and the
> GUS card now works with alsa and oss. My changes to the GUS.conf
> are below (as a diff).
> =

> Does anybody know how to upload MIDI instruments into the GUS card
> under ALSA? (like with awesfx for SB AWE)

I think some of the related code was never brought over from the ultra
sound project driver. MIDI emulation is at least missing. There was/is
some support for loading at least simple instruments (eg. mod samples).
I was trying to get mikmod to work with ALSA sequencer + GUS PNP at some
point. I managed to get decent playback but I never got the timing
related stuff working correctly. That was many years ago though. At the
moment all of my GUS cards are gathering dust on the shelf but if you're
going to hack around with this stuff I can at least volunteer as a tester.

My mikmod patch is still @ http://www.sci.fi/~syrjala/alsa/

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
