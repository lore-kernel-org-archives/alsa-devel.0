From: Chris Rankin <rankincj@yahoo.com>
Subject: CVS: Cannot capture via microphone with Audigy2 soundcard.
Date: Wed, 30 Mar 2005 03:04:15 +0100 (BST)
Message-ID: <20050330020415.49153.qmail@web52905.mail.yahoo.com>
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

[CVS ALSA, as of 30th March 2005. Linux 2.6.11-SMP]

Hi,

I have suddenly discovered that I can no longer capture via the Microphon=
e connected to my Audigy2
soundcard. (Yes, it *is* connected.) Gnomemeeting is now saying that my C=
apture device is:

Audigy 1 or 2 [Unknown]

However, this card is an Audigy2:

05:0d.0 Class 0401: 1102:0004 (rev 04)

My Microphone capture mixer setting is set to 100%. The following message=
 is appearing in my dmesg
log whenever I load the kernel module:

ACPI: PCI interrupt 0000:05:0d.0[A] -> GSI 21 (level, low) -> IRQ 21
ALSA /home/chris/Programs/alsa/alsa-driver/pci/emu10k1/../../alsa-kernel/=
pci/emu10k1/emufx.c:1385:
Installing spdif_bug patch: Audigy 1 or 2 [Unknown]
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17

Can anyone suggest what the problem might be, please? Playback is working=
 OK.

Cheers,
Chris


Send instant messages to your online friends http://uk.messenger.yahoo.co=
m=20


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
