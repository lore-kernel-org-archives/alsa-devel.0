From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/3] ALSA SoC: Add OpenFirmware
	helper	for matching bus and codec drivers
Date: Tue, 22 Jul 2008 18:51:22 +0100
Message-ID: <20080722175121.GA6432@sirena.org.uk>
References: <20080722065352.7306.60679.stgit@trillian.secretlab.ca>
	<9e4733910807220938k7452f40co8d51e4b03e79ee8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 10A7F103805
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 19:51:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807220938k7452f40co8d51e4b03e79ee8b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2008 at 12:38:30PM -0400, Jon Smirl wrote:
> On 7/22/08, Grant Likely <grant.likely@secretlab.ca> wrote:

> >  +int of_snd_soc_register_platform(struct snd_soc_platform *platform,
> >  +                                struct device_node *node,
> >  +                                struct snd_soc_dai *cpu_dai);
> >  +

> This doesn't compile for me.  Where is struct snd_soc_dai being defined?

> It used to be....

In ALSA and ASoC git struct snd_soc_{cpu,codec}_dai have been replaced
by a shared snd_soc_dai defined in soc.h as the previous two were.
