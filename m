From: Martin Langer <martin-langer@gmx.de>
Subject: Re: 1.0.4rc from cvs-head: snd-usb-usx2y still needs snd-hwdep....
Date: Wed, 31 Mar 2004 20:57:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040331185719.GA9281@tuba.home>
References: <200403310119.34195.annabellesgarden@yahoo.de> <Pine.LNX.4.58.0403310910110.1950@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403310910110.1950@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 31, 2004 at 09:10:17AM +0200, Jaroslav Kysela wrote:
> On Wed, 31 Mar 2004, Karsten Wiese wrote:
> 
> > ..., which is not built.
> > this is for kernel 2.4.
> > 
> > /etc/asound/driver_args:
> > --with-cards=via82xx,msnd-pinnacle,usb-audio,usb-usx2y,es1968 
> > --with-kernel=/usr/src/linux-2.4 --with-debug=full --with-sequencer=yes
> 
> Fixed.
> 

Really?

./configure --with-cards=usb-usx2y

/sbin/depmod -ue

depmod: *** Unresolved symbols in
/lib/modules/2.4.25-rc1/kernel/sound/usb/snd-usb-audio.o
depmod:         snd_rawmidi_transmit_peek
depmod:         snd_rawmidi_transmit_ack
depmod:         snd_rawmidi_transmit_empty
depmod:         snd_rawmidi_receive
depmod:         snd_rawmidi_new
depmod:         snd_rawmidi_set_ops
depmod: *** Unresolved symbols in
/lib/modules/2.4.25-rc1/kernel/sound/usb/usx2y/snd-usb-usx2y.o
depmod:         snd_hwdep_new


martin

-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
