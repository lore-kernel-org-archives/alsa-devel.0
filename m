From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] asoc: sst_platform: fix the dsp driver
	interface
Date: Mon, 5 Dec 2011 14:02:27 +0000
Message-ID: <20111205140227.GP11150@opensource.wolfsonmicro.com>
References: <1323084324-9420-1-git-send-email-vinod.koul@linux.intel.com>
	<1323092621-27903-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42A5C1039EA
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 15:02:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323092621-27903-1-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 05, 2011 at 07:13:41PM +0530, Vinod Koul wrote:
> lower level drivers typically register with upper layers.
> So fix by exporting symbols from sst_platform driver for dsp driver to
> register to sst platform driver

Applied, thanks.
