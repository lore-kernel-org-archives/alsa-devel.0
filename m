From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Maximum number of sound devices
Date: Mon, 15 Aug 2005 09:50:57 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508150943420.21757-100000@studcom.urz.uni-halle.de>
References: <42FFAA92.10008@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42FFAA92.10008@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Robert Dunn <robert.j.dunn@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Robert Dunn wrote:
> > What is the maximum number of capture devices ALSA supports?

ALSA supports up to 8 sound cards, and up to 8 devices on one sound
card.  (It's possible to increase the latter number by using
subdevices.)

It may be possible to hack the snd-usb-audio driver so that it
pretends that multiple USB devices are one sound card.

James Courtier-Dutton wrote:
> The default is 8, but it can be changed with a module option for module
> "snd"

But it cannot be increased beyond 8 (as long as ALSA uses static
device number allocation for its 8-bit minor numbers).


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
