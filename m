From: Anders Torger <torger@ludd.luth.se>
Subject: Re: rme96 and mmap, bug?
Date: Wed, 27 Nov 2002 19:13:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211271913.43032.torger@ludd.luth.se>
References: <200207011724.g61HOt716880@d1o1116.telia.com> <0ClXuX241FA30000.gml@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <0ClXuX241FA30000.gml@xs4all.nl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: vanDongen-Gilcher <gml@xs4all.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 26 November 2002 00.24, you wrote:
> Hi all,
>
> When I try to use mmap with this card I get the following behaviour:
> (BTW, I give an explicit snd_pcm_start)
> In stereo-mode (device 0), I can preload the buffer with 2 periods of
> audio data, start and it works well.
> In ADAT-mode (device 1), trying to preload with 2 periods, gives a
> very distorted sound. It only works with preloading 3 (or more)
> periods before starting.
>
> When I use regular writei, I don't see this limitation. I only need 2
> periods of audio in ADAT-mode.
>
>
> Is this a bug of the driver, or a property of the card?

It was a while I looked at the driver last, and I don't use it in memory 
mapped mode nor ADAT in my daily work, so I really don't know about the 
state of the driver in those parts.

The hardware does not support memory mapped I/O, so it is copied by the 
CPU in the interrupt handler. Thus for that card you gain nothing from 
using memory mapped I/O, it was only implemented for compability.

I shall save this mail into "stuff I should look into", but right now it 
is unfortunately not among my top-ten items on the to do list.

/Anders Torger


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
