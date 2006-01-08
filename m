From: =?ISO-8859-2?Q?Pawe=B3_Goleniowski?= <pawelg@dabrowa.pl>
Subject: ALSA driver - snd-bt87x and Flyvideo`98
Date: Sun, 08 Jan 2006 12:23:35 +0100
Message-ID: <43C0F637.1020100@dabrowa.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,
My TV card used to work as additional sound device with snd-bt87x. But
not any more.
Under 2.6.12 it still works - dmesg shows info that card is
unrecognized and gives this address to send informations:
Card: Flyvideo 98 (probably) LR50
ID: 0x1851:0x1850 (but scanpci shows that BT audio device is 0x109e
0x0878)

Under 2.6.15 or ALSA 1.0.11rc2 the BT audio device doesn't work any
more nor even gives any information in dmesg.

Please help and thanks in advance.

goldi

- --
Ksi=EAga Bokonona, rozdzia=B3 14. Jak=B1 nadziej=EA mo=BFe =BFywi=E6 my=B6=
l=B1cy
cz=B3owiek co do przysz=B3o=B6ci ludzko=B6ci, je=B6li we=BCmie pod uwag=EA
do=B6wiadczenia ostatniego miliona lat?: "=AFadnej."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFDwPY2H8wn/AU/k3MRAjyyAJ9mqczW2H2SjOa0i1uSye/5Aff7nACfXdld
T6uFceRLdQNWbt0wDTiirsc=3D
=3De5Sr
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
