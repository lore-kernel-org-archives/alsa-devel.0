From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: SOLVED = RE: Alsa & 2.6 kernel
Date: Thu, 25 Sep 2003 07:45:08 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGEEOFDEAB.mknecht@controlnet.com>
References: <s5hbrt9kz6w.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrt9kz6w.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> At Wed, 24 Sep 2003 14:24:29 -0700,
> Mark Knecht wrote:
> >
> > I see that in the Gentoo kernel tree (and maybe all 2.6 kernels)
> > linux/drivers/sound has moved to linux/sound.
>
> the OSS drivers are located now on linux/sound/oss.
> the other sound directories correspond to ALSA's alsa-kernel tree
> (except for alsa-kernel/include -> linux/include/sound, and
>  alsa-kernel/Documentation -> linux/Documentation/sound/alsa).
>
>
> Takashi
>

Takashi-san,
   Thank you very much for the response. It is helpful.

   Would I be correct that if I had a 2.6 level kernel and wanted to use the
newest Alsa from CVS, then I would:

1) Download CVS to my machine in it's own directory
2) Replace what is currently in linux/sound with the CVS source EXCEPT for
the oss directory which I would leave alone.
3) Build the kernel with Alsa sound support and no OSS support
4) Use Alsa to do OSS emulation like I do today in modules.conf

   In linux/sound there are a few other files - Kconfig, etc. If these are
not supplied by Alsa CVS, then I would leave them in linux/sound to perform
whatever function they perform today.

   Does this sound about right? I may try it out one of these days.

Thanks,
Mark




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
