From: Remi Bernhard <rgbmlist2@free.fr>
Subject: Xruns with Audiophile 2496 M-audio
Date: Sat, 29 May 2004 11:49:08 +0200
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20040529114908.2118135c@pentium233.krystal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I read a lot a great thing about the audiophile 24/96 on the net, and i
decided to buy it to get better latency than my old sblive! I just
received the audiophile 24/96 and unfortunatly, i have a lot of XRuns
with when i run jackd.

I already tried the following :

- i changed irq (several changes : irq5, then irq 10)
- Disable nearly all the inboard harware (serial port, parallel port,
usb)
- i changed the Pci port
- i tried to run jackd as root
- i even tried to raise buffer at big values : 512, 1024, and even there
i have some (1 or 2) xruns
- i'm now trying with kernel 2.6.6 to see if things are better


Hardware :
  MSI K7N2Delta MB
  Athlon 2400
  Nvidia Geforce 4mmx
  Audiophile 24/96 M-Audio

Sofware :
  Debian/Testing
  Kernel 2.6.5
  Alsa 1.0.4rc2
  Realtime-Lsm 0.1.0
  Jackd 0.98


Do you have ideas, before i return the card to the shop ?

Regards,
	R=E9mi Bernhard.



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
