From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Fri, 4 Jul 2008 08:41:17 -0600
Message-ID: <20080704144117.GA15814@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
	<9e4733910807020651u368763en9362653ed613b2d1@mail.gmail.com>
	<20080703162809.GH2284@secretlab.ca>
	<B7AF0D32-4A05-4DE1-88F5-06B28C9723EF@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A1F224A5F
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 16:41:38 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so529287ywk.2
	for <alsa-devel@alsa-project.org>; Fri, 04 Jul 2008 07:41:20 -0700 (PDT)
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
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 04, 2008 at 07:03:25AM -0400, Timur Tabi wrote:
>> 	i2s@2200 {		// PSC2
>> 		compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
>> 		cell-index = <1>;
>
> cell-index should be zero-based, not one-based.
>

Umm... this is for PSC #2... cell index is set to '1'.  It is zero
based.

g.
