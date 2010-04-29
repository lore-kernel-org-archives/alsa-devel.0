From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Thu, 29 Apr 2010 10:50:14 +1000
Message-ID: <1272502214.24542.133.camel@pasglop>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa0.perex.cz (Postfix) with ESMTP id E85D8103844
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 02:50:19 +0200 (CEST)
In-Reply-To: <j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur.tabi@gmail.com>
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-04-28 at 15:35 -0500, Timur Tabi wrote:
> Second, how about this binding for the virtual sound node?  It would
> be a root-level node.
> 
>         sound-devices {
>                 sound0 {
>                         ssi = &ssi0;
>                         playback-dma = &dma00;
>                         capture-dma = &dma01;
>                         codec = &cs4270;
>                 }
>         }; 

Make sure you also have a "compatible" property to uniquely identify the
design. You could use the toplevel board one but I'd rather keep a
separate one here. I've seen case where the exact same base board may
have different sound components (because they are dautherboards for
example, but there's a few other cases). 

Cheers,
Ben.
