From: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Sat, 5 Jul 2008 11:28:44 +1000
Message-ID: <20080705012844.GB3032@yookeroo.seuss>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807020651u368763en9362653ed613b2d1@mail.gmail.com>
	<20080703162809.GH2284@secretlab.ca>
	<B7AF0D32-4A05-4DE1-88F5-06B28C9723EF@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	by alsa0.perex.cz (Postfix) with ESMTP id AC97A24343
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Jul 2008 04:20:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B7AF0D32-4A05-4DE1-88F5-06B28C9723EF@freescale.com>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 04, 2008 at 07:03:25AM -0400, Timur Tabi wrote:
>> 	i2s@2200 {		// PSC2
>> 		compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
>> 		cell-index = <1>;
>
> cell-index should be zero-based, not one-based.

Well...since cell-index is for indexing shared resources, the
cell-index values should be whatever the convention is for that shared
resource, which can be defined as whatever is convenient for that
resource.  I think that's been zero-based in every user of cell-index
so far, but there's no reason it *has* to be if a different
enumeration is convenient for the shared resource in question.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
