From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: snd_soc_dai_link.init()
Date: Thu, 31 May 2007 18:09:22 +0100
Message-ID: <1180631362.29590.90.camel@a10072.wolfsonmicro.main>
References: <465DFBF5.9040800@freescale.com>
	<1180630964.29590.83.camel@a10072.wolfsonmicro.main>
	<465F0025.4010008@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 05FE1245D4
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2007 19:09:24 +0200 (CEST)
In-Reply-To: <465F0025.4010008@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-05-31 at 12:04 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> > On Wed, 2007-05-30 at 17:34 -0500, Timur Tabi wrote:
> >> Liam,
> >>
> >> Why does the init() function pointer in the snd_soc_dai_link structure take a 
> >> snd_soc_codec pointer?  Wouldn't it make more sense for it to take a snd_soc_dai_link 
> >> pointer?  That way, I could use the init() function to initialize the structure.
> >>
> > 
> > Your right, I've logged a bug.
> > 
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3135
> > 
> > I should have some time to look at the bugs tomorrow.
> 
> I'd be happy to create a patch that fixes it today, if you like.  I just need to know the 
> URL of the git tree to use as a starting point.
> 

http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=summary

Master branch should be up to date with mainline, for-alsa-kernel branch
should be close to alsa-kernel Hg.

Liam  
