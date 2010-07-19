From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - alsa-lib 2/3] tlv: Handle 'holes' in
 SND_CTL_TLVT_DB_RANGE array
Date: Mon, 19 Jul 2010 18:09:47 +0100
Message-ID: <20100719170947.GA5950@rakim.wolfsonmicro.main>
References: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>
	<1279523646-4987-3-git-send-email-peter.ujfalusi@nokia.com>
	<s5heiezfp1c.wl%tiwai@suse.de>
	<20100719160109.GC7002@sirena.org.uk>
	<s5h630bfo3x.wl%tiwai@suse.de>
	<20100719162416.GD7002@sirena.org.uk>
	<s5h39vffmkw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC93E2456F
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 19:09:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h39vffmkw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 19, 2010 at 06:44:31PM +0200, Takashi Iwai wrote:

> The guess work isn't always trivial.  If the hardware switches the
> curve between log and linear over a hole, which should be taken for a
> value in the hole?  Whne TLV is given for the hole, at least it's a
> good hint.

I don't see what difference the curves make here?  However the gap is
expressed only the points at either end are selectable (and there's
always the chance that this is part of a series of random individual
points with no particular curve through them).

> > Personally I'd rather the kernel just provided a mapping between control
> > values and dB scales and then the application layer can decide what it
> > thinks an appropriate match is.  Decisions about how accurate a match is
> > needed seem very policy like and therefore userspaceish and it seems
> > wrong to be coding the data tables in the kernel in a way that works
> > around the particular match algorithm in the application layer.

> User space can check the correctness always by checking the reverse
> conversion between dB <-> value again.

It still seems silly to have to paper over this for every single dB
interval - if we need to link up the ranges it seems like we ought to
be fixing this in one place.
