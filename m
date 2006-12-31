From: Larry Finger <larry.finger@lwfinger.net>
Subject: Re: Regression in 2.6.19 and 2.6.20 for snd_hda_intel
Date: Sat, 30 Dec 2006 22:50:41 -0600
Message-ID: <459741A1.9020909@lwfinger.net>
References: <45971053.7040609@lwfinger.net> <45971F39.4060301@gentoo.org>	
	<45972EFD.3010103@lwfinger.net> <45973283.7060801@gentoo.org>
	<1167538094.9563.230.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mtiwmhc13.worldnet.att.net (mtiwmhc13.worldnet.att.net
	[204.127.131.117])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F11F92CF
	for <alsa-devel@alsa-project.org>; Sun, 31 Dec 2006 05:50:35 +0100 (MET)
In-Reply-To: <1167538094.9563.230.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: Daniel Drake <dsd@gentoo.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Stephen Hemminger <shemminger@osdl.org>
List-Id: alsa-devel@alsa-project.org

Tobin Davis wrote:
> Which alsa patch was this?  I'm not seeing anything in the hg logs for
> this.  Or is this something from the kernel side?

It seems to have come from suse. The full commit message is:

commit a7da6ce564a80952d9c0b210deca5a8cd3474a31
Author: Takashi Iwai <tiwai@suse.de>
Date:   Wed Sep 6 14:03:14 2006 +0200

    [ALSA] hda-codec - Add independent headphone volume control

    This patch addes the support of the independent 'Headphone' volume
    control to the generic codec parser.  Some codecs (e.g. Conexant)
    have separate connections to the headphone and the independent amp
    adjustment is needed.

    Signed-off-by: Takashi Iwai <tiwai@suse.de>
    Signed-off-by: Jaroslav Kysela <perex@suse.cz>

:100644 100644 dedfc5b... 97e9af1... M  sound/pci/hda/hda_generic.c

Larry



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
