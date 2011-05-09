From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: factor out intel_scu_ipc related
 read/write
Date: Mon, 9 May 2011 09:31:28 +0200
Message-ID: <20110509073127.GB21967@opensource.wolfsonmicro.com>
References: <20110507134318.4225.54478.stgit@localhost>
	<20110507134830.GB13216@qtel.sh.intel.com>
	<1304910863.32447.3.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6CBB1103809
	for <alsa-devel@alsa-project.org>;
	Mon,  9 May 2011 09:31:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304910863.32447.3.camel@vkoul-udesk3>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, "Lu,
	Guanqun" <guanqun.lu@intel.com>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 09, 2011 at 08:44:23AM +0530, Koul, Vinod wrote:

> Meanwhile, i am not sure if this is a good idea.
> We can try enabling cache but will it help? Have you tried that on mrst?

The I/O does not force use of a cache, unless you configure a cache size
nothing will be cached.

> The reason for my paranoia is the SCU API, in past it had issues when we
> do block writes it, something which syncing the cache can cause.
> + Alan for his comments...

The cache I/O won't make any difference here.  Unless you implement bulk
operations it's not going to magically work out how to do them - you'll
just see repeated single register operations the same as you see if you
implement this directly in your driver.  All that will happen is that
the code will be shared between all drivers using the SCU.
