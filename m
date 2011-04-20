From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: questions about asoc jack detection
Date: Wed, 20 Apr 2011 23:00:20 +0800
Message-ID: <20110420150020.GA12389@qtel.sh.intel.com>
References: <20110420065212.GC21880@qtel.sh.intel.com>
	<20110420093102.GA4097@opensource.wolfsonmicro.com>
	<20110420140615.GK9074@qtel.sh.intel.com>
	<20110420145358.GB25571@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B2EB103906
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 17:01:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110420145358.GB25571@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 20, 2011 at 10:53:58PM +0800, Mark Brown wrote:
> On Wed, Apr 20, 2011 at 10:06:15PM +0800, Lu Guanqun wrote:
> 
> > Yes, it's related to policy. But I see some inconsistencies in handling
> > this stuff. In this above example, you suggest we should play out of
> > both outputs. However in HDA code, the common way when headphone is
> > inserted is to mute the speaker and enable the headphone. Is there some
> > differences between the HDA code and the ASoC code? Or this is just due
> > to legacy code?
> 
> HDA code does this differently.  I'd argue that they've taken the wrong
> implementation decision and that this should be a userspace issue but
> the use cases for PCs are a bit more basic.

I agree with you that this kind of policy should be put into userspace
instead of hardcoding it in kernel.

Good to hear the points from you. Thanks!

-- 
guanqun
