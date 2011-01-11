From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sst_platform porting sst dsp driver
 interface as per latest in Greg's staging tree
Date: Tue, 11 Jan 2011 11:02:30 +0000
Message-ID: <20110111110230.GA12452@opensource.wolfsonmicro.com>
References: <1294737659-18185-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C4741039BE
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 12:04:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294737659-18185-1-git-send-email-priya.harsha@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 02:50:59PM +0530, Harsha, Priya wrote:
> From: Harsha Priya <priya.harsha@intel.com>
> 
> The interface between sst platform driver and intel sst dsp driver
> have been changed in Greg's staging tree - next branch
> 
> This patch adds the interface changes compatible with the new interface
> in Greg's staging tree

I'll apply this once I've merged up -rc1.  In future changes that affect
both trees should be applied as a single commit which covers both trees.
