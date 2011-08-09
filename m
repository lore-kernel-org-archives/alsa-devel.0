From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Template Based Coefficients Setting for Filters
Date: Wed, 10 Aug 2011 08:33:58 +0900
Message-ID: <20110809233357.GA22756@opensource.wolfsonmicro.com>
References: <1312893236.8316.51.camel@matrix>
	<20110809151630.GB3429@sirena.org.uk> <4E416C1F.6030301@gmail.com>
	<20110809212824.GA4241@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5109524158
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 01:34:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110809212824.GA4241@sig21.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Stezenbach <js@sig21.net>
Cc: alsa-devel@alsa-project.org, Steve Calfee <stevecalfee@gmail.com>, Ashish Chavan <ashish.chavan@kpitcummins.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 09, 2011 at 11:28:24PM +0200, Johannes Stezenbach wrote:
> On Tue, Aug 09, 2011 at 10:19:27AM -0700, Steve Calfee wrote:

> > Could you expand on this. Neither google or lxr found anything about
> > _BYTES controls. Where is it defined in the source?

> I've written a driver for ST32x, it will be in 3.1.  My patch
> to use _BYTES controls were posted here not long ago, see
> http://thread.gmane.org/gmane.linux.alsa.devel/87063

$ grep _BYTES include/sound/*.h sound/core/*.c
