From: Sergey Lapin <slapin@ossfans.org>
Subject: Re: McBSP troubles
Date: Sat, 21 Nov 2009 21:17:13 +0300
Message-ID: <20091121181712.GC23851@build.ossfans.org>
References: <48239d390911210754q5ef62784p4168a4e2a7324db0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from build.ossfans.org (build.ossfans.org [67.223.233.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 05636103814
	for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2009 19:17:20 +0100 (CET)
Received: from build.ossfans.org ([127.0.0.1])
	by build.ossfans.org (8.14.3/8.14.3/Debian-5) with ESMTP id
	nALIHJKT024650
	for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2009 21:17:19 +0300
Received: (from slapin@localhost)
	by build.ossfans.org (8.14.3/8.14.3/Submit) id nALIHDHP024649
	for alsa-devel@alsa-project.org; Sat, 21 Nov 2009 21:17:13 +0300
Content-Disposition: inline
In-Reply-To: <48239d390911210754q5ef62784p4168a4e2a7324db0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 21, 2009 at 06:54:41PM +0300, Sergey Lapin wrote:
> Hi, all!
> 
> I have problems making any sound with current linux-omap master.
> ASoC repository did not change anything either. I use slightly
> modified (removed all GPIOs/jacks and different clock names because we
> use OMAP3 instead of OMAP2 n810 uses)
> sound/soc/omap/n810.c, with McBSP2. Codec is tlv320aic32 and
> it is well supplied with 13 MHz clock, so should work happily.
> Old 2.6.28-omap1 kernel + modifications works well with this,
> but it lacks some fundamental features recently added to mainline and
> linux-omap kernels, so we considered upgrading. Almost all stuff
> on custom board works, except for sound, which I fight for several weeks
> already, so I look for any help with this. I use OMAP3525 SoC.

More experiments show that codec seems to be responsible.
After some tampering with reset GPIO, it finally works.

Sorry for trouble,

S.
