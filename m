From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] ASoC: multi-comp: OMAP platform fixes
Date: Fri, 6 Aug 2010 13:22:22 +0100
Message-ID: <20100806122222.GJ398@rakim.wolfsonmicro.main>
References: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A5F961039DD
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 14:22:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281080355-22589-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, jkrzyszt@tis.icnet.pl, arunks@mistralsolutions.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 06, 2010 at 10:39:12AM +0300, Peter Ujfalusi wrote:

> The following series introduces some cleanups for OMAP platforms in
> multi-component branch.
> 
> - Enable audio for OMAP1 class
> - Registers only the available amount of omap-mcbsp-dai devices for OMAP2,3,
>   and 4
> 
> Please do verify, if the chages are correct, especially the number of McBSP
> ports on different devices.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

from a code point of view only (ie, I've no idea if the definitions are
correct for any particular OMAP).
