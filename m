From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Do DAPM control updates in the
 middle of DAPM sequences
Date: Fri, 17 Dec 2010 11:45:58 +0000
Message-ID: <20101217114558.GC31453@rakim.wolfsonmicro.main>
References: <1292349202-25538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201012161551.13096.peter.ujfalusi@nokia.com>
	<20101216135505.GA1344@sirena.org.uk>
	<201012170908.42046.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BEE04103891
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 12:45:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201012170908.42046.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 17, 2010 at 09:08:41AM +0200, Peter Ujfalusi wrote:

> In normal use case, it is filtered by the external amp, but I use non 
> convetional setup at the moment, and that is the reason for the pop.
> I need to take a look at this at some time :(

Ah, well.  At least the mux issue should be fixed now.

> You can pick either of my:

> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Tested-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Why choose? :)
