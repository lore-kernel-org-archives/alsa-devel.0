From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: questions about asoc jack detection
Date: Wed, 20 Apr 2011 08:14:44 -0700
Message-ID: <1303312484.4464.70.camel@razman.gruetest.com>
References: <20110420065212.GC21880@qtel.sh.intel.com>
	<20110420093102.GA4097@opensource.wolfsonmicro.com>
	<20110420140615.GK9074@qtel.sh.intel.com>
	<20110420145358.GB25571@sirena.org.uk>
	<20110420150020.GA12389@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A5201038D6
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 17:13:46 +0200 (CEST)
In-Reply-To: <20110420150020.GA12389@qtel.sh.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-04-20 at 23:00 +0800, Lu Guanqun wrote:
> On Wed, Apr 20, 2011 at 10:53:58PM +0800, Mark Brown wrote:
> > On Wed, Apr 20, 2011 at 10:06:15PM +0800, Lu Guanqun wrote:
> > 
> > > Yes, it's related to policy. But I see some inconsistencies in handling
> > > this stuff. In this above example, you suggest we should play out of
> > > both outputs. However in HDA code, the common way when headphone is
> > > inserted is to mute the speaker and enable the headphone. Is there some
> > > differences between the HDA code and the ASoC code? Or this is just due
> > > to legacy code?
> > 
> > HDA code does this differently.  I'd argue that they've taken the wrong
> > implementation decision and that this should be a userspace issue but
> > the use cases for PCs are a bit more basic.
> 
> I agree with you that this kind of policy should be put into userspace
> instead of hardcoding it in kernel.
> 
> Good to hear the points from you. Thanks!
> 
IIRC, the HDA jack detection code is pretty much legacy.  It has been
around longer than udev and other prior userspace hw detection systems.

That That doesn't mean it can't change.

-- 
Tobin Davis 

The Angels want to wear my red shoes.
		-- E. Costello
