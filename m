From: Chris Rankin <rankincj@yahoo.com>
Subject: Unresolved symbol in snd-cs4231-lib, CVS and Linux 2.4.29
Date: Sat, 12 Mar 2005 19:38:18 +0000 (GMT)
Message-ID: <20050312193818.3343.qmail@web52901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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

I have just recompiled my ALSA drivers from CVS, and found this error:

depmod: *** Unresolved symbols in /lib/modules/2.4.29/kernel/drivers/soun=
d/snd-cs4231-lib.o
depmod:         snd_card_set_generic_pm_callback

I was compiling the snd-sscape driver: does this driver need to set the C=
ONFIG_SND_GENERIC_PM
#define in the configure script?

Cheers,
Chris


Send instant messages to your online friends http://uk.messenger.yahoo.co=
m=20


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
