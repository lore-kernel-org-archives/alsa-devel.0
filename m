From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: sst_platform: initialize
	module_name properly
Date: Wed, 6 Apr 2011 23:16:01 +0900
Message-ID: <20110406141559.GF2810@opensource.wolfsonmicro.com>
References: <20110406022026.28406.98577.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D721210383C
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 16:15:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110406022026.28406.98577.stgit@localhost>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Koul Vinod <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 06, 2011 at 10:20:26AM +0800, Lu Guanqun wrote:
> module_name will be checked in register_sst_card.
> It will fail to register sst card if it's not initialized.
> 
> Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>

Applied all, thanks.
