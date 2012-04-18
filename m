From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH 3/4] Add Wolfson Microelectronics WM8776
 codec ALSA driver
Date: Wed, 18 Apr 2012 11:27:05 +0200
Message-ID: <4F8E88E9.4060007@ivitera.com>
References: <1334611118-10301-1-git-send-email-linux@rainbow-software.org>
	<20120417170431.GT6652@opensource.wolfsonmicro.com>
	<s5h3982p71g.wl%tiwai@suse.de>
	<201204172015.14582.linux@rainbow-software.org>
	<20120417182204.GV6652@opensource.wolfsonmicro.com>
	<s5hwr5enpau.wl%tiwai@suse.de>
	<20120417194341.GX6652@opensource.wolfsonmicro.com>
	<4F8DCF81.4080508@ivitera.com>
	<20120417212914.GZ6652@opensource.wolfsonmicro.com>
	<20120418090620.GA21844@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189]) by alsa0.perex.cz (Postfix) with ESMTP id BE1DB24490
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 11:27:32 +0200 (CEST)
In-Reply-To: <20120418090620.GA21844@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>
List-Id: alsa-devel@alsa-project.org

Dne 18.4.2012 11:06, Mark Brown napsal(a):
> On Tue, Apr 17, 2012 at 10:29:15PM +0100, Mark Brown wrote:
>> On Tue, Apr 17, 2012 at 10:16:01PM +0200, Pavel Hofman wrote:
> 
>>> Working hard on series of patches and being met with cold attitude
>>> as for not adhering to ASoC standards (quoting the alsa-project.org:
> 
>> It's really the fact that it's not using ASoC, it's the fact that patch
> 
> s/really/really not/
> 
>>> If you want these independent contributors to start using the kernel
>>> infrastructure common in the ASoC "tree", please tell them clearly on
> 
> BTW, this probably deserves picking up a bit more: there's really no
> distinction between commercial and non-commercial contributors, if
> anything I'd say that on average the hobbyist contributors tend to be
> working to a higher standard on average.

Mark, my whole point is most nonASoC alsa developers have no idea they
are supposed to use stuff in the asoc subdir for the drivers outside of
the asoc subtree. And I guess they mostly do not follow mailinglist
messages prefixed ASoC either.

If sound/asoc/codecs was in sound/codecs, they would certainly take a
look. But right now to them asoc really feels like a separate world.

I understand you would like to change that (or IOW - it would be
beneficial to whole alsa to change that), very good. That is why I am
talking about some guidelines for the non-asoc developers. I cannot
write them, I am one of those having lived in the old-ages dark so far :)

Thanks a lot,

Pavel.
