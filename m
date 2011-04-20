From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: questions about asoc jack detection
Date: Wed, 20 Apr 2011 10:31:02 +0100
Message-ID: <20110420093102.GA4097@opensource.wolfsonmicro.com>
References: <20110420065212.GC21880@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0C6D724434
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 11:31:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110420065212.GC21880@qtel.sh.intel.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 20, 2011 at 02:52:12PM +0800, Lu Guanqun wrote:

> I have a question wrt jack detection, suppose now I have internal
> speaker enabled and then headphone is inserted. According to the current
> jack code in asoc, the Headphone pin wil be enabled, but it does nothing
> to Internal Speaker. There is still sound coming out from speaker.

This is a policy question - depending on the use case the application
may wish to still play sound out of the speaker.  One obvious example
here is ringtones on phones.  If the user has been doing something like
listen to music on headphones but then takes the headphones off they'll
probably not hear anything that plays out of only the headphones so you
should play ringtones out of both outputs in order to ensure that they
are audible.

If you really want to you can add an invert to the hookup for a pin, but
it's not recommended unless there's some physical reason both can't be
enabled simultaneously.

> The possible solution is to let the application make the policy to
> switch the output source to Headphone, because the jack event can be
> observed. If we decide to let the userspace application make the policy,
> then why do we bother to enable the jack pin at the first place?

If we can detect the physical presence of the output transducer it's not
really a policy decision if it's worth enabling the audio path.
