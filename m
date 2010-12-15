From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Remove unused DAPM_DOUBLE
	control types
Date: Wed, 15 Dec 2010 18:10:37 +0000
Message-ID: <20101215181037.GD9275@rakim.wolfsonmicro.main>
References: <1292349202-25538-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1292420229.3348.12.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 471E42459C
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 19:10:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1292420229.3348.12.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 15, 2010 at 01:37:09PM +0000, Liam Girdwood wrote:
> On Tue, 2010-12-14 at 17:53 +0000, Mark Brown wrote:
> > There are no users of these and it's not clear what they would do given
> > the mono flow modelling which DAPM does. If need arises we can add them
> > again.
> > 
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> All

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

I've pushed the first patch out now but I'll wait for Peter's testing
before doing anything with the second one.
