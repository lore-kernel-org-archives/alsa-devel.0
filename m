From: Luca Piccioni <luca.piccioni@gmail.com>
Subject: IEC958 plugin and Rate plugin programming
Date: Sat, 11 Feb 2006 10:30:04 +0100
Message-ID: <43EDAE9C.7060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

My challenge now is to output a stereo 16 bit (LE) @ any Hz to the
S/PDIF digital output.
Opening the hardware digital output device (for me is "hw:0,4") this
don't work: probably
because I can't send linear PCM to this device, right?

Ok, I've seen a IEC958 plugin... it does conversion between linear PCM
to IEC958 Subframes, right?
(tell me if I'm wrong!!!). So I open with snd_pcm_open the device
"hw:0,4" (or it's alias iec958/spdif),
the uses the iec958 plugin using snd_pcm_iec958_open, using as slave
the hardware device opened
before. Now, the hardware device (the slave) should be not touched,
right? To setup hardware
parameters and software parameters I use the returned pcm handle by
snd_pcm_iec958_open... right?
So, if I've understood, writing simple linear PCM stereo data to such
device, audio will be converted
into IEC958 frames and sent to the hardware device "hw:0,4"!!!

Actually this works (my application doesn't report any error or
warning), but at the moment I can't test
this solution bacause an amplificator is missing to me!!! (but it will
in some day :-) ).

I would ask if this is the correct way to use plugin.

Another question is: I can create a more complex plugin chain? Say my
IEC958 device only setup to 48000
Hz: I would like to performe a sample rate conversion (to 48000)
before converting to IEC958 frames...
is it possible? How to organize/initialize ALSA plugins?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD7a6cKK3BAIBUkxERAvlSAJ41MmOkx++wvxzFMFp6zUv0rqUXzwCfQyQ1
TzoZbZcNxW8La/qApnoiDrQ=
=hrdX
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
