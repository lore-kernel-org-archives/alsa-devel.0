From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976
	codec driver
Date: Wed, 4 May 2011 17:15:46 +0100
Message-ID: <20110504161545.GD10912@opensource.wolfsonmicro.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
	<20110504143451.GA10912@opensource.wolfsonmicro.com>
	<s5hbozio66r.wl%tiwai@suse.de>
	<20110504151827.GD1671@qtel.sh.intel.com>
	<s5h62pqo4qu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D0D54103939
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 18:16:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h62pqo4qu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2011 at 05:38:33PM +0200, Takashi Iwai wrote:

> If it's the only output, any of them can be a "Master" volume.
> But if there are other outputs, it shouldn't be named as "Master" at
> all. 

If you've got a choice you probably want to pick an analogue control
over a digital one as this will give better performance.

> Master volume is like Highlander(*), there can be only one :)

> (*) doesn't mean guys in Edinburgh

Definitely not, Edinburgh is in the lowlands not the highlands!
