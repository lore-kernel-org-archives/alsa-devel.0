From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Audigy LS Midi support.
Date: Tue, 22 Jun 2004 09:14:25 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406220910510.19521-100000@studcom.urz.uni-halle.de>
References: <40D72DCE.3020803@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <40D72DCE.3020803@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> I don't use MIDI for anything, so adding support for it to the Audigy LS
> driver is rather difficult.
>
> For this, I suppose I would need a sort of midi loopback, or an external
> midi device.

On the gameport, pin 12 is MIDI Out and pin 15 is MIDI In.  You can
simply connect them with a wire.

  8             1
-------------------
\ o o o o o o o o /
 \ o o o o o o o /
  -+-----+-------
 15|     |     9
   \_____/


HTH
Clemens




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
