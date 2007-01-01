From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Regression in 2.6.19 and 2.6.20 for snd_hda_intel
Date: Mon, 1 Jan 2007 09:32:12 -0800
Message-ID: <20070101093212.6859f053@freekitty>
References: <45971053.7040609@lwfinger.net> <45971F39.4060301@gentoo.org>
	<45972EFD.3010103@lwfinger.net> <45973283.7060801@gentoo.org>
	<1167538094.9563.230.camel@localhost>
	<459741A1.9020909@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.25])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 39F1815C
	for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2007 18:34:10 +0100 (MET)
In-Reply-To: <459741A1.9020909@lwfinger.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Larry Finger <larry.finger@lwfinger.net>
Cc: Daniel Drake <dsd@gentoo.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 30 Dec 2006 22:50:41 -0600
Larry Finger <larry.finger@lwfinger.net> wrote:

> Tobin Davis wrote:
> > Which alsa patch was this?  I'm not seeing anything in the hg logs for
> > this.  Or is this something from the kernel side?
> 
> It seems to have come from suse. The full commit message is:
> 
> commit a7da6ce564a80952d9c0b210deca5a8cd3474a31
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Wed Sep 6 14:03:14 2006 +0200
> 
>     [ALSA] hda-codec - Add independent headphone volume control
> 
>     This patch addes the support of the independent 'Headphone' volume
>     control to the generic codec parser.  Some codecs (e.g. Conexant)
>     have separate connections to the headphone and the independent amp
>     adjustment is needed.
> 
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>     Signed-off-by: Jaroslav Kysela <perex@suse.cz>
> 
> :100644 100644 dedfc5b... 97e9af1... M  sound/pci/hda/hda_generic.c
> 
> Larry
> 
> 

Just make sure you don't break the headphone jack on some systems.
The headphone jack on the Panasonic T5 didn't work until recent kernels
(probably this was the thing that made it work).

-- 
Stephen Hemminger <shemminger@osdl.org>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
