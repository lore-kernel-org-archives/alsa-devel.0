From: Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
Subject: M-Audio Audiophile USB, native little endian (S16_LE) ?
Date: Sun, 08 Jul 2007 15:36:18 +0200
Message-ID: <20070708133618.62C75583E9@ip2-138.brfsodrahamn.se>
Reply-To: Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ip2-138.brfsodrahamn.se (ip2-138.brfsodrahamn.se
	[213.187.199.138])
	by alsa0.perex.cz (Postfix) with ESMTP id 971321037EA
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Jul 2007 15:36:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


Hi all !

I don't know if this is already known (?), but the M-Audio Audiophile USB
seem to be possible to run in native S16_LE mode if initialized with
device_setup=3D0x01 (possibly with 0x11 also, have not tested that).

This is at least the case with my rather new box (bought a couple of =

weeks ago).

Patch for usb/usbaudio.c (alsa-driver-1.0.14):

  static int is_big_endian_format(struct snd_usb_audio *chip, struct =

audioformat *fp)
  {
        switch (chip->usb_id) {
        case USB_ID(0x0763, 0x2001): /* M-Audio Quattro: captured data only=
 */
                if (fp->endpoint & USB_DIR_IN)
                        return 1;
                break;
        case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
  +             // Is small endian if setup with 0x01 !
  +             if (device_setup[chip->index] !=3D 0x01)
                   return 1;
                break;
        }
        return 0;
  }

/H=E5kan
