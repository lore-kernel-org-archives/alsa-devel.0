From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: multiple instances of snd-virmidi?
Date: Wed, 04 Jun 2003 08:43:50 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306040833410.868-100000@studcom.urz.uni-halle.de>
References: <41797.24.225.156.130.1054688709.squirrel@webmail.ouroboros-complex.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <41797.24.225.156.130.1054688709.squirrel@webmail.ouroboros-complex.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jfm3@ouroboros-complex.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

jfm3@ouroboros-complex.org wrote:
> Is there some way I can load snd-virmidi into the kernel multiple times?

Yes. This would be something like this in the modules.conf:

	options snd cards_limit=3

	alias snd-card-0 snd-whatever
	alias snd-slot-0 snd-card-0
	options snd-whatever index=0 ...

	alias snd-card-1 snd-virmidi
	alias snd-card-2 snd-virmidi
	alias snd-slot-1 snd-card-1
	alias snd-slot-2 snd-card-2
	options snd-virmidi index=1,2 enable=1,1 midi_devs=2,2

> This would help me get around a deficiency in Pd. Pd uses OSS to open the
> MIDI devices, and only opens each one once. So it only talks to port 1 on
> my mtpav, for example. It treats a virmidi device the same way. But I
> figure if I could load multiple virmidi drivers I could hack around this.

With the above settings, you'd have
/dev/midi1  -> card 1, device 0
/dev/amidi1 -> card 1, device 1
/dev/midi2  -> card 2, device 0
/dev/amidi2 -> card 2, device 1


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
