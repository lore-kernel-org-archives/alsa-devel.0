From: Olaf Hering <olaf@aepfle.de>
Subject: Re: control.c: BUG info->access == 0
Date: Fri, 22 Sep 2006 16:57:05 +0200
Message-ID: <20060922145705.GA28375@aepfle.de>
References: <20060921204804.GA20477@aepfle.de> <s5hk63wcjr3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 48D32223
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Sep 2006 16:57:07 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hk63wcjr3.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 22, Takashi Iwai wrote:

> At Thu, 21 Sep 2006 22:48:04 +0200,
> Olaf Hering wrote:
> > 
> > 
> > I get this on an unconfigured G5 (PowerMac11,2) during boot:
> > 
> > ALSA sound/core/control.c:660: BUG? (info->access == 0)
> > Call Trace:
> > [C00000007B0C3B60] [C00000000000F5E8] .show_stack+0x68/0x1b0 (unreliable)
> > [C00000007B0C3C00] [D00000000013AB9C] .snd_ctl_elem_info+0xd0/0x1d8 [snd]
> > [C00000007B0C3CB0] [D00000000013CCA0] .snd_ctl_ioctl_compat+0x2c8/0x638 [snd]
> > [C00000007B0C3D70] [C0000000001160F4] .compat_sys_ioctl+0x158/0x3b4
> > [C00000007B0C3E30] [C00000000000871C] syscall_exit+0x0/0x40
> 
> The patch below should fix it.
> 
> Let me know if it works, then I'll send it to stable@kernel.

It works.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
