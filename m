From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Change default sound card ?
Date: Tue, 8 Mar 2005 14:50:41 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503081443540.835-100000@studcom.urz.uni-halle.de>
References: <1110289009.422daa71553ee@webmail.volja.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1110289009.422daa71553ee@webmail.volja.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: robinud@volja.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

robinud@volja.net wrote:
> Recently I tried to change my default sound card (I have two) and it seems
> more complicated than needed.
>
> For example I want to use card 1 device 1 as default, I must
> change :
>
> defaults.ctl.card 0

This is the default mixer.

> defaults.pcm.card 0
> defaults.pcm.device 0

This is the default for audio output.

> defaults.rawmidi.card 0
> defaults.rawmidi.device 0
> defaults.hwdep.card 0
> defaults.hwdep.device 0
> defaults.timer.card 0
> defaults.timer.device 0

These are devices that aren't used often (and your card probably
doesn't even has them).


> defaults.ctl.card defaults.card
> defaults.pcm.card defaults.card
> defaults.pcm.device defaults.device
> defaults.rawmidi.card defaults.card
> defaults.rawmidi.device defaults.device
> ...

PCM and RawMIDI device number are completely independent.  If your
preferred PCM device and RawMID device have the same device number,
it's just by chance.


If you just want to swap your cards, use different "index" options in
your modprobe.conf/modules.conf, e.g.:

options snd-emu10k1 index=0
options snd-intel8x0 index=1

This has the benefit of changing the card numbers for OSS emulation,
too.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
