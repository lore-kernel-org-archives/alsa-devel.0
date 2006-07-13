From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001598]: TeamSpeak works with kernel
	mode OSS emulation but not with AOSS wrapper
Date: Thu, 13 Jul 2006 03:11:36 +0200
Message-ID: <c4f6f251de7686e28267b971e0218f9f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 691FB18C
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Jul 2006 03:11:36 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1598> =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                kyromaster
Assigned To:                =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Issue ID:                   1598
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               =

Kernel Version:             =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             11-25-2005 14:10 CET
Last Modified:              07-13-2006 03:11 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    TeamSpeak works with kernel mode OSS emulation =
but
not with AOSS wrapper
Description: =

At first this is a device independant issue. I looked at some forums and
tested it on several sound devices.
TeamSpeak works fine with the kernel OSS emulation on my system. But when
I use the AOSS wrapper to run it beside games which use ALSA (which is the
most common use of TeamSpeak) sound recording/output doesn=B4t work any
more. There=B4s a "test mode" in TS where you can hear yourself, when I
enable it I can=B4t hear anything.
Please fix this as it=B4s very important for all Linux gamers.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 divinehawk - 04-03-06 03:04 =

----------------------------------------------------------------------
The current DEBUG output I get with alsa-oss 1.0.11_rc3 and TeamSpeak is"

Opened PCM dsp0 for stream 0 (result =3D -2)
Opened PCM default for stream 0 (result =3D 0)
Opened PCM default for stream 1 (result =3D 0)
open("/dev/dsp", 2, -1210431528) -> 19
ioctl(19, SNDCTL_DSP_RESET)
ioctl(19, SNDCTL_DSP_SETDUPLEX)
ioctl(19, SNDCTL_DSP_GETCAPS, 0xb4aff158) -> [13056]
ioctl(19, SNDCTL_DSP_SETFRAGMENT, 0xb4aff15c[3000c])
dsp ioctl error =3D -22
close(19) -> 0

To fix/workaround this, I applied the following patch:

--- pcm.c       2005-09-01 13:32:52.000000000 -0400
+++ /root/alsa-oss-1.0.11rc3/alsa/pcm.c 2006-04-02 20:57:29.233826670
-0400
@@ -262,7 +262,7 @@
                        err =3D snd_pcm_hw_params_set_access(pcm, hw,
SND_PCM_ACCESS_RW_INTERLEAVED);
                        if (err < 0)
                                return err;
-                       periods_min =3D 2;
+                       periods_min =3D 16;
                        err =3D snd_pcm_hw_params_set_periods_min(pcm, hw,
&periods_min, 0);
                        if (err < 0)
                                return err;

I am not sure why it works... but hopefully it may lead to a real fix,
rather than a workaround.

----------------------------------------------------------------------
 Raymond - 07-13-06 03:11 =

----------------------------------------------------------------------
The OSS enumeration still depends on hardware, espcially for capturing
since some of the cards still not configured use dsnoop

Issue History
Date Modified  Username       Field                    Change              =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
11-25-05 14:10 kyromaster     New Issue                                    =

04-03-06 03:04 divinehawk     Note Added: 0009080                          =

04-03-06 03:04 divinehawk     Note Added: 0009081                          =

04-03-06 03:05 divinehawk     Note Deleted: 0009081                        =

04-03-06 03:05 divinehawk     Issue Monitored: divinehawk                  =
  =

07-13-06 03:11 Raymond        Note Added: 0010987                          =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
