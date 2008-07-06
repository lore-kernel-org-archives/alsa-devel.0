From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Sun, 6 Jul 2008 13:56:48 -0400
Message-ID: <9e4733910807061056m7b0dbf1fr578cbfcda31586ea@mail.gmail.com>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235335.16923.43253.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id E019224529
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Jul 2008 19:57:10 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so868745ywk.2
	for <alsa-devel@alsa-project.org>; Sun, 06 Jul 2008 10:56:48 -0700 (PDT)
In-Reply-To: <20080701235335.16923.43253.stgit@trillian.secretlab.ca>
Content-Disposition: inline
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
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, timur@freescale.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 7/1/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
>  This is an I2S bus driver for the MPC5200 PSC device.  It is probably
>  will not be merged as-is because it uses v1 of the ASoC API, but I want
>  to get it out there for comments.
>  ---

The driver is assuming a capture stream exists. My codec is output only.

I'm using external clocking, but the driver should support using the
mpc5200 for clocking. That's a little complicated since you have to
compute the divisors. For example the Phytec pcm030 board has a
33.3333Mhz xtal and runs at 400Mhz.

In order to reduce options, can the psc-i2s driver always try to use
mpc5200 clocking, then let the codec or fabric driver override it?

-- 
Jon Smirl
jonsmirl@gmail.com
