From: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Wed, 28 Apr 2010 15:35:32 -0500
Message-ID: <j2qed82fe3e1004281335h4076b050jc2894d4c4d6eac65@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f202.google.com (mail-pz0-f202.google.com
	[209.85.222.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AECB2457E
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 22:36:03 +0200 (CEST)
Received: by pzk40 with SMTP id 40so760912pzk.23
	for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2010 13:36:02 -0700 (PDT)
In-Reply-To: <1272362955.24542.24.camel@pasglop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 5:09 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> Keep in mind that it's perfectly kosher to create nodes for "virtual"
> devices. IE. We could imagine a node for the "sound subsystem" that
> doesn't actually correspond to any physical device but contain the
> necessary properties that binds everything together. You could even have
> multiple of these if you have separate set of sound HW that aren't
> directly dependant.

First, I want to officially retract this patch.  I've talked with
Grant, and we've come up with a different approach to this problem.

Second, how about this binding for the virtual sound node?  It would
be a root-level node.

	sound-devices {
		sound0 {
			ssi = &ssi0;
			playback-dma = &dma00;
			capture-dma = &dma01;
			codec = &cs4270;
		}
	};

-- 
Timur Tabi
Linux kernel developer at Freescale
