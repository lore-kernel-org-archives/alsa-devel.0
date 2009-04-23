From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: trouble with alsa, wolfson, and TI OMAP35xx McBSP
Date: Thu, 23 Apr 2009 12:15:11 +0100
Message-ID: <20090423111511.GP30105@sirena.org.uk>
References: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
	<200904231220.14465.peter.ujfalusi@nokia.com>
	<200904231204.05991.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 86A08103815
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 13:15:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904231204.05991.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2009 at 12:04:05PM +0100, Alan Horstmann wrote:

> Does this indicate that the implementation/drivers of i2s has a fundamental 
> ambiguity?  Is it not rigidly defined which channel should follow a rising 
> edge of L/R clock?

It's clearly defined to be that the left channel follows the falling
edge of LRCLK (ie, the left channel data is transmitted while LRCLK is
low).  However, not all CPUs do a wonderful job of implementing this -
some of the older Samsung chips need a workaround for synchronisation,
for example.
