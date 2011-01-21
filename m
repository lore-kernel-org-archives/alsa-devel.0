From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-cache: Add trace event for
 snd_soc_cache_sync()
Date: Fri, 21 Jan 2011 14:54:27 +0000
Message-ID: <1295621667.5771.4.camel@dplaptop.localdomain>
References: <1295620548-26297-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20110121144634.GA6200@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 057B124624
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 15:55:17 +0100 (CET)
In-Reply-To: <20110121144634.GA6200@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-01-21 at 14:46 +0000, Mark Brown wrote:
> On Fri, Jan 21, 2011 at 02:35:48PM +0000, Dimitris Papastamos wrote:
> > This patch makes it easier to see which of the register writes are part
> > of the cache syncing functionality.
> 
> Might be more useful to have sync start and end events?  That way we can
> not only see which writes are part of the sync but we can also see how
> long the overall process takes, helping diagnose if our CPU side stuff
> is too expensive.

I'll add those yes and remove the one I've got now.

Thanks,
Dimitris
