From: Michal Rokos <m.rokos@sh.cvut.cz>
Subject: Re: Alsa vs ALi5451
Date: Fri, 1 Nov 2002 13:31:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021101123101.GB5133@nightmare.sh.cvut.cz>
References: <20021029214043.GA28410@nightmare.sh.cvut.cz> <s5hk7jzbzg4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hk7jzbzg4.wl@alsa2.suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Oct 30, 2002 at 06:37:15PM +0100, Takashi Iwai wrote:
> >     I'm having problem with ALi5451 audio chipset.
> > 
> >     Insmod segfaults and lsmod says that initializing the snd-ali5451. The wierd is the OSS trident module is working just fine (with some limitation - I can't make it work throught the phones), but it's workin'. So I guess it's alsa problem.
> >     
> >     Please, keep me in CC - I'm not on list.
> 
> does the attached patch cure?

	No - yes, but just a bit. There's no coredump anymore.

	modprobe snd-ali5451 now says "ali create: chip init error"
	nothing more. Sound doesn't work.

		Michal


nb15:~# lsmod
Module                  Size  Used by    Not tainted
snd-ali5451            16608   0  (unused)
snd-pcm                86112   0  [snd-ali5451]
snd-timer              16280   0  [snd-pcm]
snd-ac97-codec         35172   0  [snd-ali5451]
snd                    40356   0  [snd-ali5451 snd-pcm snd-timer
snd-ac97-codec]
soundcore               6724   0  [snd]
8139too                18108   1
mii                     3848   0  [8139too]
nls_iso8859-2           4092   1  (autoclean)
nls_cp852               4316   1  (autoclean)
vfat                   11840   1  (autoclean)
fat                    45240   0  (autoclean) [vfat]
crc32                   1732   1  [8139too]

	looks good, but doesn't work

nb15:~# alsactl -d power
alsactl: power:1257: No soundcards found...

	but no cards found...

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Ing. Michal Rokos                    Czech Technical University, Prague
e-mail: m.rokos@sh.cvut.cz    icq: 36118339     jabber: majkl@jabber.cz
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
