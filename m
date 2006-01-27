From: "Thibault LE MEUR" <Thibault.LeMeur@supelec.fr>
Subject: Audiophile USB analog capture byte alignment error
Date: Fri, 27 Jan 2006 14:45:40 +0100
Message-ID: <044601c62347$f9917ef0$a578e4a0@supelec.fr>
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

The audiophile usb analog capture seems to be unreliably initialized by =
the
ALSA=20
driver. Just after bootup (or after an /etc/init.d/alsasound restart) =
the
sound=20
recorded on the analog capture port is sometimes either:
- Case A: saturated/distorted (as if it had a very high volume gain) :-(
or
- Case B: completly inaudible and loud white noised :-( )
or
- Case C: sometimes the sound is good :-)

Reproductability:
* Affects only the analog audiophile USB capture interface (also =
reported by
other users)
* It doesn't affect the Digital capture input
* Same issue when using the plugin "plughw:1,1"

Environment:
* Advanced Linux Sound Architecture Driver Version 1.0.11rc2. + CVS =
patches
for the audiophile USB (ALSA bugid 0001585)
* kernel 2.6.15.1 + PREEMPT patch

A way to make the analog capture functionnal is to restart alsa
(/etc/init.d/alsasound restart), test again analog audio capture and if =
not
Ok restart again until a good initialization is done (usually one or two
restarts are enough).

It _sounds_ like the alsa driver doesn't begin to read at the right byte
inside the 3bytes-BigEndian-word=20
sequence (S24_3BE).

In order to investigate this issue, I've recorded a sound with arecord:
 arecord -D hw:1,1 -c2  -t raw -r48000 -fS24_3BE test.raw
If I play the test.raw file it sounds like a very loud white noise:
 aplay -D hw:1,0 -c2 -t raw -r48000 -fS24_3BE test.raw

I edited the test.raw file with KHexEdit (it begins like this):
 0000:0000 c2 ff fd 9b ff fd 6e ff fe 07 ff fd 4e ff ff e7
 0000:0010 ff fd 62 ff fd cb ff fd ca ff ff bb ff fc 56 ff
 0000:0020 fc ef ff fd 2e ff fe d7 ff ff 7e ff fd 43 ff fc
 0000:0030 2a ff fe e3 ff fd e6 ff fb bc ff fd 26 ff fe a0

In order to realign the stream, I inserted a leading 00:
 0000:0000 00 c2 ff fd 9b ff fd 6e ff fe 07 ff fd 4e ff ff
 0000:0010 e7 ff fd 62 ff fd cb ff fd ca ff ff bb ff fc 56
 0000:0020 ff fc ef ff fd 2e ff fe d7 ff ff 7e ff fd 43 ff
 0000:0030 fc 2a ff fe e3 ff fd e6 ff fb bc ff fd 26 ff fe
 0000:0040 a0 ff fe d3 ff fe 40 ff fe 03 ff fe b4 ff fe b3

Now If I play the sound I get less white noise, I can hear notes, but=20
my sound is saturated (far too loud) exactly the same distortion as I=20
got sometimes after an "alsasound restart" (see the beginning of my=20
mail).

Then I added another leading 00 byte:
 0000:0000 00 00 c2 ff fd 9b ff fd 6e ff fe 07 ff fd 4e ff
 0000:0010 ff e7 ff fd 62 ff fd cb ff fd ca ff ff bb ff fc
 0000:0020 56 ff fc ef ff fd 2e ff fe d7 ff ff 7e ff fd 43
 0000:0030 ff fc 2a ff fe e3 ff fd e6 ff fb bc ff fd 26 ff

The audio file is now normal, I can hear music and not noise nor=20
saturated sounds with "aplay -D hw:1,0 -c2 -t raw -r48000 -fS24_3BE
test.raw"

Of course I can get the same result by patching my original file in the=20
opposite way (by substracting the leading "c2" byte instead of adding 2
bytes "00 00"):
 0000:0000 ff fd 9b ff fd 6e ff fe 07 ff fd 4e ff ff e7 ff
 0000:0010 fd 62 ff fd cb ff fd ca ff ff bb ff fc 56 ff fc
 0000:0020 ef ff fd 2e ff fe d7 ff ff 7e ff fd 43 ff fc 2a
 0000:0030 ff fe e3 ff fd e6 ff fb bc ff fd 26 ff fe a0 ff
 0000:0040 fe d3 ff fe 40 ff fe 03 ff fe b4 ff fe b3 ff fb

Is someone able to patch it or help me identify the part of=20
the driver causing this issue inside the alsa-driver source code?

I haven't found any bugreport on this particular issue, do you want me =
to
fill a bug report?

Thanks in advance for your help,
Regards,
Thibault




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
