From: Dave Phillips <dlphilp@bright.net>
Subject: PDAudioCF questions
Date: Thu, 14 Aug 2003 07:54:23 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F3B867E.D0D41B46@bright.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Greetings:

  I'm testing the Core Sound PDAudioCF card on a laptop, an Omnibook
4150, using a CF-to-PCMCIA adapter. The card appears to initialize
correctly, and 'cat /proc/asound/cards' tells me this:

	0 [PDAudioCF      ]: PDAudio-CF - Core Sound PDAudio-CF
        	             Core Sound PDAudio-CF at 0x100, irq 11

'ls /proc/asound/card0' yields this information:

	dlphilp@localhost:~$ ls /proc/asound/card0/
	id  oss_mixer  pcm0c

where 'pcm0c' is a subdirectory and oss_mixer simply lists mixer
elements. However, I've been unable to invoke a mixer for the card. That
might be why I receive the following error trying to use arecord:

	dlphilp@localhost:~$ arecord -Dhw:PDAudioCF -f cd
	RIFF$=FF=FFWAVEfmt o`aD=ACo=B1acodata=FF=FFRecording WAVE 'stdout' : Sig=
ned 16 bit
Little Endian, Rate 44100 Hz, Stereo
	arecord: pcm_read:1110: read error: Input/output error

  The test is done with ALSA 0.9.6 under kernel 2.4.18. If anyone else
is working with this card I'd like to hear about your success/failure,
particularly if you've used it on a laptop (not a PDA). I'll also check
the archives for previous messages about this card. TIA!

Best regards,

=3D=3D Dave Phillips

	The Book Of Linux Music & Sound at http://www.nostarch.com/lms.htm
	The Linux Soundapps Site at http://linux-sound.org


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
