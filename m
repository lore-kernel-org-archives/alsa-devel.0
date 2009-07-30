From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/20] OMAP ASoC changes in DMA utilization
Date: Thu, 30 Jul 2009 14:52:57 +0100
Message-ID: <20090730135257.GE9975@sirena.org.uk>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B9661037F8
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jul 2009 15:52:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 30, 2009 at 03:49:23PM +0300, Eduardo Valentin wrote:

> Patches 1-15 are McBSP changes and, for this reason, are intended to
> be include in linux-omap tree.
> Patches 16-20 are OMAP ASoC driver changes, so, they are for alsa-devel.

I'm OK with the ASoC changes.  It looks like there are some dependencies
on the OMAP changes in there so they should probably go via the OMAP
tree?
