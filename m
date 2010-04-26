From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC: OMAP/TI upstream route
Date: Mon, 26 Apr 2010 18:13:47 +0100
Message-ID: <1272302027.3208.209.camel@odin>
References: <1272293803.3208.85.camel@odin>
	<20100426192228.228489c7.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CF622463E
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Apr 2010 19:13:50 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so1850100fga.2
	for <alsa-devel@alsa-project.org>; Mon, 26 Apr 2010 10:13:49 -0700 (PDT)
In-Reply-To: <20100426192228.228489c7.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-04-26 at 19:22 +0300, Jarkko Nikula wrote:
> Hi
> 
> On Mon, 26 Apr 2010 15:56:43 +0100
> Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> 
> > Now that I'm back working full time on ASoC I'm going to manage the
> > upstream branch for the OMAP platform and TI codecs. Mark will continue
> > to manage the upstream for all other codecs, platforms and core.
> > 
> > As usual, please CC both Mark and I on new ASoC patches. The OMAP
> > upstream branch tracks Takashi's topic/asoc branch and is here :-
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git #for-2.6.35
> > 
> To clarify: is this new tree for handling possible cross tree issues
> with current and future ASoC OMAPs?
> 
> I don't see a need for own tree for plain sound/soc/omap/ patches but
> this could makes sense for patches that touch also arch/arm/ (we have
> had a few cases) or sounc/soc/codec/ (if we ever have such a need?).
> 

This is not a cross tree merge branch or OMAP patch dumping area.

Everything is just carrying on as before except the upstream management
effort is being divided between Mark and I. i.e. I'll manage the TI/OMAP
based patches, Mark will manage the rest.

Patch submitters should not notice any difference as both trees are
based on Takashi's ASoC branch and are regularly kept up to date.

Any patches that are likely to cause merge pain will still go via the
best route (as the currently do now) and with the appropriate Ack's.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
