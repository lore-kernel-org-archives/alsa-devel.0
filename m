From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/9] ASoC: da7210: Add support for ALC and
 Noise suppression
Date: Thu, 13 Oct 2011 11:26:03 +0100
Message-ID: <20111013102602.GH1098@sirena.org.uk>
References: <1318432070.12107.426.camel@matrix>
	<20111012150404.GT3647@opensource.wolfsonmicro.com>
	<1318497345.12107.443.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 54080103851
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 12:26:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318497345.12107.443.camel@matrix>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, linux-kernel <linux-kernel@vger.kernel.org>, kuninori.morimoto.gx@renesas.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 13, 2011 at 02:45:45PM +0530, Ashish Chavan wrote:
> On Wed, 2011-10-12 at 16:04 +0100, Mark Brown wrote:

> > No, don't go peering directly into the register cache.  This is going to
> > explode if the board configures a different cache style and means you
> > can't change the cache type later.  Just read the register and trust
> > that the cache will do something sane.

> Will update the code to directly read the register. I thought of saving
> some io bandwidth and if I remember correctly, I saw few exiting drivers
> doing this.

The whole point of having the register cache is that reads don't result
in any actual I/O, if there's any I/O happening we need to fix the
register cache code.
