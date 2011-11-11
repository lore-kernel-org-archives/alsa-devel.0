From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 1/1] ASoC: mxs-saif: remove function in
	platform_data
Date: Sat, 12 Nov 2011 07:19:56 +0800
Message-ID: <20111111231955.GB9471@S2100-06.ap.freescale.net>
References: <1321003740-10992-1-git-send-email-b29396@freescale.com>
	<20111111150422.GX16886@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) by alsa0.perex.cz (Postfix) with ESMTP id 33BAD24367
	for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2011 00:08:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111111150422.GX16886@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, kernel@pengutronix.de, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 11, 2011 at 04:04:22PM +0100, Sascha Hauer wrote:
> On Fri, Nov 11, 2011 at 05:29:00PM +0800, Dong Aisheng wrote:
> > Add master_mode and master_id in platfrom_data since it's board
> > specific and board knows it.
> > Then we can remove the function pointer in platfrom_data to make
> > the driver more devicetree friendly.
> 
> Looks ok. Marc,

You meant Mark?

> is it ok when I take this patch? The SoC specific stuff
> for this patch depends on it.
> 
I thought I will start collecting mxs patches after v3.2-rc1.
Do you plan to collect mxs patches for one more cycle?

-- 
Regards,
Shawn
