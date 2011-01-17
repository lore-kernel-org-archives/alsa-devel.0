From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: soc core allow machine driver to
 register the card
Date: Mon, 17 Jan 2011 13:57:14 +0000
Message-ID: <20110117135714.GC21113@opensource.wolfsonmicro.com>
References: <1295013168-29748-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6EDA0103836
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 14:57:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295013168-29748-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, selma.bensaid@intel.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 14, 2011 at 07:22:48PM +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> The machine driver can't register the card directly and need to do this thru
> soc-audio device creation
> 
> This patch allows the register and unregister card to be directly called by
> machine drivers

Applied, thanks.
