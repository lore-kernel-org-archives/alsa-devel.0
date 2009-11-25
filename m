From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Wed, 25 Nov 2009 16:46:29 +0100
Message-ID: <20091125154629.GO29442@buzzloop.caiaq.de>
References: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
	<20091125150139.GC636@rakim.wolfsonmicro.main>
	<20091125152052.GM29442@buzzloop.caiaq.de>
	<20091125153804.GA12750@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 161CF243C2
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 16:46:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091125153804.GA12750@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 25, 2009 at 03:38:04PM +0000, Mark Brown wrote:
> On Wed, Nov 25, 2009 at 04:20:52PM +0100, Daniel Mack wrote:
> 
> > Ok - which place would you suggest for it? Is there an ASoC callback I
> > can hook on to tell me when the whole codec isn't used anymore? I can
> > only see startup/shutdown, but I would need to my own snd_pc_substream
> > handling login in there. Other drivers do that in the probe/remove
> 
> set_bias_level().  If the device is idle then the bias will be held in
> STANDBY (or OFF in future).  If you are happy switching off the analogue
> supply separately to the others then turn that one on when in PREPARE or
> ON, and kill the others only in OFF.

Ok, will do and resend later. Thanks!

> > functions, but that won't suffice for my board as we want VA disabled
> > whenever possible.
> 
> Are the power savings really that great?  If the power saving really is
> that critical it seems like a low power focused part might be a more
> natural choice...

The VA suplpy domain not only powers the codec but a bunch of OPAMPs and
the like as well. And yes, for all these, the power saving is
significant.

Daniel
