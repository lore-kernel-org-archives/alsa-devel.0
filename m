From: Chris Rankin <rankincj@yahoo.com>
Subject: ALSA driver 1.10.0 and Linux 2.4.32 - a few problems
Date: Mon, 21 Nov 2005 13:01:44 +0000 (GMT)
Message-ID: <20051121130144.32425.qmail@web52901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

I tried building the ALSA 1.0.10 driver against 2.4.32 over the weekend. =
Unfortunately the build
broke, saying that it couldn't find the <linux/bitmask.h> header. I'm gue=
ssing that this header
file is specific to Linux 2.6.

Also, I noticed that the 1.0.10 version of alsa-lib is prone to seg-fault=
 if the "audio" group is
not defined in /etc/group. (I was using the ALSA sound driver in Wine 0.9=
.1 at the time, via
winecfg.)

Cheers,
Chris



	=09
___________________________________________________________=20
To help you stay safe and secure online, we've developed the all new Yaho=
o! Security Centre. http://uk.security.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=3D7628&alloc_id=3D16845&op=3Dclick
