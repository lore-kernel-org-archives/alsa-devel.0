From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Fri, 4 Jul 2008 07:03:25 -0400
Message-ID: <B7AF0D32-4A05-4DE1-88F5-06B28C9723EF@freescale.com>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807020651u368763en9362653ed613b2d1@mail.gmail.com>
	<20080703162809.GH2284@secretlab.ca>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E0A31037FF
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 12:59:38 +0200 (CEST)
In-Reply-To: <20080703162809.GH2284@secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

> 	i2s@2200 {		// PSC2
> 		compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
> 		cell-index = <1>;

cell-index should be zero-based, not one-based.
