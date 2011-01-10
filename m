From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC SSP Driver Question
Date: Mon, 10 Jan 2011 11:11:00 +0000
Message-ID: <20110110111100.GA6541@sirena.org.uk>
References: <2A84145621092446B6659B8A0F28E26F47005A34FF@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F42424443
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 12:11:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2A84145621092446B6659B8A0F28E26F47005A34FF@irsmsx501.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Bensaid, Selma" <selma.bensaid@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Le Gall,
	Louis" <louis.le.gall@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 10, 2011 at 10:47:33AM +0000, Bensaid, Selma wrote:

Please:
- Always CC maintainers on mails relating to the Linux kernel.
- Configure your mail client to wrap lines within paragraphs to
  something less than 80 columns.

> I'm working on ASoC driver for TI WL1273 (BT/FM) using the Bulverde
> SSP from IPGEAR peripheral. I have seen that a pxa_ssp driver already
> exists however I'm not if we have to use it as is it and adapt our SSP
> PCI driver to Interface with the pxa-ssp, or can we propose an
> "intel_ssp" ASoC driver?

You can do any of those things that make sense.  Please make sure that
you coordinate your work with the other work going on on Intel platforms
- there's some drivers been submitted recently for the MIDs, and there's
more work coming on those.
