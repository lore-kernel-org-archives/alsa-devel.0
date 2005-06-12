From: fab <fab@gnux.info>
Subject: Re: Medion Laptop + alc880
Date: Sun, 12 Jun 2005 20:22:15 +0200
Message-ID: <20050612182215.GA4060@blackmilk.localzone.fr>
References: <20050609172631.GA26714@blackmilk.localzone.fr> <m2hdg74blq.fsf@vador.mandriva.com> <s5hvf4m1171.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hvf4m1171.wl@alsa2.suse.de>
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
Cc: Thierry Vignaud <tvignaud@mandriva.com>, fab <fab@gnux.info>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10/06/05 21:06 +0200, Takashi Iwai wrote:
> At Thu, 09 Jun 2005 20:41:05 +0200,
> Thierry Vignaud wrote:
> > 
> > fab <fab@gnux.info> writes:
> > 
> > > I already said the intel-hda driver is badly working with latest
> > > (cvs) alsa, I had no speaker out and most outputs were mangled
> > > . realtek released a new driver:
> > > 
> > > ftp://152.104.238.194/pc/hda/alc880d/linux_r32.zip
> > > 
> > > Not perfect, but makes the internal speaker working and most outputs
> > > are working as expected, I havn't tried it much but it's by far the
> > > best working driver for this card.
> > 
> > this is a patched alsa-driver-1.0.9rc4a (just checked against the
> > official tarball):
> 
> Yes, I merged it and rewrote many codes on CVS.  Give it a try.

Ok, I checked out alsa today and it looked weired, the card= was
uneffective and I always got something looking like card=test. The
internal speakers were always off too...
Are all the changes from realtek applied ?
My computer was out for repairing and I got it 3 days ago, I havn't read
the ML for long, am I missing some insmod parameters ?

Regards.
Fabien Devaux.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
