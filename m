From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] Add SuperH FSI driver support for ALSA
Date: Wed, 19 Aug 2009 15:44:20 +0100
Message-ID: <20090819144420.GA3323@rakim.wolfsonmicro.main>
References: <uljlg59ls.wl%morimoto.kuninori@renesas.com>
	<aec7e5c30908190659n4b81272ek6e06f23f4ee71a15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1281910389D
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 16:44:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <aec7e5c30908190659n4b81272ek6e06f23f4ee71a15@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lethal@linux-sh.org, linux-sh@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 19, 2009 at 10:59:56PM +0900, Magnus Damm wrote:

> > +struct fsi_master *master;

> Is it really necessary to have "master" as a global variable? Maybe
> this global variable is there to work around some framework issue?

There's no ASoC reason for doing this.  Anything that needs to be shared
between different DAIs can always be shared via the DMA driver.

Looking at the driver I rather suspect it only supports one FSI at once
and the capture support is also incomplete.  I don't see much problem
merging the driver with these limitations, it's generally been much
easier to get people to fix problems with merged drivers than to get
people to contribute entirely new drivers.
