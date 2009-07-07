From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Tue, 7 Jul 2009 12:42:28 +0100
Message-ID: <20090707114227.GD14393@rakim.wolfsonmicro.main>
References: <1246604775-12960-1-git-send-email-vinod.koul@intel.com>
	<20090704105743.GD10490@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5BBC230C@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1CD8F24150
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 13:42:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE5BBC230C@bgsmsx501.gar.corp.intel.com>
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

On Tue, Jul 07, 2009 at 12:05:45PM +0530, Harsha, Priya wrote:
> >-----Original Message-----
> >From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]

> >ALSA core has an interface for representing jacks to user space which
> >should be used here - see include/sound/jack.h.

> Thanks for the note. I shall look into it further. Can you suggest any
> example ALSA driver that uses this functionality so that I can have a

A lot of the HDA drivers use it and there's a wrapper for ASoC too -
it's fairly likely that if you're running a current kernel your desktop
PC will support this interface already.  Searching the kernel source for
snd_jack_new() should turn up everything there is at the minute.

> reference. Also quick question around this, can I use this jack.h to
> event the user space?

Yes, the jacks currently appear as input devices to applications.
Takashi was also considering adding some ALSA-specific ways of reading
the state to go alongside these.
