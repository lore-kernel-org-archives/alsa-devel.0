From: Gregoire Favre <greg@ulima.unil.ch>
Subject: cs46xx and 5.1, does it work?
Date: Wed, 19 Feb 2003 13:39:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030219123952.GA2853@ulima.unil.ch>
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

I have got a Digifire 7.1 and try to use the 5.1 with SPDIF with it,
browsing http://www.mail-archive.com/alsa-devel%40lists.sourceforge.net
I didn't really found whether it's possible to use 5.1 SPDIF with it?

What is working is: I can play sound using aplay, and I hear them with
my SPDIF connection, also playing a dvd with mplayer and using -ao oss
also works, not with -ao alsa9 (and I am using devfs, so the device
shouldn't be the problem).
Using the analog ouptut, I could also heard the sound from the CD, but I
can't hear my CD from the SPDIF...

I have tried kernel 2.4.20 with alsa-0.9.0-rc7 and with CVS, and also
2.5.59 with native kernel alsa modules.

Trying ac3play gives me:

greg@localhost:~ >/usr/src/ac3play-0.5.2f/ac3play /data/linux/dvb/from_be=
yond_the_edge_44k_256kbps.ac3
ac3play: Unable to update the IEC958 control: No such file or directory
ac3play: Period size not available: Invalid argument
Segmentation fault
Exit 139

[root@localhost ~]# cat /proc/asound/devices=20
  0: [0- 0]: ctl
  8: [0- 0]: raw midi
 18: [0- 2]: digital audio playback
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer
 33:       : timer

All I want to be able to do, is to play DVD in 5.1 and using VDR
(http://www.cadsoft.de/people/kls/vdr) with the AC3 bitstreamout plugin
(http://bitstreamout.sourceforge.net/) to watch TV with 5.1...

Any idea on what I should do?

Thank you very much for all info,

	Gr=E9goire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
