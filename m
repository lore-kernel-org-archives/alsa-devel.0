From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sst_platform: Fix lock acquring
Date: Mon, 11 Apr 2011 13:15:46 -0700
Message-ID: <20110411201545.GC29405@opensource.wolfsonmicro.com>
References: <20110408073848.30438.39586.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90C5D1038F4
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 22:15:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110408073848.30438.39586.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: Koul Vinod <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 08, 2011 at 03:38:48PM +0800, Lu Guanqun wrote:
> Fix the possible dead lock shown below:
> 
> spin_lock

Applied, thanks.
