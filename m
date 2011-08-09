From: Johannes Stezenbach <js@sig21.net>
Subject: Re: Template Based Coefficients Setting for Filters
Date: Tue, 9 Aug 2011 23:28:24 +0200
Message-ID: <20110809212824.GA4241@sig21.net>
References: <1312893236.8316.51.camel@matrix>
	<20110809151630.GB3429@sirena.org.uk> <4E416C1F.6030301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id C2C1424335
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 23:28:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E416C1F.6030301@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ashish Chavan <ashish.chavan@kpitcummins.com>
List-Id: alsa-devel@alsa-project.org

(add back Cc:s)

Hi Steve,

On Tue, Aug 09, 2011 at 10:19:27AM -0700, Steve Calfee wrote:
> On 08/09/11 08:16, Mark Brown wrote:
> > On Tue, Aug 09, 2011 at 06:03:56PM +0530, Ashish Chavan wrote:
> > 
> >>    I am working on updating ASoC codec driver for Dialog's DA7210 codec
> >> (sound/soc/codec/da7210.c). This update would be a major functionality
> >> update in nature. Currently, I am implementing support for GP (general
> >> purpose) filters of this codec and need some opinions/comments.
> > 
> > Use _BYTES controls for this.  There are no existing users in ASoC,
> > though there should be shortly and there are generic ALSA examples.
> 
> Hi Mark,
> 
> Could you expand on this. Neither google or lxr found anything about
> _BYTES controls. Where is it defined in the source?

I've written a driver for ST32x, it will be in 3.1.  My patch
to use _BYTES controls were posted here not long ago, see
http://thread.gmane.org/gmane.linux.alsa.devel/87063


HTH
Johannes
