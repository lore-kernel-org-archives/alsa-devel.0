From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v3] ASoC: dapm - Add API call to query the
 widgets of valid DAPM paths.
Date: Tue, 26 Jul 2011 15:26:54 +0100
Message-ID: <1311690414.2610.12.camel@CNA0741383>
References: <1311588926-3439-1-git-send-email-lrg@ti.com>
	<20110725211620.GC6086@opensource.wolfsonmicro.com>
	<1311678996.4088.4.camel@CNA0741383>
	<20110726114117.GD7285@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id D49C71038D6
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jul 2011 16:27:02 +0200 (CEST)
In-Reply-To: <20110726114117.GD7285@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-07-26 at 13:41 +0200, Mark Brown wrote:
> On Tue, Jul 26, 2011 at 12:16:36PM +0100, Liam Girdwood wrote:
> > On Mon, 2011-07-25 at 23:16 +0200, Mark Brown wrote:
> 
> > > Hrm, so I must be missing something here but this still has the issue
> > > with only finding the first widget if we've got more than one widget for
> > > a stream.  For example, the tlv320aic3x driver defines:
> 
> > >    SND_SOC_DAPM_DAC("Left DAC", "Left Playback", DAC_PWR, 7, 0),
> > >    SND_SOC_DAPM_DAC("Right DAC", "Right Playback", DAC_PWR, 6, 0),
> 
> > > and hooks them both up to a single "Playback" stream (most devices don't
> > > even have the distinct names at the widget level).  
> 
> > This will only match on the exact name here. So we can retrieve both
> > left and right stream widgets by making two separate calls. We should
> > also not have two AIF widgets with the same stream name within a DAPM
> > context.
> 
> OK, right.  If we want to do that then a substantial proportion of the
> existing CODEC drivers are broken - they're routinely putting in the
> stream name they want to match against rather than adding extra text to
> the stream to give unique names that are never used.
> 

They should all be OK, the stream event performs a strstr() on each
stream widget so will match left/right etc streams based on the DAI
stream name. 

> It does feel like this ought to be looking things up by widget rather
> than by stream, though.  Widget names are already guaranteed unique and
> if the users do want to look things up for a single widget only it seems
> to make sense to ask for that widget rather than ask for a stream as
> it's not how we're currently using streams.  It feels like if we're
> asking for a stream we should do the same substring multi-match that we
> do when pushing events into them.

V2 did the substring match, although now that more complex hardware is
appearing I wonder if we should connect DAIs to widgets with the widget
name (rather than just relying on the substring). i.e. each DAI could
have a list of AIF widgets (most would have 1 or 2). Both methods could
co-exist for a while with the substring method being deprecated.

Liam 
