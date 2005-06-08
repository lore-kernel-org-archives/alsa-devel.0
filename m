From: Sebastian Stein <seb_stein@gmx.de>
Subject: Re: Compilation alsa-driver-1.0.9b still broken
Date: Wed, 8 Jun 2005 17:49:29 +0200
Message-ID: <20050608154929.GA467@hpfsc.de>
References: <20050608151459.GA1492@hpfsc.de> <s5hoeagkh0q.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hoeagkh0q.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> [050608 17:47]:
> > ../alsa-kernel/pci/ens1370.c: In function `snd_ensoniq_playback1_prepare':
> > ../alsa-kernel/pci/ens1370.c:852: error: `e' undeclared (first use in this
> > function)
> > ../alsa-kernel/pci/ens1370.c:852: error: (Each undeclared identifier is
> > reported only once
> > ../alsa-kernel/pci/ens1370.c:852: error: for each function it appears in.)
> > ../alsa-kernel/pci/ens1370.c:852: error: parse error before "se"
> > make[1]: *** [ens1371.o] Error 1
> > make[1]: Leaving directory `/usr/src/alsa/alsa-driver-1.0.9b/pci'
> > make: *** [compile] Error 1
> 
> I guess your alsa-kernel/pci/ens1370.c file is broken.

Maybe, but I just used the files provided in the tar on alsa-project.org.
The md5sum of the file is on my system:

e2a085f4ea1f0098a0b8ba1bff5e9bae  ens1370.c

Sebastian


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
