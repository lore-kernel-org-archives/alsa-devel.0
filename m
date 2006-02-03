From: "Thibault LE MEUR" <Thibault.LeMeur@supelec.fr>
Subject: Help Troubleshooting  usbaudio.c for bugID 1801
Date: Fri, 3 Feb 2006 10:35:58 +0100
Message-ID: <003001c628a5$4066c670$a578e4a0@supelec.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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

Hi,

I'm trying to troubleshoot bugid 1801 (Audiophile USB analog capture) =
where
the snd-usb-audio is not alligned on the "3-byte-words" audio stream =
while
reading from the capture interface.

For instance Audio samples (lets call them S1, S2 S3) are 3 bytes long =
(lets
call each of them A, B, C).

Instead of reading:
S1 =3D S1A S1B S1C
S2 =3D S2A S2B S2C
S3 =3D S3A S3B S3C

Snd-usb-audio skips the first byte and reads:
S1 =3D S1B S1C S2A
S2 =3D S2B S2C S3A
S3 =3D S3B S3C ...

I can try to debug this (and even try to patch) but I have no idea as to
where begin my investigation:
* Is this bug due to the way snd-usb-audio reads samples or to a
synchronization issue while initializing the device?
  - Indeed, on this device the Analog Capture function can be addressed =
by
several Interface/AltSettings which differ only from their =
synchronization
SYNC/ASYNC property
* Is there any debug traces I could add to the usbaudio.c code in order =
to
figure out what's wrong?
  - can you point me to the relevant lines in usbaudio.c ?

Thanks in advance for any tips/idea you could give me in order to help
identify this issue.

Thibault




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
