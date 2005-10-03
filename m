From: Dave Jones <davej@redhat.com>
Subject: Re: [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
Date: Sun, 2 Oct 2005 21:28:44 -0400
Message-ID: <20051003012844.GA10453__11605.2358680919$1128303696$gmane$org@redhat.com>
References: <200509131907.j8DJ7hMw024010@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E71CA1B9
	for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2005 03:28:52 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <200509131907.j8DJ7hMw024010@hera.kernel.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: alsa-devel@alsa-project.org, James@superbug.co.uk, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 13, 2005 at 12:07:43PM -0700, Linux Kernel wrote:
 > tree b885c7a937061624c7f7e34444122b96cced5c16
 > parent 1b44c28dc180f4d0ea109e1fe4339b3403c2d530
 > author James Courtier-Dutton <James@superbug.co.uk> Sat, 10 Sep 2005 10:24:10 +0200
 > committer Jaroslav Kysela <perex@suse.cz> Mon, 12 Sep 2005 10:48:32 +0200
 > 
 > [ALSA] snd-emu10k1: ALSA bug#1297: Fix a error recognising the SB Live Platinum.
 > 
 > EMU10K1/EMU10K2 driver
 > The card does not have an AC97 chip.
 > .subsystem = 0x80611102
 > 
 > Signed-off-by: James Courtier-Dutton <James@superbug.co.uk>
 > 
 >  sound/pci/emu10k1/emu10k1_main.c |    5 ++---
 >  1 files changed, 2 insertions(+), 3 deletions(-)
 > 
 > diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
 > --- a/sound/pci/emu10k1/emu10k1_main.c
 > +++ b/sound/pci/emu10k1/emu10k1_main.c
 > @@ -754,12 +754,11 @@ static emu_chip_details_t emu_chip_detai
 >  	 .emu10k1_chip = 1,
 >  	 .ac97_chip = 1,
 >  	 .sblive51 = 1} ,
 > -	/* Tested by alsa bugtrack user "hus" 12th Sept 2005 */
 > +	/* Tested by alsa bugtrack user "hus" bug #1297 12th Aug 2005 */
 >  	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
 > -	 .driver = "EMU10K1", .name = "SBLive! Player 5.1 [SB0060]", 
 > +	 .driver = "EMU10K1", .name = "SBLive! Platinum 5.1 [SB0060]", 
 >  	 .id = "Live",
 >  	 .emu10k1_chip = 1,
 > -	 .ac97_chip = 1,
 >  	 .sblive51 = 1} ,
 >  	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80511102,
 >  	 .driver = "EMU10K1", .name = "SBLive! Value [CT4850]", 

That last line change reverts..

tree efc4e418c80bf61beb2e1cfd1b2db405b471111f
parent 9970dce56686d7b71310388025d8925d3d29e6ec
author Takashi Iwai <tiwai@suse.de> Fri, 26 Aug 2005 17:26:40 +0200
committer Jaroslav Kysela <perex@suse.cz> Tue, 30 Aug 2005 08:47:46 +0200

[ALSA] emu10k1 - Add missing ac97 support on SBLive! Player 5.1

EMU10K1/EMU10K2 driver
Added the missing ac97 support on SBLive! Player 5.1.

And makes peoples volume sliders disappear, which tends to upset folks.
See https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=169152
for reference.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.13/sound/pci/emu10k1/emu10k1_main.c~	2005-10-02 21:26:40.000000000 -0400
+++ linux-2.6.13/sound/pci/emu10k1/emu10k1_main.c	2005-10-02 21:26:57.000000000 -0400
@@ -759,6 +759,7 @@ static emu_chip_details_t emu_chip_detai
 	 .driver = "EMU10K1", .name = "SBLive! Platinum 5.1 [SB0060]", 
 	 .id = "Live",
 	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80511102,
 	 .driver = "EMU10K1", .name = "SBLive! Value [CT4850]", 



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
