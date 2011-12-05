From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] asoc: sst_platform: fix the dsp driver
	interface
Date: Mon, 05 Dec 2011 18:59:34 +0530
Message-ID: <1323091774.30390.66.camel@vkoul-udesk3>
References: <1323084324-9420-1-git-send-email-vinod.koul@linux.intel.com>
	<20111205132825.GM11150@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id DDDF71039B9
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 14:31:17 +0100 (CET)
In-Reply-To: <20111205132825.GM11150@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-12-05 at 13:28 +0000, Mark Brown wrote:
> On Mon, Dec 05, 2011 at 04:55:24PM +0530, Vinod Koul wrote:
> > lower level drivers typically register with upper layers.
> > So fix by exporting symbols from sst_platform driver for dsp driver to
> > register to sst platform driver
> > 
> > Now this driver doesnt depend on sst driver, so remove the dependency
> > and the header files
> 
> The doesn't apply to 3.3 due to a conflict with the conversion to
> module_platform_driver - you could please respin against current -next?
Ah my bad. I had done sync sometime back and didn't pull as I was
thinking nothig else changed in this. Obvisly I missed the platform
driver patch.
I will send updated one...

-- 
~Vinod
