From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v2 4/4] sh: add FSI driver support for
	ms7724se
Date: Fri, 21 Aug 2009 08:43:27 +0900
Message-ID: <20090820234327.GA31542@linux-sh.org>
References: <utz02d78o.wl%morimoto.kuninori@renesas.com>
	<20090820190626.GH5032@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 1844A103857
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Aug 2009 01:43:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090820190626.GH5032@sirena.org.uk>
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
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 20, 2009 at 08:06:26PM +0100, Mark Brown wrote:
> On Thu, Aug 20, 2009 at 09:01:27PM +0900, Kuninori Morimoto wrote:
> > Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> 
> > o become independent patch
> 
> It looks like this should have another change to register the CODEC as
> an I2C device?  Other than that it's fine from an ASoC point of view -
> is it OK to merge via ASoC due to the dependency on the platform data
> for the FSI?

I have other ms7724se patches queued up for 2.6.32, so the easiest thing
to do is just to leave this patch until the dependencies are upstream,
then I'll fold it in. This is how we usually handle these sorts of merge
dependencies anyways.
