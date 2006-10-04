From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout,
 switching to single_cmd mode...
Date: Wed, 04 Oct 2006 13:07:56 -0700
Message-ID: <4524149C.6090107@goop.org>
References: <451834D0.40304@goop.org>	<s5hlko7szjy.wl%tiwai@suse.de>	<451F5A1C.2060201@goop.org>	<s5hk63gl9mp.wl%tiwai@suse.de>	<4523D041.8000400@goop.org>
	<s5hpsd7j42j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.goop.org (gw.goop.org [64.81.55.164])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E8AFA1A7
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Oct 2006 22:08:16 +0200 (MEST)
In-Reply-To: <s5hpsd7j42j.wl%tiwai@suse.de>
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
> A counter of RIRB pending commands could overflow the size of RIRB 
> when a bunch of commands are sent but not synced.  This may lead to
> the azx_get_response error, theoretically.
>
> Could you apply the patch below and check what values are shown there?
>   
I'll try it, but I re-enabled the modem in the bios, and I no longer get 
this message and it appears to work (there seems to be a secondary 
problem that the volume hotkeys have stopped working, but I suspect 
that's more ACPI-related).

    J

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
