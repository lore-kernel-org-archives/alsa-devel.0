From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/19] ASoC: upd9976: Add Renesas uPD9976
 codec driver
Date: Thu, 5 May 2011 09:07:56 +0100
Message-ID: <20110505080755.GB11744@opensource.wolfsonmicro.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134458.32443.45825.stgit@localhost>
	<20110504144600.GA7366@opensource.wolfsonmicro.com>
	<20110504151250.GC1671@qtel.sh.intel.com>
	<1304565177.20953.31.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E17D10393D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 10:08:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304565177.20953.31.camel@vkoul-udesk3>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Lu, Guanqun" <guanqun.lu@intel.com>, "Wang,
	Xingchao" <xingchao.wang@intel.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 08:42:57AM +0530, Koul, Vinod wrote:
> On Wed, 2011-05-04 at 20:42 +0530, Lu, Guanqun wrote:

> > > dev_err() would be more preferable.

> any specific reasons for that?

It'll cause the logging to include the device name.
