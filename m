From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Wed, 8 Jul 2009 10:46:19 +0100
Message-ID: <20090708094619.GA7420@rakim.wolfsonmicro.main>
References: <1246604775-12960-1-git-send-email-vinod.koul@intel.com>
	<20090704105743.GD10490@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5BBC230C@bgsmsx501.gar.corp.intel.com>
	<20090707114227.GD14393@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5BC0AF65@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B19D524149
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 11:46:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE5BC0AF65@bgsmsx501.gar.corp.intel.com>
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

On Wed, Jul 08, 2009 at 11:14:07AM +0530, Harsha, Priya wrote:
> >-----Original Message-----
> >From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]

> >Yes, the jacks currently appear as input devices to applications.
> >Takashi was also considering adding some ALSA-specific ways of reading
> >the state to go alongside these.

> If I create a jack sense device, how would an application use it?
> Currently do we have any mechanism in ALSA to send events to user space
> when a jack is detected? If not, would it be ok if I stick to netlink

Yes, they see it as a normal input device under /dev/input.  The jack
input device will provide one or more switches and buttons depending on
what it can detect.

> events for now. We have a platform specific daemon that is being
> developed that listens on netlink events and that is why the driver
> sends them. 

Your daemon should be able to use /dev/input for this.  This will also
help if users run other applications on the system since the standard
API for jack sense will be there.
