From: Tyler Knott <tknott@gmail.com>
Subject: The EMU 0404 soundcard and the Audigy driver...
Date: Thu, 24 Nov 2005 22:31:27 -0600
Message-ID: <ea4102e90511242031w2fb02dbcqfa0da72db999ddcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

I'm not quiet sure whether to post this here or on the alsa-user
mailing list, but seeing as this information is more usefule to the
development of than use of ALSA I decided to put it here.

I have an EMU 0404 soundcard and I just tried the patch below (adapted
from the one suggested at
http://article.gmane.org/gmane.linux.alsa.devel/22204) to try and get
the EMU10k1/Audigy driver to work with this card.  It does recognize
it, but I don't get any sound (not that I expected to anyways).  Mixer
settings do not seem to have any affect (and curiously none of the
channels, except for the Tone channel, are muteable).

----PATCH---- (not a real diff-generated patch)
alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c (@ about line 750)
  =09 .emu10k2_chip =3D 1,
  =09 .ca0102_chip =3D 1,
  =09 .ac97_chip =3D 1} ,
 + =09{.vendor =3D 0x1102, .device =3D 0x0004, .subsystem =3D 0x40021102,
 + =09 .driver =3D "Audigy", .name =3D "E-MU 0404 [4002]",
 + =09 .id =3D "0404",
 + =09 .emu10k2_chip =3D 1} ,
  =09{.vendor =3D 0x1102, .device =3D 0x0004,
  =09 .driver =3D "Audigy", .name =3D "Audigy 1 [Unknown]",
  =09 .id =3D "Audigy",


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
