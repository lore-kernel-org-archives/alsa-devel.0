From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Signaling user-space through kcontrol
Date: Wed, 28 Sep 2011 18:17:26 +0100
Message-ID: <20110928171726.GN3279@opensource.wolfsonmicro.com>
References: <4E82BB4C.1030801@codeaurora.org>
	<1317190544.1573.1646.camel@vkoul-udesk3>
	<4E82C307.30407@codeaurora.org>
	<1317193412.1573.1647.camel@vkoul-udesk3>
	<4E82CC33.7060608@codeaurora.org>
	<20110928104855.GA28309@sirena.org.uk>
	<4E834AF3.6020800@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAF56103A94
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 19:17:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E834AF3.6020800@codeaurora.org>
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

On Wed, Sep 28, 2011 at 09:27:31AM -0700, Patrick Lai wrote:

> Agree that should go through consistent interface but not exactly sure
> if going through input device interface is appropriate though. Isn't
> the same reasoning why it has been decided to create ALSA specific API
> for headset detection?

That's why I said use the jack API not the input API, if you're open
coding an input interface for jacks in ALSA you're doing something
wrong.  Just use the jack API and let it worry about how to tell the
rest of the system about what's going on - a driver shouldn't have to
worry about the details.
