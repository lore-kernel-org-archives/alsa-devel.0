From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: DaVinci: Update suspend/resume
	support for	McASP driver
Date: Fri, 4 Dec 2009 10:55:21 +0000
Message-ID: <20091204105521.GA28498@opensource.wolfsonmicro.com>
References: <1259846816-24730-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FE841037F2
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 11:55:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1259846816-24730-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 03, 2009 at 06:56:56PM +0530, Chaithrika U S wrote:
> Add clock enable and disable calls to resume and suspend respectively.
> Also add a member to the audio device data structure which tracks the clock
> status.
> 
> Tested on DA850/OMAP-L138 EVM. For the purpose of testing, the patches[1] which
> add suspend-to-RAM support to DA850/OMAP-L138 SoC were applied.
> 
> [1] http://linux.davincidsp.com/pipermail/davinci-linux-open-source/
> 2009-November/016958.html
> 
> Signed-off-by: Chaithrika U S <chaithrika@ti.com>

Applied, thanks.
