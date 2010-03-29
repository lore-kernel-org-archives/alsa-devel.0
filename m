From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ad193x: move codec register/unregister to
 bus probe/remove
Date: Mon, 29 Mar 2010 21:03:57 +0100
Message-ID: <20100329200357.GA6018@rakim.wolfsonmicro.main>
References: <1269832560-6845-1-git-send-email-21cnbao@gmail.com>
	<1269870001.3750.73.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13AB1243DE
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 22:04:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1269870001.3750.73.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 29, 2010 at 02:40:01PM +0100, Liam Girdwood wrote:
> On Mon, 2010-03-29 at 11:16 +0800, Barry Song wrote:
> > The way i've factored out the bus probe and removal functions so
> > that there's no code in the individual I2C and SPI functions means
> > that the register() and unregister() functions could just be squashed
> > into the bus_probe() and bus_remove() functions.
> > 
> > Signed-off-by: Barry Song <21cnbao@gmail.com>

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Applied, thanks.
