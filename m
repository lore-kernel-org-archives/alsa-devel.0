From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: Make wm1250-ev1 depends on
	GPIOLIB
Date: Tue, 27 Sep 2011 10:48:35 +0100
Message-ID: <20110927094835.GA2910@opensource.wolfsonmicro.com>
References: <1317091799.315.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 077CA24419
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 11:48:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317091799.315.6.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 27, 2011 at 10:49:59AM +0800, Axel Lin wrote:
> I got below build error if GPIO support is disabled.
> Make wm1250-ev1 depends on GPIOLIB to fix below build error.

If platforms aren't using the standard gpiolib infrastructure they
should keep their GPIO API implementation up to date with the current
state of the art.
