From: Niklas Werner <bergtroll@gmx.li>
Subject: Re: status of usb audio driver
Date: Wed, 12 Jun 2002 16:19:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206121419.QAA12271@papaschlumpf.wg>
References: <s5hbsag1t5r.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbsag1t5r.wl@alsa2.suse.de>
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

Am Wednesday, 12. June 2002 16:13, wurde geschrieben:
> At Wed, 12 Jun 2002 23:10:19 +0900,
>
> Patrick Shirkey wrote:
> > Takashi Iwai wrote:
> > > it's on cvs.  please give a try.
> > > btw, now descriptor proc was removed (one can use lsusb anyway).
> > > instead you'll see formats supported on each stream.


OK, in stream0 now my emi26 is recognised as being capable of 6 outs @ 
44.1 or 48 k and 2 out @ 96 kHz, but still I only get /proc/asound/card0/:
id       pcm0p       pcm0c       stream0

so I still cant' access the other 4 outs. Or is there a way to use 
stream0 directly ?

Have fun*

Niklas

_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
