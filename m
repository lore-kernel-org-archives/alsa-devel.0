From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
Date: Sun, 02 Oct 2011 22:53:24 +0200
Message-ID: <2726393.3Oc3SrGyN4@wuerfel>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
	<1317587284-2776-3-git-send-email-arnd@arndb.de>
	<20111002204106.GB5811@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F08F24158
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 22:54:22 +0200 (CEST)
In-Reply-To: <20111002204106.GB5811@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Dmitry Artamonow <mad_soft@inbox.ru>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sunday 02 October 2011 21:41:07 Mark Brown wrote:
> On Sun, Oct 02, 2011 at 10:28:00PM +0200, Arnd Bergmann wrote:
> > This driver only builds correctly on platforms that use
> > GPIOLIB. Disable it otherwise.
> 
> No, gpiolib is one implementation of the GPIO API but if platforms want
> to go and define their own that's currently OK (personally I think at
> this point we should just be converting all the stragglers over to
> gpiolib).  As things stand we shouldn't have dependencies on a
> particular implementation of the API.

Thanks for the explanation!

Is there any other symbol that I can test then?

I noticed that a lot of places use 'depends on GPIOLIB' or
'#ifdef CONFIG_GPIOLIB', are those usually wrong, too?

	Arnd
