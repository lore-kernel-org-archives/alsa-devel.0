From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ALSA scenario API
Date: Mon, 22 Oct 2007 23:11:47 +0100
Message-ID: <1193091107.7052.193.camel@localhost.localdomain>
References: <1192579933.12060.772.camel@localhost.localdomain>
	<s5hhcknzcs7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id C97DD2467C
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Oct 2007 00:11:49 +0200 (CEST)
In-Reply-To: <s5hhcknzcs7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Leijin Tang <Leijin.Tang@access-company.com>, ohm-devel <ohm-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-10-19 at 11:14 +0200, Takashi Iwai wrote:

> 
> About PCM: if we implement again this kind of things in the driver, we
> may have a virtual PCM stream for the default use and other fixed PCM
> streams.  They can be opened exclusively, and the default stream opens
> different H/W stream according to the current scenario.  (BTW, still a
> question remains: when the scenario switch happens on the fly during a
> PCM stream being used, what should be done?)
> 

This probably depends on the scenario change and probably wont matter
for most changes e.g. hifi playback then headphone insertion (same pcm)
or hifi playback then phone call (different PCM - stop hifi then start
voice). I suppose the PCM option was more for scenario audio type e.g.
all system sound use pcm:0.2, all voice use pcm:0.1, etc

> Or, simply alsa-lib checks the current scenario value and chooses the
> appropriate preset setup.  This would work well (at least for
> alsa-lib, not salsa-lib - such a complicated implementation is outside
> the scope of salsa-lib).  

This is what's working on the OpenZaurus atm. There is a daemon that
alsactl restores a scenario based upon events. i.e. there is an
asound.state for each anticipated use case (scenario). 

This works well for routing audio (and saving power) but cant tell apps
what scenarios are supported or the sink/source pcm.

> This user-space solution (for PCM) has
> another advantage that it's easier to handle PCM setups for multiple
> streams.  For example, suppose we use "scenario" for speaker setup.
> emu10k1 uses multiple PCM streams for 4.0/5.1 surrounds, and the
> driver-side implementation wouldn't work unless it reflects to
> alsa-lib setup.
> 

Imho, the quickest way in user space (without using alsa-lib or salsa)
for route, alias and pcm would probably be to extend alsactl (or make a
new lib based on alsactl). This would easily give the scenario route
changing (already mostly done) and would need simple enough code to add
options to get aliases and PCM's. 

Liam
