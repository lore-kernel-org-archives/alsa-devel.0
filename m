From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC don't apply] ASoC: Add support for optional
 auxiliary dailess codecs
Date: Sun, 28 Nov 2010 11:50:04 +0000
Message-ID: <20101128115004.GB28950@opensource.wolfsonmicro.com>
References: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 80E9F2443F
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2010 12:49:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 25, 2010 at 05:47:38PM +0200, Jarkko Nikula wrote:

> I'm not entirely sure of reusing struct snd_soc_pcm_runtime but having some
> common struct on top of it for registering the sysfs nodes and passing to
> snd_soc_dapm_sys_add didn't sound clear either.
> Anyway suspend/resume is working with this version and doesn't need any other
> modifications to soc_suspend/soc_resume than traversing through the registered
> codecs instead of doing bunch of rtd->dailess etc hacks there.

So, the reason we're doing this is that the sysfs nodes for DAPM and
regular CODEC stuff are using the device node in the PCM runtime data to
look up the data structures they need to do things.  The CODEC probably
isn't an ideal place for the PCM runtime data anyway, it feels like a
card thing (as it spans multiple devices within the card except in the
most baroque designs).

Since we appear to be abusing sysfs here anyway (we've got an empty
release function) I think we should just look into fixing this properly,
probably by having a device directly on the CODEC and using that for the
CODEC-specific sysfs files.

That said, this shouldn't affect the external interfaces here - it
should only have any material impact on the core - so probably shouldn't
be a blocker for adding this feature.  Liam, does this analysis all
sound sane to you?
