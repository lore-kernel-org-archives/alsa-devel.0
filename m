From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH] ASoC: Improve error reporting in Speyside
 WM8962 driver
Date: Fri, 1 Jul 2011 00:56:17 +0800
Message-ID: <20110630165617.GF26397@qtel.sh.intel.com>
References: <1309382331-30552-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id BC376103970
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 18:59:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309382331-30552-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 30, 2011 at 05:18:51AM +0800, Mark Brown wrote:
>  			if (ret < 0)
> -				pr_err("Failed to start FLL\n");
> +				pr_err("Failed to start FLL: %d\n");

missed 'ret' here? :)

-- 
guanqun
