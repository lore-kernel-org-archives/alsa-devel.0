From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Audigy and ac3-passthrough not working..
Date: Sun, 3 Nov 2002 22:49:10 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211032248060.5519-100000@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
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


Hello!

Anyone working with SB Audigy driver to get hwac3 working?

I'm testing with mplayer (0.9pre9) and I get this:

mplayer -ao alsa9 -ac hwac3 foo.avi

Forced audio codec: hwac3
Opening audio decoder: [hwac3] AC3 pass-through SP/DIF
No accelerated IMDCT transform found
AUDIO: 48000 Hz, 2 ch, 16 bit (0x400), ratio: 56000->192000 (448.0 kbit)
Selected audio codec: [hwac3] afm:hwac3 (AC3 through SPDIF)

alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 2 channels, AC3
alsa-init: soundcard set to iec958:AES0=3D0x2,AES1=3D0x82,AES2=3D0x0,AES3=
=3D0x2
ALSA lib pcm_hw.c:835:(snd_pcm_hw_open) open /dev/snd/pcmC0D3p failed: No
such device
alsa-init: playback open error: No such device
couldn't open/init audio device -> no sound
Audio: no sound!!!

Any ideas?


- Pasi K=E4rkk=E4inen


                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
