From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: writing driver for MOTU PCI 324, 2408 MK-II
Date: Mon, 9 May 2005 11:39:16 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505091131500.20877-100000@studcom.urz.uni-halle.de>
References: <20050508161425.GD25855@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050508161425.GD25855@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Forest Bond <f_a_b@softhome.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Forest Bond wrote:
> I've decided I want to write a driver for the Mark of the Unicorn
> PCI-324 PCI card.
>
> I have emailed MOTU tech support, but have not gotten a response.  I
> have a feeling this will be the case in the future, as well.

IIRC somebody reported that at a NAMM, a MOTU representative said that
MOTU wouldn't support Linux, wouldn't give out technical information,
and doesn't want any third party to write Linux drivers.

> Can released ASIO drivers be used to gather technical information on the
> hardware?

Yes.  Reverse engineering is perfectly legal in this case.

> Are there any good techniques for probing the hardware and discovering
> necessary technical info?

The only good technique is reading the technical documentation,
preferrably with the source code of the driver to see where the doc is
wrong.

If that isn't possible, you can run a disassembler on the driver and
then try to find out what it does.  Good luck.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
