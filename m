From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC v1] ASoC: core: Support for limiting
 the volume
Date: Fri, 7 May 2010 11:05:12 +0100
Message-ID: <20100507100511.GB21498@rakim.wolfsonmicro.main>
References: <1273212185-7129-1-git-send-email-peter.ujfalusi@nokia.com>
	<201005071026.35702.peter.ujfalusi@nokia.com>
	<20100507095614.GA27795@sirena.org.uk>
	<201005071303.53132.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 48D6824503
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 12:05:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201005071303.53132.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, May 07, 2010 at 01:03:53PM +0300, Peter Ujfalusi wrote:

> I think:
> if (max <= mc->max) {
> 	mc->max = max;
> 	ret = 0;
> }

> Would be appropriate. We still report error, if the user asked out of limit 
> gain, but we report success, if the limit has not been actually changed.

Yes, reporting an error if the limit is higher than is possible is
sensible.
