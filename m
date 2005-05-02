From: "Gary E. Miller" <gem@rellim.com>
Subject: ICH5 fails
Date: Mon, 2 May 2005 12:31:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0505021217480.6463@catbert.rellim.com>
References: <20050502211304.7ec976bd.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050502211304.7ec976bd.pochini@shiny.it>
Resent-To: Alsa-devel <alsa-devel@lists.sourceforge.net>
ReSent-Message-ID: <Pine.LNX.4.63.0505021234350.6463@catbert.rellim.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Yo All!

I have been trying to sign up gfor the bugzilla, but I keep getting
this message:

PROBLEMS SENDING MAIL TO:
Mailer Error: SMTP Error: Could not connect to SMTP host.

I any case, I have the same issue as bug #1078, except I have more info
on it.  I have laptops and desktops with the ICH5 sound subsystem.  They
all work fine up to 2.6.8.1.  Anything past that does not work.  I
figured I would just wait on it until someone fixed it.  Now I have
tested up to kernel 2.6.12-rc2 and from alsa driver 1.0.6 to 1.0.9rc2.
I have mixed and matched various alsa-driver and kernel versions with
no success.

Same problem.  My distro is a basic Slackware 10.0, except for the now
updated kerenels and gcc.  Same problem with older gcc's as well.

Sadly, I updated my gcc to 4.0 and can no longer compile 2.6.8.1 or
any alsa before 1.0.7.  So now I need this fixed.

It is not just me because I can google for other folks with the same
issue.

Here is what I get in dmesg when I load the failing modules:

Jan  7 20:04:09 satchel kernel: Advanced Linux Sound Architecture Driver Version
 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
Jan  7 20:04:09 satchel kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (l
evel, low) -> IRQ 17
Jan  7 20:04:09 satchel kernel: intel8x0_measure_ac97_clock: measured 49768 usec
s
Jan  7 20:04:09 satchel kernel: intel8x0: clocking to 48000
Jan  7 20:04:09 satchel kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (l
evel, low) -> IRQ 17
Jan  7 20:04:09 satchel kernel: ALSA device list:
Jan  7 20:04:09 satchel kernel:   #0: Intel ICH5 with unknown codec at 0xd0000c0
0, irq 17

Here is what I get when it works:
Jan  4 00:14:10 satchel kernel: Advanced Linux Sound Architecture Driver Version
 1.0.4 (Mon May 17 14:31:44 2004 UTC).
Jan  4 00:14:10 satchel kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (l
evel, low) -> IRQ 17
Jan  4 00:14:10 satchel kernel: intel8x0_measure_ac97_clock: measured 49918 usec
s
Jan  4 00:14:10 satchel kernel: intel8x0: clocking to 48000
Jan  4 00:14:10 satchel kernel: ACPI: PCI interrupt 0000:00:1f.6[B] -> GSI 17 (l
evel, low) -> IRQ 17
Jan  4 00:14:10 satchel kernel: ALSA device list:
Jan  4 00:14:10 satchel kernel:   #0: Intel ICH5 at 0xd0000c00, irq 17
Jan  4 00:14:10 satchel kernel:   #1: Intel ICH5 Modem at 0x1800, irq 17

Here is my "cards file:

# cat /proc/asound/cards
0 [ICH5           ]: ICH4 - Intel ICH5
                     Intel ICH5 with unknown codec at 0xd0000c00, irq 17

Any ideas?

RGDS
GARY
- ---------------------------------------------------------------------------
Gary E. Miller Rellim 20340 Empire Blvd, Suite E-3, Bend, OR 97701
	gem@rellim.com  Tel:+1(541)382-8588 Fax: +1(541)382-8676

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFCdoAb8KZibdeR3qURAt53AKDEM29B4jaRx7gM7V/w9XD2gpFpnQCdG4R0
VJ5EOHodhHKAGcLnop3Y3k4=
=fYUA
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
