From: Jussi Laako <jussi.laako@kolumbus.fi>
Subject: Re: No sound with Midiman Delta 1010LT
Date: Mon, 15 Apr 2002 21:37:35 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CBB1DEF.8D61A6F9@kolumbus.fi>
References: <1018717194.5273.21.camel@idefix.homelinux.org>
		<056001c1e332$b551ee40$2900a8c0@burp>
		<1018755316.1852.23.camel@idefix.homelinux.org>
		<004801c1e3c2$dcd6a6a0$2900a8c0@burp> <1018806069.1812.15.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from rankki.uworld.dyndns.org (root@ua163d40hel.dial.kolumbus.fi [62.248.237.163])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA23251
	for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2002 20:37:44 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jean-Marc Valin <jean-marc.valin@hermes.usherb.ca>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jean-Marc Valin wrote:
> 
> The card has 4 AK4524s and 15 small chips labeled as 5532 114B RJC. Also
> a CS8427. Any useful info you can extract from that?

AK4524 is a 24-bit 96 kHz stereo CODEC (AD & DA converter).
CS8427 is a transceiver chip handling IO for the AK4524's and also S/PDIF
interfaces.

JRC's chip is most probably an operational amplifier handling analog
buffering and filtering.


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
