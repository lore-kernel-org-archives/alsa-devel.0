From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout,
 switching to single_cmd mode...
Date: Wed, 04 Oct 2006 08:16:17 -0700
Message-ID: <4523D041.8000400@goop.org>
References: <451834D0.40304@goop.org>	<s5hlko7szjy.wl%tiwai@suse.de>	<451F5A1C.2060201@goop.org>
	<s5hk63gl9mp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mail.goop.org (gw.goop.org [64.81.55.164])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E657114E
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Oct 2006 17:16:11 +0200 (MEST)
In-Reply-To: <s5hk63gl9mp.wl%tiwai@suse.de>
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
> At least, you have to see a different kernel message after the
> patch...  Could you confirm it?
>   

No, it looks like the same message as ever:

    hda_intel: azx_get_response timeout, switching to polling mode...
    hda_intel: azx_get_response timeout, switching to single_cmd mode...


This is with -mm3.

    J

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
