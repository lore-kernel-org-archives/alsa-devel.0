From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: sst_platform: Fix lock acquring
Date: Mon, 11 Apr 2011 20:52:13 +0100
Message-ID: <1302551533.3449.56.camel@odin>
References: <20110408073848.30438.39586.stgit@localhost>
	<20110408074042.GS29324@qtel.sh.intel.com>
	<438BB0150E931F4B9CE701519A446301085184E6C2@bgsmsx502.gar.corp.intel.com>
	<20110409102206.GA29911@qtel.sh.intel.com>
	<20110409104147.GB29911@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D47B310384C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 21:52:19 +0200 (CEST)
Received: by wyg36 with SMTP id 36so5572806wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2011 12:52:19 -0700 (PDT)
In-Reply-To: <20110409104147.GB29911@qtel.sh.intel.com>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2011-04-09 at 18:41 +0800, Lu Guanqun wrote:
> I compile the kernel with lockdep enabled. without this patch, it will
> complain with the below message: 

Acked-by: Liam Girdwood <lrg@ti.com>
