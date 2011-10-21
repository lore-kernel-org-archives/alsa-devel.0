From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v7 1/3] ASoC: da7210: Add support for DAPM
Date: Fri, 21 Oct 2011 11:23:50 +0100
Message-ID: <20111021102350.GA4080@opensource.wolfsonmicro.com>
References: <1319119369.24621.84.camel@matrix>
	<20111021085838.GE3513@opensource.wolfsonmicro.com>
	<1319190446.24621.158.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0457524518
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 12:23:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319190446.24621.158.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2011 at 03:17:26PM +0530, Ashish Chavan wrote:
> On Fri, 2011-10-21 at 09:58 +0100, Mark Brown wrote:

> > This explanation would better placed next to the code in the probe -
> > it's that code which looks out of place in a Linux driver.

> Only problem with that is the code to enable individual IOs is not at
> one place and is scattered in the probe(). Should I place all such
> things in a single block in probe() and put the comment above that?

That sounds like a good idea - it's fine to split them up per feature
being enabled but if the big comment is in front of all of them that'd
be really helpful.
