From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1 - try2] ASoC: add support for
	multiple	cards/codecs in debugfs
Date: Thu, 1 Oct 2009 15:06:03 +0100
Message-ID: <20091001140559.GA29526@sirena.org.uk>
References: <1254382367-27948-1-git-send-email-peter.ujfalusi@nokia.com>
	<200910011402.04406.peter.ujfalusi@nokia.com>
	<20091001110919.GC19998@rakim.wolfsonmicro.main>
	<200910011649.17727.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EF4D810396B
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 16:06:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200910011649.17727.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 04:49:17PM +0300, Peter Ujfalusi wrote:

> One of the codec to be blamed is the twl4030 codec, but since that does not use 
> any _device/_driver method to load, there is no dev to be assigned to codec-
> >dev...
> I don't know if it would make sense to use platform_driver_register (and 
> associates) with it in the future.

Yes, it should be using a platform device and the MFD framework (as most
of the other TWL4030 subdevices do already).

> > your CODEC driver needs updating to current APIs

> Hmm, there are quite a bit of inconsistency among the codec drivers, so I'm not 
> sure what is the correct way of doing this.
> I will use the wm8993 driver for further fine tuning, since that seams to be 
> rather new in the tree.

In general look at the drivers that have been touched most recently -
wm8993 is a good one, as are wm8903 and wm8731, but the main thing is to
look at one that's not registering the DAIs in the module init function
but is using normal device model probing and registering the DAIs only
after the underlying device has come up.

> I'll send a patch later to fix this implementation:
> if the codec->dev is valid, than it is going to use dev_name(codec->dev), if it 
> is NULL, than it will use either the codec->name or provide the same string as 
> the current implementation does ( {dev_name(socdev->dev)}-{codec->name} ), 
> whichever is the preferred.

I'd just leave it as codec->name - the soc-audio device name doesn't add
anything.
