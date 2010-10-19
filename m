From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: PATCH[1/1] Add I2S common driver for Intel
	MID	platform
Date: Tue, 19 Oct 2010 22:32:12 +0100
Message-ID: <20101019213212.GB29234@sirena.org.uk>
References: <2A84145621092446B6659B8A0F28E26F46FE77084A@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C426524490
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 23:32:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2A84145621092446B6659B8A0F28E26F46FE77084A@irsmsx501.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Le Gall, Louis" <louis.le.gall@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 18, 2010 at 12:39:56PM +0100, Le Gall, Louis wrote:

[Please fix your mail client to wrap within paragraphs - see
Documentation/email-clients.txt for help with common clients.]

>         As this is used to transfer speech frames from/to cellular modem that have specific timing constraints (and modem also uses the I2S path to send some side-info), the Alsa SoC interface cannot be used.

What makes you say this?  You have provided no detail on what problems
you believe exist and since ASoC is a *very* thin wrapper around the
core ALSA for DMA stuff it is very surprising that you would see any
issues here that don't also affect plain ALSA.  If there are any issues
then it would seem better to resolve these within the current framework
rather than completely discarding the entire existing infrastructure.

Also, how does this stuff relate to the other Moorestown SST drivers
which Alan Cox posted recently (after some previous postings by the
original authors)?

> +enum mrst_ssp_mode {
> +       SSP_IN_NORMAL_MODE = 0x0,
> +       SSP_IN_NETWORK_MODE
> +};

A lot of this stuff looks suspicously like the SSP ports in Marvell CPUs
(which were obviously Intel originally).
