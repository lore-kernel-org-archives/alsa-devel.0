From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_seq_port_info_get_client &
 snd_seq_client_info_get_name
Date: Fri, 16 Jan 2004 09:48:19 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401151953080.14174-100000@studcom.urz.uni-halle.de>
References: <200401151639.30565.holborn@telefonica.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200401151639.30565.holborn@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: holborn <holborn@telefonica.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

holborn wrote:
> 'snd_seq_port_info_get_client' returns always the same value?

Clients 0..63 are ALSA system clients, with fixed numbers (0=system
broadcast/timer, 62=dummy, 63=OSS emulation).

Clients 64..127 are devices on sound cards.  There are 8 numbers per
card: 64..71 = card 0, 72..79 = card 1, etc.

Clients 128..191 are applications.  An application gets the next free
number.

> for hardware or software devices even if are not started in the
> same order? or if the number of devices is different?

Hardware devices retain their number as long as the card number stays
the same.

Software devices can have a more or less random number; you have to
identify them by name, or let the user select it.

> I don't checkit ... but if it's not the same number, maybe could
> be a good thing add some extra info in
> 'snd_seq_client_info_get_name', card number?

The name of rawmidi sequencer ports already contains the card number.

> because if you have two same cards, client_info is the same for
> both,

PCI cards are initialized in some fixed order.

> and port can be different each time you restart, if Plug&Play USB
> cards works (I don't know ... ),

Two _identical_ USB devices cannot be distinguished by the current
driver, but it's possible if they have different product IDs.


HTH
Clemens




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
