From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: dapm - Add API call to query the
 widgets of valid DAPM paths.
Date: Tue, 26 Jul 2011 15:37:34 +0100
Message-ID: <20110726143734.GG7285@opensource.wolfsonmicro.com>
References: <1311588926-3439-1-git-send-email-lrg@ti.com>
	<20110725211620.GC6086@opensource.wolfsonmicro.com>
	<1311678996.4088.4.camel@CNA0741383>
	<20110726114117.GD7285@opensource.wolfsonmicro.com>
	<1311690414.2610.12.camel@CNA0741383>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84C8D1038E0
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jul 2011 16:37:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1311690414.2610.12.camel@CNA0741383>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 26, 2011 at 03:26:54PM +0100, Liam Girdwood wrote:
> On Tue, 2011-07-26 at 13:41 +0200, Mark Brown wrote:

> > OK, right.  If we want to do that then a substantial proportion of the
> > existing CODEC drivers are broken - they're routinely putting in the
> > stream name they want to match against rather than adding extra text to
> > the stream to give unique names that are never used.

> They should all be OK, the stream event performs a strstr() on each
> stream widget so will match left/right etc streams based on the DAI
> stream name. 

The case I'm worried about is the case where we've got two widgets with
identical stream names - left and right AIF both call their playback
widget stream "Playback" or whatever.

> > It does feel like this ought to be looking things up by widget rather
> > than by stream, though.  Widget names are already guaranteed unique and
> > if the users do want to look things up for a single widget only it seems
> > to make sense to ask for that widget rather than ask for a stream as
> > it's not how we're currently using streams.  It feels like if we're
> > asking for a stream we should do the same substring multi-match that we
> > do when pushing events into them.

> V2 did the substring match, although now that more complex hardware is
> appearing I wonder if we should connect DAIs to widgets with the widget
> name (rather than just relying on the substring). i.e. each DAI could
> have a list of AIF widgets (most would have 1 or 2). Both methods could
> co-exist for a while with the substring method being deprecated.

Yes, there's definitely room to improve here - one thing I'd like to see
is a system for mapping individual channels in the played audio so if
for example we're playing mono data (or stereo data on a 5.1 CODEC) then
we can figure out that lots of the channels aren't actually in use and
not power them on.
