From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout,
 switching to single_cmd mode...
Date: Sat, 30 Sep 2006 23:03:08 -0700
Message-ID: <451F5A1C.2060201@goop.org>
References: <451834D0.40304@goop.org> <s5hlko7szjy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.goop.org (gw.goop.org [64.81.55.164])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CADEA21A
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Oct 2006 08:03:13 +0200 (MEST)
In-Reply-To: <s5hlko7szjy.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> You must see difference with mm1 (suppose that mm1 already includes
> the latest ALSA patches).  When the CORB/RIRB interrupt gets broken,
> the driver first switches to poling mode, then single_cmd mode as
> fallback.
>   

I tried -mm2, and I'm seeing the same problem.

> Also, try disable_msi=1 option for mm1.  MSI seems broken on some
> systems.
>   

This made no difference.

    J

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
