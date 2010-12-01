From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: tpa6130a2: Make
	DAPM	registration optional, and direct interface
Date: Wed, 1 Dec 2010 11:44:28 +0000
Message-ID: <20101201114427.GB5688@sirena.org.uk>
References: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101130143013.GM7403@rakim.wolfsonmicro.main>
	<201012010854.20201.peter.ujfalusi@nokia.com>
	<201012011007.57750.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 277B2103A0B
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 12:44:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201012011007.57750.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 01, 2010 at 10:07:57AM +0200, Peter Ujfalusi wrote:
> On Wednesday 01 December 2010 08:54:20 Ujfalusi Peter (Nokia-MS/Tampere) wrote:
> > On Tuesday 30 November 2010 16:30:13 ext Mark Brown wrote:

> > > Is there any situation where it would undesirable to do this?  If not
> > > it'd seem better to just make the driver do this always.

> > You mean to not have DAPM widgets/routes in the tpa6130a2 driver, and only
> > have a function, which can be used to turn on/off the amp?
> > The original [1] (first version) of the tpa6130a2 driver only had DAPM_HP
> > widget. It has been changed based on the comments.

You didn't mention any pop/click issues in the original patch or the
discussion following it as far as I remember - in your original patch
there was nothing motivating doing this

> If there's a need I can re-introduce tpa6130a2 provided DAPM_HP widget to reduce 
> duplicated code in machine drivers (when we have enough users for it).
> 
> What do you think?

I think this is a better approach since it solves an actual problem.  We
may want to consider introducing a new widget type for edge PGAs, though
I can see that getting overused.
