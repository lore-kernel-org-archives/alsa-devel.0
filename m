From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: midi problems with Quattro usb interface
Date: Mon, 24 Mar 2003 09:03:22 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0303240901300.19990-100000@studcom.urz.uni-halle.de>
References: <1048299352.3921.57.camel@cmn37.Stanford.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1048299352.3921.57.camel@cmn37.Stanford.EDU>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fernando Pablo Lopez-Lezcano wrote:
> [...]
> Apparently having active sensing midi bytes coming in to the Quattro
> while the driver is being loaded kills input. I was not able to make
> things work if the keyboard is connected to the interface when alsa
> starts.
>
> A MidiSport2x2 works fine under the same conditions (using the open
> source firmware). It is not affected by the same Oxygen8 keyboard being
> plugged in when the driver starts.

This may be a bug (feature) of the Quattro firmware (which can't be
changed). It would be nice to know if the MidiSport 2x2 with Midiman's
firmware behaves in the same way.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
