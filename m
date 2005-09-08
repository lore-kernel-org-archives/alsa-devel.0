From: "Boenn G (Elec)" <gboenn@glam.ac.uk>
Subject: vxpocket
Date: Thu, 8 Sep 2005 17:00:34 +0100
Message-ID: <0BA7EE4D4646E0409D458D347C508B78286AA5@MAILSERV1.uni.glam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
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

Hi guys,

i am having trouble with getting a vxpocket v2 card to work with the
planet.ccrma distro 2.6.11_0.3.rdt.rhfc3.ccrma

added this to /etc/pcmcia/config:

  device "snd-vxpocket"
     class "audio" module "snd-vxpocket"

  card "Digigram VX-POCKET"
    manfid 0x01f1, 0x0100
    bind "snd-vxpocket"

and in /etc/modprobe.conf:

alias snd-card-2 snd-vxpocket
alias sound-slot-2 snd-vxpocket
options snd-card-2 index=3D2
post-install snd-vxpocket /usr/bin/vxloader

, but sadly the vxloader never finds the card, can't see it with lspci.

the line=20

post-install snd-vxpocket /usr/bin/vxloader

creates a "bad line, ignored" error at startup. executing it later in
the shell gives "no VX-compatible cards found".

i can see with lsmod that the snd_vx-modules are there.

Any ideas what is going wrong?

Georg


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
