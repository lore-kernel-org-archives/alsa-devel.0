From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: status of usb audio driver
Date: Wed, 12 Jun 2002 18:00:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206121600.SAA02216@papaschlumpf.wg>
References: <s5hbsag1t5r.wl@alsa2.suse.de> <200206121419.QAA12271@papaschlumpf.wg> <s5h7kl41s4l.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7kl41s4l.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > OK, in stream0 now my emi26 is recognised as being capable of 6 outs
> > @ 44.1 or 48 k and 2 out @ 96 kHz, but still I only get
> > /proc/asound/card0/: id       pcm0p       pcm0c       stream0
>
> it's ok.  a stream can support different formats and channels.
> if you find "Channels: 6" in stream0 proc file, then it means that the
> pcm device 'hw:0,0' (or hw:X,0 where X is the card number) can accept
> 6 channels playback/capture.  if so, you can just feed 6-channels
> interleaved data to the device.
> well, this means also, that you have to access all 6 channels at the
> same time.

bugger!
Well, OK, at least that gives me an idea... but the much discussed 
("multiple cards"-thread on jackit-devel) .asoundrc-fiddling for getting 
more than one app to do the playback should work ok then, shouldn't it?

I'll give it a try :-)

Have fun*

Niklas

_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
