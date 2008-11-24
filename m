From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 5/9] ASoC: TWL4030: Add PreDriv outupt mux
	and volume controls
Date: Mon, 24 Nov 2008 14:50:31 +0000
Message-ID: <20081124145031.GH22394@sirena.org.uk>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-6-git-send-email-peter.ujfalusi@nokia.com>
	<20081124134808.GB22394@sirena.org.uk>
	<200811241619.18786.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C5A99103816
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 15:50:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200811241619.18786.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 24, 2008 at 04:19:18PM +0200, Peter Ujfalusi wrote:
> On Monday 24 November 2008 15:48:09 ext Mark Brown wrote:

> > I know quite a few existing drivers use an array of enums but please
> > don't do this for new code - it doesn't help legibility to have to find
> > the enums in the table.

> I have seen this approach in several codec code, so I have also implemented
> in a same way.
> I will change it.
> Do you have a pointer, where should I look for existing code?

At least WM8990 and WM8903 do this with separate controls.  Most of the
drivers should be fine to look at for examples, it's just that this was
done for some of the older drivers and it's never been worth changing
them.

> > Is this really an enum?  The fact that it's described as a mixer and

...

> > in other drivers for examples.  If it's really an enum then calling it a
> > mux is probably better.
> 
> Hmmm, the situation is kind of both...
> The selection is done in a bitfield.
> Let's take the PREDL, as I used that in the helper function comment:
>  bit 0 (0x1): voice_en
>  bit 1 (0x2): Audio L1 enable (DACL1)
>  bit 2 (0x4): Audio L2 enable (DACL2)
>  bit 3 (0x8): Audio R2 enable (DACR2)
> The voice path can be enabled/disabled independently from the digital
> paths, but only _one_ of the DACL1, DACL2 or DACR2 can be selected at
> the time.

Oh, ick.  There's a couple of ways I can think of to represent that to
DAPM.  One would be to have a simple mixer with switches for everything
and an extended event on the mixer which returns an error if multiple
DAC inputs are enabled.  The other is to have the DAC selection be a
custom mux like you've got and feed that into the mixer unconditionally.
The voice input should certainly be a separate control here.

> On top of that the mute can be performed by setting all four bits to 0.
> I don't know actually what that means, but probably than the PreDriv
> path will be effectively turned off.

That's just equivalent to turning off all the inputs so sounds like it
shouldn't need any special handling.

> On the side not: the voice path at the moment not in use -> the codec has
> to be in different mode to have the voice path enabled. But then lot's of
> things will behave differently.

Could you go into more detail about these modes?  Sounds like it could
get tricky...

> Initially I did not wanted to spread these controls - to make it simple
> for myself, but I might separate the voice and DAC mux selections (separated
> enable for voice and mux the DACL/Rs selection).

Yes, that does sound like the best approach.
