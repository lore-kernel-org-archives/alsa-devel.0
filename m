From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: Add support for cs42l73 codec
Date: Sat, 01 Oct 2011 22:52:18 +0530
Message-ID: <1317489738.1573.1822.camel@vkoul-udesk3>
References: <1317400912-5789-1-git-send-email-brian.austin@cirrus.com>
	<1317404092.1573.1818.camel@vkoul-udesk3>
	<026E346D-E556-4B11-917F-A1A78A4A122D@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 70E2C24530
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Oct 2011 19:28:38 +0200 (CEST)
In-Reply-To: <026E346D-E556-4B11-917F-A1A78A4A122D@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<broonie@opensource.wolfsonmicro.com>" <broonie@opensource.wolfsonmicro.com>, "<heelrod@heelrod.ad.cirrus.com>" <heelrod@heelrod.ad.cirrus.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>, "<lrg@ti.com>" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-09-30 at 18:32 +0000, Austin, Brian wrote:
> >> +/* Thermal Overload Detect. Requires interrupt ... */
> >> +#define THMOVLD_150C        0
> >> +#define THMOVLD_132C        1
> >> +#define THMOVLD_115C        2
> >> +#define THMOVLD_098C        3
> >> +
> >> +
> >> +/* CS42L73_ASPC, CS42L73_XSPC, CS42L73_VSPC */
> >> +#define     xSP_3ST                 (1 << 7)
> > ??
> Tri-state Auxillary Serial Port Interface (XSP Port) 
Your formating is inconsistent here :)

-- 
~Vinod
