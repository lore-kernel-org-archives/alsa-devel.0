From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm8940: Fix mask for setting
	BCLKDIV
Date: Thu, 27 Oct 2011 09:17:00 +0200
Message-ID: <20111027071659.GB3053@opensource.wolfsonmicro.com>
References: <1319594021.2517.0.camel@phoenix> <1319594139.2517.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 687191038DD
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Oct 2011 09:17:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319594139.2517.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Chris Paulson-Ellis <chris@edesix.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 26, 2011 at 09:55:39AM +0800, Axel Lin wrote:
> According to the datasheet:
> BCLK is controlled by BIT[4:2] of WM8940_CLOCK(06h) register.

This doesn't apply against current code.
