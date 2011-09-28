From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Signaling user-space through kcontrol
Date: Wed, 28 Sep 2011 11:48:55 +0100
Message-ID: <20110928104855.GA28309@sirena.org.uk>
References: <4E82BB4C.1030801@codeaurora.org>
	<1317190544.1573.1646.camel@vkoul-udesk3>
	<4E82C307.30407@codeaurora.org>
	<1317193412.1573.1647.camel@vkoul-udesk3>
	<4E82CC33.7060608@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0802E24133
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 12:49:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E82CC33.7060608@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 28, 2011 at 12:26:43AM -0700, Patrick Lai wrote:
> On 9/28/2011 12:03 AM, Vinod Koul wrote:

> >> Main one is detection of short circuiting headphone For this case,
> >> there is no need for extra payload. In case of there is need to pass
> >> back some payload, I presume user-space application can simply call the
> >> get function upon receiving notification.

> > And what would userspace do with that information? Apart from logging
> > this, is there anything useful we can do with such info

> Well, it's up to user-space application to decide. I suppose
> application would not allow audio route to headphone/headset at this
> point.

Something like that specific example should probably be reported via the
snd_jack accessory detection infrastructure which can then offer a
consistent interface between all sound cards with minimal work on the
part of the individual driver.  There will doubtless be other examples
though.
