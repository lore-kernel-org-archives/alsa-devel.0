From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: [RFC] alsa-kernel, make control.c suspend aware
Date: Wed, 8 Mar 2006 22:19:47 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0603082215380.13491@denise.shiny.it>
References: <20060302001859.58bd93af.pochini@shiny.it> <s5hmzg9865c.wl%tiwai@suse.de>
 <20060302230720.669b348f.pochini@shiny.it> <s5hd5h3o213.wl%tiwai@suse.de>
 <20060307230957.63c5bd35.pochini@shiny.it> <s5hveupqfy5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hveupqfy5.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Wed, 8 Mar 2006, Takashi Iwai wrote:

> > Ok, this patch changes all three snd_ctl_elem_user_*(). It seems to work
> > fine here. It also patches alsa-kernel/core/control_compat.c, but that part
> > has been compile-tested only. The last part fixes ioctl32/ioctl32_new.c and
> > it is completely untested (how can I test it on ppc32 ?).
>
> Thanks, the patch looks fine to me.
> Could you give a changelog and a signed-off-by?


This patch prevents user-space apps from accessing the hardware via
control interface while the soundcard is suspended.

Signed-off-by: Giuliano Pochini <pochini@shiny.it>



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
