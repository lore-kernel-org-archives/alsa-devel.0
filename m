From: "Tom Browne" <tbrowne@tbrowne.demon.co.uk>
Subject: Re: No sound with Midiman Delta 1010LT
Date: Sat, 13 Apr 2002 22:32:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <056001c1e332$b551ee40$2900a8c0@burp>
References: <1018717194.5273.21.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net [194.217.242.88])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA15744
	for <alsa-devel@alsa-project.org>; Sat, 13 Apr 2002 23:17:08 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jean-Marc Valin <jean-marc.valin@hermes.usherb.ca>, alsa-devel@alsa-project.org
Cc: martino_an@yahoo.com
List-Id: alsa-devel@alsa-project.org

Hiya,

The 1010LT uses different codecs to the normal 1010... they may well need
initialising in a different way...

- Tom.


----- Original Message -----
From: "Jean-Marc Valin" <jean-marc.valin@hermes.usherb.ca>
To: <alsa-devel@alsa-project.org>
Cc: <martino_an@yahoo.com>
Sent: Saturday, April 13, 2002 5:59 PM
Subject: [Alsa-devel] No sound with Midiman Delta 1010LT


Hi,

I have a Midiman Delta 1010LT and I cannot get any sound in or out of
the card with ALSA. I'm using CVS ALSA (from 20020413) and the file
ice1712.c it contains includes "support" for the right EEPROM number
(0x12143bd6, which is what I get in /proc/asound/card0/ice1712).

I can start the envy24control mixer and when I play a sound, I see the
VU-meters moving and un-muting and increasing the volume makes a signal
appear on the "Digital Mixer" VU-meter. However, no sound comes out of
the card and the "Patchbay/Router" shows only SPDIF/Out.

<snip>
