From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Re: linux-next: Tree for Feb 24 (sound/usb/6fire)
Date: Fri, 24 Feb 2012 21:34:22 +0100
Message-ID: <20120224213422.3693943c2dad148b35e26d21@zoho.com>
References: <20120224170548.a9a338d64712f06f1b39b7bd@canb.auug.org.au>
	<4F47DBD4.4090803@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 19546103C48
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 21:34:29 +0100 (CET)
In-Reply-To: <4F47DBD4.4090803@xenotime.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Torsten@alsa-project.org, Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Schenk <torsten.schenk@zoho.com>, linux-next@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 24 Feb 2012 10:49:56 -0800
Randy Dunlap <rdunlap@xenotime.net> wrote:

> On 02/23/2012 10:05 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20120223:
> 
> 
> on x86_64:
> 
> ERROR: "_snd_ctl_add_slave" [sound/usb/6fire/snd-usb-6fire.ko]
> undefined! ERROR:
> "snd_ctl_make_virtual_master" [sound/usb/6fire/snd-usb-6fire.ko]
> undefined!
> 
> 
> Full randconfig file is attached.
> 
> CONFIG_SND_VMASTER is not enabled.  Looks like this driver should
> either depend on or select SND_VMASTER.
> 

Sorry, I was unaware that this option needs to be selected.
Patch is attached below that selects SND_VMASTER.

Regards,
Torsten


Select missing SND_VMASTER option in Kconfig.

Signed-off-by: Torsten Schenk <torsten.schenk@zoho.com>

diff -Nur a/sound/usb/Kconfig b/sound/usb/Kconfig
--- a/sound/usb/Kconfig	2012-02-24 21:17:09.543884187 +0100
+++ b/sound/usb/Kconfig	2012-02-24 21:19:16.160372882 +0100
@@ -106,6 +106,7 @@
         select BITREVERSE
         select SND_RAWMIDI
         select SND_PCM
+        select SND_VMASTER
         help
           Say Y here to include support for TerraTec 6fire DMX USB interface.
 
