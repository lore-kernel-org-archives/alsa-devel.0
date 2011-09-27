From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Staticise sst_platform_dai
Date: Tue, 27 Sep 2011 11:22:00 +0100
Message-ID: <20110927102159.GD2910@opensource.wolfsonmicro.com>
References: <1317091087.315.1.camel@phoenix> <1317091130.315.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A2F7F10396B
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 12:22:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317091130.315.2.camel@phoenix>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 27, 2011 at 10:38:50AM +0800, Axel Lin wrote:
> It is not used outside this driver so no need to make the symbol global.
> 

Applied, thanks.
