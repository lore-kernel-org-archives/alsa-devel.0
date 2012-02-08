From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: FW: [PATCH v3] ASoC: Add support for TI LM49453
 Audio codec
Date: Wed, 08 Feb 2012 20:01:43 +0530
Message-ID: <1328711503.21099.13.camel@vkoul-udesk3>
References: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
	<4F323BF5.4010309@ti.com> <1328692723.3955.4.camel@odin>
	<1328693854.21099.5.camel@vkoul-udesk3> <1328694877.3955.9.camel@odin>
	<1328697415.21099.8.camel@vkoul-udesk3> <1328698650.3955.13.camel@odin>
	<1328699820.21099.12.camel@vkoul-udesk3>
	<20120208112156.GC3120@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id F036D103E73
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 15:29:27 +0100 (CET)
In-Reply-To: <20120208112156.GC3120@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, M R Swami Reddy <MR.Swami.Reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-08 at 11:21 +0000, Mark Brown wrote:
> On Wed, Feb 08, 2012 at 04:47:00PM +0530, Vinod Koul wrote:
> 
> > Possibly a .set_machine_clock_input callback which can be called from
> > codec driver in .set_bias_level callback?
> 
> The machine driver has set_bias_level() callbacks of its own.
Thanks, _exactly_ what I needed :)

-- 
~Vinod
