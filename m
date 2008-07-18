From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] PalmTX aSoC sound support
Date: Fri, 18 Jul 2008 16:23:11 +0100
Message-ID: <20080718152311.GC25829@flint.arm.linux.org.uk>
References: <200807042126.29154.marek.vasut@gmail.com>
	<20080714150757.GE25448@sirena.org.uk>
	<s5hd4le13j2.wl%tiwai@suse.de>
	<200807162210.09908.marek.vasut@gmail.com>
	<s5habgg3jwo.wl%tiwai@suse.de>
	<20080718144920.GB25829@flint.arm.linux.org.uk>
	<s5h63r3i5tm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id CD0F424516
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 17:23:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h63r3i5tm.wl%tiwai@suse.de>
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
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 18, 2008 at 05:13:09PM +0200, Takashi Iwai wrote:
> At Fri, 18 Jul 2008 15:49:20 +0100,
> Russell King - ARM Linux wrote:
> > The reason for this is simple - if I push a new tree out, the nice diff
> > versions for non-git users of my tree will vanish, despite there being
> > changes still in there, and I don't want a flood of "where's my changes
> > gone?  they aren't in Linus' tree and they aren't in the diffs."
> > questions.
> 
> Well, changes over several areas are sometimes painful.

It doesn't have to be - in this particular instance is down to patch
5088/3, which introduced a new #include into pcm027.c, where the file
to be included is in the SPI tree.

In hind sight, that change should've been separated into two patches:
1. create the new API and change existing users over
2. add new pcm027 support (reliant on SPI tree)

This would've meant that things could have been arranged so that the
_only_ outstanding patch was (2) rather than the existing situation
where quite a lot of other peoples changes are currently stuck
(because they inadvertently and indirectly depend on (1)).

That's something to watch in the future...
