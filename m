From: Siegfried Kettlitz <alsa@siegfried-kettlitz.de>
Subject: Re: Terratec Phase 28
Date: Wed, 21 Jul 2004 01:48:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407210148.09832.alsa@siegfried-kettlitz.de>
References: <766ad7df0407181154624ed11b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <766ad7df0407181154624ed11b@mail.gmail.com>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Sonntag, 18. Juli 2004 20:54 schrieb Marco:
> Hi,
> Will the Terratec Phase 28 card be supported in future releases of Alsa?
> The chip is a VIA VT1724 [Envy24HT], which is currently supported, but
> that card itself is not on the list of those with that chip that are
> supported, and it's obviously not recognized by the driver.
> It has 2 analogic input cannel and 8 output (both with 192khz/24 bit
> support - tested on Windows), 1 digital in and 1 out, 1 midi in and 1
> out.
> I think it's no very different from the Aureon 7.1 (which is
> supported) and therefore there's need for only a few informations to
> make it work.
> Is anyone working on it?
>

Doesen't seem so.

My dirty solution for the Phase88 was:

Read the soundcard-ID=20
=2D--
# cat /proc/asound/card1/ice1712
TerraTec EWS88MT at 0xa400, irq 10

EEPROM:
  Subvendor        : 0x3b155111
  ...
=2D--

Then write the ID instead of the one of EWS88MT_NEW into the module. Recomp=
ile=20
modules. Reboot. And... it works (not all perfectly but it works).

=2D-- ews.h
//#define ICE1712_SUBDEVICE_EWS88MT_NEW 0x3b152511
#define ICE1712_SUBDEVICE_EWS88MT_NEW =A0 0x3b155111
=2D-

> Can I help somehow?

Invest some time and find a better solution.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
