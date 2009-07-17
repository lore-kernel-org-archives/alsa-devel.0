From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Fri, 17 Jul 2009 11:18:04 +0100
Message-ID: <20090717101804.GD3439@rakim.wolfsonmicro.main>
References: <1246604775-12960-1-git-send-email-vinod.koul@intel.com>
	<20090704105743.GD10490@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5BBC230C@bgsmsx501.gar.corp.intel.com>
	<20090707114227.GD14393@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5BC0AF65@bgsmsx501.gar.corp.intel.com>
	<20090708094619.GA7420@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F2A3EBB@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C8371038C6
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jul 2009 12:18:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE5F2A3EBB@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 17, 2009 at 12:31:25PM +0530, Harsha, Priya wrote:

> I was looking into creating jack sense device. I see that I can create
> jack sense for headphones/headset/mic etc,. but if I want to send events
> like long press and short press of headset keys, can I use this same
> framework in someway? Is there any way to event these kinds of actions
> to user space through ALSA?

The intention was that buttons would be reported as normal buttons,
probably BTN_MISC.  Nobody has merged a driver with short detection yet
so it's not been added to the jack API yet but that's a fairly trivial
mapping.

Within the input API buttons just have pressed and released states so as
unless there's something I'm not aware of you'll need to manually create
different press lengths with a timer.
