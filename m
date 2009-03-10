From: Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH 4/4] ALSA: ASoC: Davinci: Fixed missing
 McBSP pinmux for SFFSDR
Date: Tue, 10 Mar 2009 10:03:41 -0400
Message-ID: <20090310100341.cc08cc08.hugo@hugovil.com>
References: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
	<1236655929-31688-5-git-send-email-hugo@hugovil.com>
	<20090310102921.GA12297@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A1951037F2
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 15:03:46 +0100 (CET)
In-Reply-To: <20090310102921.GA12297@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Mar 2009 10:29:23 +0000
Mark Brown <broonie@sirena.org.uk> wrote:

> On Mon, Mar 09, 2009 at 11:32:09PM -0400, Hugo Villeneuve wrote:
> >  		return -EINVAL;
> >  
> > +	davinci_cfg_reg(DM644X_MCBSP);
> > +
> 
> I can't find any references to this function in mainline?

Hi Mark,
I based those patches on the latest linux-davinci git tree, which has
the function.

> Most of the
> ARM variants do this sort of configuration in the arch/arm code which
> was why I was looking for other users to see what was idiomatic for
> DaVinci.

In fact I just duplicated what was done for the evm board in
sound/soc/davinci/davinci-evm.c, which also has the davinci_cfg_reg()
function (in the linux-davinci tree):

  http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=commit;h=da57d7068350741e62671a7f619d5b4fad2727c0

> I've applied the other three patches.

Thanks, Hugo V.
