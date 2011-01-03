From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC sst: Add mid machine driver
Date: Mon, 3 Jan 2011 16:14:58 +0000
Message-ID: <20110103161458.GA7377@opensource.wolfsonmicro.com>
References: <1293707593-8372-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E6C852412E
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 17:14:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1293707593-8372-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, alan@linux.intel.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 30, 2010 at 04:43:13PM +0530, Vinod Koul wrote:

> +int create_device(struct platform_device **device, char *name,
> +				void *drv_data)
> +{
> +	int ret_val = 0;

I didn't notice this when I read the driver originally as the file
appears after the actual machine driver: this is is a namespace
violation if nothing else and is not appropraite for doing in a platform
specific subsystem like this; if this is required it should be done in
the device core (and be platform device specific), though I rather
suspect the existing helper functions do the job just fine.
