From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC sst: Add mid machine driver
Date: Tue, 4 Jan 2011 13:39:13 +0000
Message-ID: <20110104133913.GA24774@opensource.wolfsonmicro.com>
References: <1293707593-8372-1-git-send-email-vinod.koul@intel.com>
	<20110102134715.GE4935@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C10F2BEE@bgsmsx502.gar.corp.intel.com>
	<20110103154319.GC6783@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C10F2EC9@bgsmsx502.gar.corp.intel.com>
	<20110103162826.GA7370@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C10F2F06@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 31A23103800
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 14:40:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104C10F2F06@bgsmsx502.gar.corp.intel.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 03, 2011 at 11:04:11PM +0530, Koul, Vinod wrote:

> Thanks, I will add the soc-audio only and move the others to core.
> So now this machine driver will only add machine controls and dai link along with soc-audio device.
> Would that suffice

That sounds reasonable; I'd need to see the code to confirm.

> This is codec from TI and I will remove the msic name now.
> It will now be ti-sn95031.c
> Does this address your concern on this issue?

Normally Linux just uses the part name so that'd just be sn95031 - look
at the other CODEC drivers for example.  In general you should try to
make your code look as similar as possible to what other systems are
doing.
