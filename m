From: Uros Bizjak <uros@kss-loka.si>
Subject: Re: sb16 gets wedged when doing overlapped i/o (full
 duplex)
Date: Thu, 5 Dec 2002 15:55:49 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.05.10212051455590.3576-100000@pulsar.kss-loka.si>
References: <3DEF5865.7060109@monmouth.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DEF5865.7060109@monmouth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "John S. Denker" <jsd@monmouth.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

> I tried setting it to Capture.
> No joy.  ALSA gets wedged just the same as before.
> 
> By the way, is this DMA Allocation thingy documented anywhere?????

  Yes, now it is mentioned in isa/sb/sb16_main.c driver source.

> I had to do a huge find|grep to figure out what this
> suggestion was referring to.  Alsamixer knows nothing
> of this switch.  Amixer knows nothing of this switch.
> Fortunately alsactl can deal with it.

  It is not a IFACE_MIXER switch, but IFACE_PCM type switch.

  From the error message you posted about this bug, it looks that driver
is trying to call prepare() operator on a substream that is still 
in SNDRV_PCM_STATE_RUNNING state. Perhaps Jaroslav could tell us if this
can happen if hardware pointers are not updated anymore (because sb16 DMA
engine gets stucked somehow). Do you get an XRUN message in
/var/log/messages?

	Uros.






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
