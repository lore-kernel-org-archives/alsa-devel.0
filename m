From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Sun, 29 Nov 2009 01:44:33 +0100
Message-ID: <20091129004433.GZ14091@buzzloop.caiaq.de>
References: <20091125153804.GA12750@rakim.wolfsonmicro.main>
	<20091126154807.GI14091@buzzloop.caiaq.de>
	<20091126160351.GB10674@rakim.wolfsonmicro.main>
	<20091126174245.GJ14091@buzzloop.caiaq.de>
	<20091127112550.GA29821@rakim.wolfsonmicro.main>
	<20091127124139.GR14091@buzzloop.caiaq.de>
	<20091127133225.GB17711@rakim.wolfsonmicro.main>
	<4B1186B8.6070606@freescale.com>
	<C78B2A7F-3D02-406C-A87B-8C3231456726@opensource.wolfsonmicro.com>
	<4B11A19D.4070301@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E191C103803
	for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2009 01:44:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B11A19D.4070301@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 28, 2009 at 04:18:05PM -0600, Timur Tabi wrote:
> Mark Brown wrote:
> >The regulator header file handles that -it provides stub versions of the
> >core consumer API calls to save all the drivers having to have
> >conditional code in them.
> 
> Ok, that works for me.
> 
> However, when I tried to apply the patch to the for-2.6.33 branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git,
> it fails:
> 
> $ patch -p 1 <
> "/home/b04825/.mozilla/seamonkey/fl00b35q.default/Mail/Local
> Folders/patches"
> patching file sound/soc/codecs/cs4270.c
> Hunk #5 FAILED at 651.
> Hunk #6 succeeded at 673 (offset -7 lines).
> Hunk #8 succeeded at 779 (offset -7 lines).
> Hunk #9 succeeded at 895 (offset -16 lines).
> 1 out of 9 hunks FAILED -- saving rejects to file sound/soc/codecs/cs4270.c.rej
> 
> I'm on vacation until the end of the year, so I can't test this
> driver thoroughly, but I'd like to make sure it at least compiles
> and boots before I ack it.

It does compile and does boot, we're testing this already on mayn
devices and it works fine. However, there have been updates to that
driver due to changes in the suspend/resume paths.

Mark, can you resolve those conflicts easily or do you want me to do it?

Thanks,
Daniel
