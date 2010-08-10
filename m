From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: i.MX SDMA support
Date: Tue, 10 Aug 2010 15:07:43 +0100
Message-ID: <1281449263.3059.53.camel@odin>
References: <20100809091157.GC20065@pengutronix.de>
	<1281350823.3035.54.camel@odin> <20100809121956.GA27749@pengutronix.de>
	<64008892-3D75-4309-A623-CCE9B335F77F@opensource.wolfsonmicro.com>
	<20100810131527.GK27749@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BC13B2447F
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 16:07:47 +0200 (CEST)
Received: by wyb42 with SMTP id 42so10973677wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 07:07:47 -0700 (PDT)
In-Reply-To: <20100810131527.GK27749@pengutronix.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-08-10 at 15:15 +0200, Sascha Hauer wrote:

> I just looked at the i.MX part in the multi-component update and this
> is currently far from being in a working state, so there's still some
> work to do before thinking about possible conflicts...

Ok, I don't think it's that far off. Everything builds for i.MX and all
components should register. The part I can't test is the component
probe() and playback/capture.

Have you seen an oops ?

Thanks

Liam 
