From: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH 2/2] sis7019: add support for
	pre-2.6	kernels
Date: Wed, 28 Nov 2007 08:18:57 -0500
Message-ID: <1196255937.7017.57.camel@obelisk.thedillows.org>
References: <1196234352.7017.32.camel@obelisk.thedillows.org>
	<s5hfxyqiu6m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BF4E24B2F
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 14:19:02 +0100 (CET)
In-Reply-To: <s5hfxyqiu6m.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-11-28 at 10:41 +0100, Takashi Iwai wrote:
> At Wed, 28 Nov 2007 02:19:12 -0500,
> Dave Dillow wrote:
> > 
> > The sis7019 driver uses __ffs(), which is available in 2.6 kernels, but
> > not in most earlier ones. This patches the driver to use a local version
> > assembly version, as the hardware is SiS 55x only (i486/Pentium-ish).
> 
> Then it'd be better to add the dependency on CONFIG_X86_32 so that it
> won't be compiled on other architectures.

Doh! Of course... 

> Also, replace __ffs() only for 2.4 kernels, e.g.

I'm 50/50 on this -- it doesn't hurt to just use the patched in version,
even in 2.6. I'm not fond of #ifdefs in code, and I'd need to search for
when it became available.

Then again, it is a small patch and the research isn't hard, just a bit
time consuming.

Dave
