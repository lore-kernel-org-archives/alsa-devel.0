From: Erik Welander <erikwel@spray.se>
Subject: Re: A simple question, Alsa on debian
Date: Thu, 13 Feb 2003 16:29:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045150178016301@lycos-europe.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_NextPart_Lycos_0163011045150178_ID"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

--=_NextPart_Lycos_0163011045150178_ID
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, and thanks for the help, It seems to work to compile the source from the tarball the ordinary way also.

Progress-report on the es18xx.c on ES1878:

* I found the nd_es18xx_dsp_get_byte() to be inconsistent with the spec. and rewrote it accordingly.

static int snd_es18xx_dsp_get_byte(es18xx_t *chip)
{
        int i;
        
              for(i =3D 0; i <=3D MILLISECOND; i++)
           if ((inb(chip->port + 0xE) & 0x80))
                      return  inb(chip->port + 0xA);
        }

* My goal would be to modify as little as possible to get is working by the way.

* Now I have discovered the following: by modifying snd_es18xx_playback_prepare() and snd_es18xx_playback_trigger() by hardcoding what function to choose I got some static sounds out of the chip by the following: 
--Combine snd_es18xx_playback2_prepare() with snd_es18xx_playback1_trigger gives static when playing a file in kern.log.
--Combine snd_es18xx_playback1_prepare() with snd_es18xx_playback2_trigger gives static and bug write in kern.log.


(by the way any other combination gives no sound at all for me such as combining snd_es18xx_playback2_prepare() with snd_es18xx_playback2_trigger)

This would entail that the problems could be in the prepare functions, since the mixer controls seem to respond with lowering/raising the output.

Best regards from Erik

_____________________________________________________________
H=E4r b=F6rjar internet!
Skaffa gratis e-mail och gratis internet p=E5 http://www.spray.se

Tr=E4ffa folk fr=E5n hela Sverige p=E5 ett och samma st=E4lle - http://chat.spray.se/



--=_NextPart_Lycos_0163011045150178_ID--



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
