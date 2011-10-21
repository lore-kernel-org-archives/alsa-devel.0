From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC:Add support for cs42l73 codec
Date: Fri, 21 Oct 2011 17:00:56 +0100
Message-ID: <20111021160055.GH4080@opensource.wolfsonmicro.com>
References: <1319118870.9355.4.camel@vkoul-udesk3>
	<EBA4E46B-C386-4800-829D-73CE475FB965@cirrus.com>
	<20111020142007.GE3524@opensource.wolfsonmicro.com>
	<8476EFD5-1EAC-443E-AB5C-6E27FB6C7DD7@cirrus.com>
	<4EA06916.6090601@nucleusys.com>
	<20111020200022.GC17384@opensource.wolfsonmicro.com>
	<4484A16E-1077-456B-8555-F37978604EB1@cirrus.com>
	<20111020212844.GA22709@opensource.wolfsonmicro.com>
	<01906467-5CD2-40C8-8C91-78971E11FB14@cirrus.com>
	<alpine.DEB.2.02.1110210822450.13824@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00C82103813
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 18:00:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1110210822450.13824@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "<ramesh.babu@intel.com> Babu" <ramesh.babu@intel.com>, Georgi Vlaev <joe@nucleusys.com>, "jeeja.kp Kp" <jeeja.kp@intel.com>, "<lrg@ti.com>" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2011 at 08:23:44AM -0500, Brian Austin wrote:

> I get it now! This is going to add a lot of code as there are a lot of
> mixer controls. Using volume controls as DAPM I can create all
> routes in the codec.

I did also mean to say that if you do have the really coarse power
control it might be worth looking at using supply widgets to control
the actual registers and no power management (SND_SOC_NOPM) for the
widgets used for routing.
