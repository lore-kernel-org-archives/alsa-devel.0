From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio/Midiman - partial success
Date: Tue, 17 Sep 2002 09:29:59 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0209170923300.5178-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.31.0209160838270.10583-100000@lorien.wv.mentorg.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.31.0209160838270.10583-100000@lorien.wv.mentorg.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: "Pikus, Fedor" <fedor_pikus@mentorg.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fedor G. Pikus wrote:
> On Mon, 16 Sep 2002, Clemens Ladisch wrote:
> > > arecord: pcm_read:1049: read error: Input/output error
> >
> > Anything in /var/log/mesages?
> > Does it happen with 24 bits, too?
> > Is the data in the file correct (as far as is has been recorded)?
>
> Nothing in the log at all. I can bump up the debug level for usb-snd-audio,
> what would be helpful, if anything?

I had expected some messages from the USB subsystem.
Anyway, enabling debug output would help.

> It happens with either S16_LE or S24_3LE if the rate is 96000.
> It does not happen right away, but after several seconds. There is something
> in the file (i.e. the length is not 0) but it's not correct (i.e. any
> tool I try to send this file to reports that it's corrupt, starting with aplay).

arecord didn't set the length when it was interrupted. Please try to
record a raw file.


HTH
Clemens



-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
