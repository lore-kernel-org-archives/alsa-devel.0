From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Edirol UA-20 PCM support
Date: Mon, 24 Feb 2003 18:17:45 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302241742040.2567-100000@studcom.urz.uni-halle.de>
References: <20030224143902.GA8502@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030224143902.GA8502@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Frank Barknecht wrote:
> I'm getting a bit tired from being Edirol's laboratory animal. Why
> didn't they implement the standard they wrote?

The Windows USB audio driver (tries to) handle all devices marked as
standard compatible. If a device offers capabilities which are implemented
buggily or not at all in Microsoft's driver (such as MIDI in Win2K), it
has to be marked as "vendor-specific" to prevent the Microsoft driver from
loading so that the vendor's bug-free driver can access the device.

> It says: "Sub=03 Prot=00 Driver=(None)" at the Edirol, whereas the
> other interfaces are claimed by snd-usb-audio.

That's a bug in my patch. I'll have to rewrite it.


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
