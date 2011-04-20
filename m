From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: questions about asoc jack detection
Date: Wed, 20 Apr 2011 22:06:15 +0800
Message-ID: <20110420140615.GK9074@qtel.sh.intel.com>
References: <20110420065212.GC21880@qtel.sh.intel.com>
	<20110420093102.GA4097@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 444CC1038F6
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 16:07:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110420093102.GA4097@opensource.wolfsonmicro.com>
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

On Wed, Apr 20, 2011 at 05:31:02PM +0800, Mark Brown wrote:
> On Wed, Apr 20, 2011 at 02:52:12PM +0800, Lu Guanqun wrote:
> 
> > I have a question wrt jack detection, suppose now I have internal
> > speaker enabled and then headphone is inserted. According to the current
> > jack code in asoc, the Headphone pin wil be enabled, but it does nothing
> > to Internal Speaker. There is still sound coming out from speaker.
> 
> This is a policy question - depending on the use case the application
> may wish to still play sound out of the speaker.  One obvious example
> here is ringtones on phones.  If the user has been doing something like
> listen to music on headphones but then takes the headphones off they'll
> probably not hear anything that plays out of only the headphones so you
> should play ringtones out of both outputs in order to ensure that they
> are audible.

Yes, it's related to policy. But I see some inconsistencies in handling
this stuff. In this above example, you suggest we should play out of
both outputs. However in HDA code, the common way when headphone is
inserted is to mute the speaker and enable the headphone. Is there some
differences between the HDA code and the ASoC code? Or this is just due
to legacy code?

> 
> If you really want to you can add an invert to the hookup for a pin, but
> it's not recommended unless there's some physical reason both can't be
> enabled simultaneously.
> 
> > The possible solution is to let the application make the policy to
> > switch the output source to Headphone, because the jack event can be
> > observed. If we decide to let the userspace application make the policy,
> > then why do we bother to enable the jack pin at the first place?
> 
> If we can detect the physical presence of the output transducer it's not
> really a policy decision if it's worth enabling the audio path.

-- 
guanqun
