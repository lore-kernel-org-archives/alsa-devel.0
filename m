From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Chaintech AV710
Date: Wed, 8 Dec 2004 19:00:27 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0412081858390.21064-100000@studcom.urz.uni-halle.de>
References: <1102188389.9490.17.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1102188389.9490.17.camel@localhost>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Russ Pridemore <russ.pridemore@comcast.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Russ Pridemore wrote:
> I have a Chaintech AV710 (Envy24HT) card

The driver doesn't know about this model.

>  ice1724: Invalid EEPROM version 1
>
> 0 [AUDIO2000      ]: ICE1724 - AMP Ltd AUDIO2000

This has the same PCI ID as the AUDIO2000 card, so it isn't detected
correctly.

Please show the contents of /proc/asound/card0/ice1724 and the output
of "lspci -nv" for this device.


Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
