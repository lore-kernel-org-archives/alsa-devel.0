From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Subject: Problem with usb-audio introduced between 2.6.13 and 2.6.14-rc1
Date: Sun, 23 Oct 2005 00:13:25 +0200
Message-ID: <20051022221325.GA6852@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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
To: clemens@ladisch.de, perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I sent this to the LKML but forgot some CC:s, the thread is at:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D113001840929175&w=3D2

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

After updating the kernel on one of my computers today I discovered that=20
usb-audio via snd-pcm-oss over the snd-usb-audio ALSA drivers stopped=20
working (worked with 2.6.13, doesn't with 2.6.14-rc[12345]).

The weird part is that it only stopped working when using the driver=20
through the oss emulation and only for some programs. I've tried it with=20
all apps with native alsa support that I had installed, and all of them=20
worked. I also tried it with a few different apps with oss support, and=20
most of them worked (xine and mplayer) while one failed (mythmusic).

The symptoms is that no sound is heard while the app seems to believe=20
that everything is just fine. It also progresses through the song at=20
about 20x normal speed (i.e. it thinks its done playing a 4 minute song=20
after 12 seconds). The only difference I can come up with is that xine=20
and mplayer probably up-sample the audio to 48.000Hz while MythMusic=20
tries to play at 44.100Hz (the device is a TerraTec external USB <->=20
SPDIF interface).

I've used git's bisect command to try to find the exact problem, and it=20
seems to have been introduced by this commit:=09
7efd8bc800324a967a37e8a425433468b7f06adb
see also:
http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=3D7efd8bc800324a967a37e8a425433468b7f06adb

patch name: [ALSA] usb-audio: double-buffer all playback data

I'm not sure on how to fix it since the commit is quite big and cannot=20
be simply reversed with the current tree as there have been other=20
patches applied to the file afterwards. Comments/suggestions welcome...

Regards,
David H=E4rdeman
david (at) 2gen (dot) com

PS
Please CC me on any replies


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
