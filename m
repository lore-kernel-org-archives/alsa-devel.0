From: James Tappin <james@tappin.me.uk>
Subject: Re: Testers of M-Audio Delta/Audiophile cards wanted
Date: Thu, 19 Sep 2002 18:54:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020919185429.78213ea3.james@tappin.me.uk>
References: <s5h7khiqh4g.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7khiqh4g.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Sep 2002 14:49:19 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> Hi,
> 
> can M-Audio Delta or Audiophile users test the latest ice1712 driver?
> i'd like to confirm that the new one works fine before removing the
> old code.
> 
> the ice1712 codes are split to several files for better readability,
> and now located under alsa-kernel/pci/ice1712 directory on cvs.
> there is no new functionality added due to this change.
> 
> since the old ice1712.c is still compiled as default, you'll have to
> run "make" on alsa-driver/pci/ice1712.  the new files are not compiled
> otherwise.
> then copy snd-ice1712.o on that directory to
> /lib/modules/XXX/kernel/sound/pci directory manually, run "depmod -a",
> and reload the module. 

With the Midiman Audiophile: aplay/arecord work correctly as does
recording from gramofile and playback via gwc (both use the OSS api). With
snd playback works but recording gives a no device error -- but that may
be because it's the version from Debian/Woody and it may be build against
an incompatible version of something (since I haven't tried to record with
snd since I switched from SuSE to Debian I'm not sure if the new driver
has any responsibility for this). 

Since I don't have any digital hardware I've not tested the AC97/SPDIF
stuff.

Best regards,
	James

-- 
James Tappin,               O__      "I forget the punishment for using
james@tappin.me.uk         --  \/`    Microsoft --- Something lingering
http://www.xena.uklinux.net/          with data loss in it I fancy"  


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
