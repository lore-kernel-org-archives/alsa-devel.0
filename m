From: Jean-Marc Valin <jean-marc.valin@hermes.usherb.ca>
Subject: No sound with Midiman Delta 1010LT
Date: 13 Apr 2002 12:59:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1018717194.5273.21.camel@idefix.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from VL-MS-MR003.sc1.videotron.ca (relais.videotron.ca [24.201.245.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA12242
	for <alsa-devel@alsa-project.org>; Sat, 13 Apr 2002 19:00:26 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: martino_an@yahoo.com
List-Id: alsa-devel@alsa-project.org

Hi,

I have a Midiman Delta 1010LT and I cannot get any sound in or out of
the card with ALSA. I'm using CVS ALSA (from 20020413) and the file
ice1712.c it contains includes "support" for the right EEPROM number
(0x12143bd6, which is what I get in /proc/asound/card0/ice1712).=20

I can start the envy24control mixer and when I play a sound, I see the
VU-meters moving and un-muting and increasing the volume makes a signal
appear on the "Digital Mixer" VU-meter. However, no sound comes out of
the card and the "Patchbay/Router" shows only SPDIF/Out.

Also, a question I have regarding the ice1712.c file. Although I see
that ICE1712_SUBDEVICE_DELTA1010LT is defined with the right EEPROM
value, it doesn't seem to be used much, unlike the value for the Delta
1010 (non-LT). I tried to add the 1010LT everywhere I saw the 1010. The
result is that I now see all the outputs in the Patchbay/Router but I
still have no sound.

Can anyone help me get this to work? Actually, what I'm really
interested in is being able to record from the 8 analog inputs at the
same time.

My system:
Athlon T-Bird 1.33 GHz
ASUS A7V-133A / 768 MB RAM
Linux 2.4.18 (UP)
CVS ALSA (tried with and without the above modification to ice1712.c)
/proc/interrupts shows no IRQ conflict

Regards,

	Jean-Marc

--=20
Jean-Marc Valin, M.Sc.A.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada
