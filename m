From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: mid-x86 machine driver - add
 jack detect support
Date: Fri, 4 Feb 2011 14:26:18 +0000
Message-ID: <20110204142618.GD5393@opensource.wolfsonmicro.com>
References: <1296732361-24172-1-git-send-email-priya.harsha@intel.com>
	<20110203152048.GC2576@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE08C107FB35@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9ACB3103B25
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 15:26:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE08C107FB35@bgsmsx501.gar.corp.intel.com>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 04, 2011 at 09:24:24AM +0530, Harsha, Priya wrote:
> >> +#define IRQ_BASE 0xFFFF7FCD
> >> +#define IRQ_SIZE 1

> >This looks like it should be coming in via a platform device or
> >something?

> I can make it a part of platform data.

I'd expect it to be a resource rather than platform data.
