From: Gregoire Favre <greg@ulima.unil.ch>
Subject: SPDIF and cs46xx ?
Date: Sat, 8 Mar 2003 15:41:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030308144119.GB29709@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

reading this ml, I see there were some change to the CVS regarding
cs46xx and SPDIF, so I do:

./cvscompile --with-sequencer=3Dyes --with-cards=3Dcs46xx --with-isapnp=3D=
no
make install

And then, my DVB-s card is connected to the first CD-in of my Digifire
7.1, I can hear it with the analog out, but not with the SPDIF...
Maybe I don't know how to change the mixer right?

And if I use the
http://prdownloads.sourceforge.net/sourceforge/bitstreamout/
I get:=20

Mar  8 15:31:16 localhost vdr[6790]: S/P-DIF: Period size not available: =
Invalid argument
Mar  8 15:31:16 localhost vdr[6790]: S/P-DIF: unable to establish BitStre=
amOut for none audio PCM=20
Mar  8 15:31:16 localhost vdr[6790]: INSTREAM: can't open spdif interface

Also with ac3play:

./ac3play /data/linux/dvb/from_beyond_the_edge_44k_256kbps.ac3=20
ac3play: Unable to update the IEC958 control: No such file or directory
ac3play: Period size not available: Invalid argument
Segmentation fault
Exit 139

mplayer also (with -ao alsa9):

Checking audio filter chain for 48000Hz/2ch/16bit -> 48000Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 48000 hz, little endian signed int=20
AF_pre: 48000Hz 2ch Signed 16-bit (Little-Endian)
alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 2 channels, Signed 16-bit (Little-=
Endian)
alsa-init: 1 soundcard found, using: hw:0,0
alsa-init: unable to set periodsize: Invalid argument
Could not open/initialize audio device -> no sound.
Audio: no sound

I have done some try with xine, but it's not better...

Should I do something differently?

Thank you very much,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
