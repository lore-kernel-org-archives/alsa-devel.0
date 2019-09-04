From: "Philipp Kindt" <pkindt@directbox.com>
Subject: snd-hda-intel: autoconfig failure
Date: Fri, 28 Oct 2005 22:26:06
Message-ID: <147407D50A1C141A063E0@directbox.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Hi there,

i've just got the ASUS W1Vc Laptop. After problems (sound did not work), =
i compiled
ALSA 1.0.10rc2. The module can now be loaded in the kernel, and sound wor=
ks.
But the headphones don't. If i probe model=3D6stack-digout, the headphone=
 port works fine.

lspci -nv says about the audio controller:

0000:02:02.0 0480: 1131:7133 (rev d1)
Subsystem: 1461:f636
Flags: bus master, medium devsel, latency 64, IRQ 23
Memory at feafa000 (32-bit, non-prefetchable) [size=3D2K]

Thanks a lot for writing ALSA

Philipp Kindt

P.S.: If you wish to contact me, DO NOT write to the mailing list. I have=
 not subscribed.





-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
