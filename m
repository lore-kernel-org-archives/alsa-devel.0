From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/2] ASoC: Do DAPM control updates in the
	middle of DAPM sequences
Date: Fri, 17 Dec 2010 09:08:41 +0200
Message-ID: <201012170908.42046.peter.ujfalusi@nokia.com>
References: <1292349202-25538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201012161551.13096.peter.ujfalusi@nokia.com>
	<20101216135505.GA1344@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F758103830
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 08:08:43 +0100 (CET)
In-Reply-To: <20101216135505.GA1344@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 16 December 2010 15:55:05 ext Mark Brown wrote:
> On Thu, Dec 16, 2010 at 03:51:13PM +0200, Peter Ujfalusi wrote:
> > It behaves mostly OK, but there's a strange side effect:
> > I noticed a pop on playback stream start on the twl4030 codec.
> > I'll look into it, but I do not see how this patch can affect the stream
> > start..
> 
> Indeed, it should result in an extra comparison in the middle of the
> DAPM sequence which oughtn't to have any effect here.  Is it possible
> that some of the other updates that have been going in recently such
> as the cross-device changes introduced this, or is it definitely just
> this one patch?

Found the reason..
The pop is there without this patch, it is coming from the output amp power up.
In normal use case, it is filtered by the external amp, but I use non 
convetional setup at the moment, and that is the reason for the pop.
I need to take a look at this at some time :(

> > Could you hold this patch for some time, so I can look at this?
> 
> Sure.

Thanks,
You can pick either of my:

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
