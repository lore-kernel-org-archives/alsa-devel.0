From: Chris Rankin <rankincj@yahoo.com>
Subject: Linux 2.6.14: Total lockup using aplaymidi
Date: Sat, 29 Oct 2005 00:33:21 +0100 (BST)
Message-ID: <20051028233321.64683.qmail@web52909.mail.yahoo.com>
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

I've just installed Linux 2.6.14-SMP with ALSA 1.0.10rc1 on my UP PIII ma=
chine, and I've found
that:

$ aplaymidi -p 65:0 <midifile>

immediately locks my machine up hard. This machine has a "SB-Live! 5.1 Ga=
mer" sound card, and the
PCM driver seems to be OK. I don't get an Oops on the serial console, and=
 so I'm suspecting a
dead-lock somewhere. 30 seconds later, the watchdog driver forces a reboo=
t.

I have also tried this kernel with ALSA 1.0.10rc2 CVS, with exactly the s=
ame results.

Cheers,
Chris



=09
=09
	=09
___________________________________________________________=20
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voic=
email http://uk.messenger.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
