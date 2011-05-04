From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976
	codec driver
Date: Wed, 4 May 2011 17:13:54 +0100
Message-ID: <20110504161354.GC10912@opensource.wolfsonmicro.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
	<20110504143451.GA10912@opensource.wolfsonmicro.com>
	<s5hbozio66r.wl%tiwai@suse.de>
	<20110504151827.GD1671@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8BDB0103939
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 18:14:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504151827.GD1671@qtel.sh.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2011 at 11:18:27PM +0800, Lu Guanqun wrote:

> Oh, btw: There are another register that's related to volume control,
> it's before DAC (not added in this patchset yet, for simplicity, will
> add it later). so the connection looks something like this:

> [volume gain A] --> [DAC] --> [Mixer Volume] -> [Output Pins]

> Which volume control should be the master volume? I'm a bit unclear on
> this one.

Probably the mixer if that's the only path out.
