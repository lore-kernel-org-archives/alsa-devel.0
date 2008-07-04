From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Au12x0/Au1550 PSC Audio support.
Date: Fri, 04 Jul 2008 18:36:56 +0100
Message-ID: <1215193016.6440.13.camel@odin>
References: <20080703073309.GA24116@roarinelk.homelinux.net>
	<1215077359.4882.115.camel@localhost.localdomain>
	<20080703095344.GA24177@roarinelk.homelinux.net>
	<1215078947.4882.117.camel@localhost.localdomain>
	<20080703100925.GA25364@roarinelk.homelinux.net>
	<s5h1w29lm20.wl%tiwai@suse.de>
	<486E4ED9.4050106@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5FA9F24ACB
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 19:37:03 +0200 (CEST)
In-Reply-To: <486E4ED9.4050106@roarinelk.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-07-04 at 18:24 +0200, Manuel Lauss wrote:
> Hello Takashi,
> 
> Takashi Iwai wrote:
> > 
> > Shall I apply this one?  At a quick glance, the patch looks OK.
> 
> I certainly have no objections, but I intended to wait for ASoCv2 to hit
> mainline, convert the drivers to it, then (re)submit. There's still a lot
> to be done IMO (it has never been tested with preemption, i2s bitclk master
> mode is untested, ...)
> 

Please apply.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

Btw, I've now started sending patches for v2 (although I seem to have
sent a little extra in the last patch ) ;)
