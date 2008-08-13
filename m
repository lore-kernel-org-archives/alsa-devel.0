From: Tobias Kaefer <Tobias.Kaefer@abas.de>
Subject: sound-problems with ALC262
Date: Wed, 13 Aug 2008 08:07:37 +0200
Message-ID: <48A27A29.4010604@abas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.abas.de (gate.abas.de [212.202.226.200])
	by alsa0.perex.cz (Postfix) with ESMTP id A92B72442E
	for <Alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 08:07:43 +0200 (CEST)
Received: from gate.abas.de (localhost [127.0.0.1])
	by gate.abas.de (8.14.0/8.14.0) with ESMTP id m7D67hFJ031983
	for <Alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 08:07:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

I posted a message at alsa-user list just yesterday about my problem
with the on-board ALC262 on my workstation, see mailings lists archive:
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg23236.html

Quote from my initial post:
| I just got a new workstation. It's an Fujitsu-Siemens Esprimo P5625
| with an on-board ALC262 sound chip. I'm running a Kubuntu 8.04.1 on
| that system.
|
| The sound I get from that chip is really horrible. There are
| cracks and some kind of a reverberation in there.
|
| I compiled the recent version of alsa (1.0.17) and I tried all the
| model-options for /etc/modprobe.d/alsa-base.

"stan" told me to use this script
http://www.alsa-project.org/alsa-info.sh  to create more information
about my system. Here is the pastebin link of the output of that script:
http://pastebin.ca/1169153

Maybe I can help evolve the snd-hda-intel by being a tester.
Unfortunately my kernel-hacking skills are as rusty as my C skills -
because of being a Java developer for some years now.

Greets
Tobias

- --
Mit freundlichen Gruessen / with kind regards

Tobias S. K=E4fer

Tobias S. Kaefer * Portal-Development
ABAS Software AG, Suedendstrasse 42, 76135 Karlsruhe, GERMANY
Fon: +49 721 967 23 0, Fax: +49 721 967 23 100
Managing board / Vorstand: Werner Strub (CEO, Vorsitzender), Peter Walser
Chairman supervisory board / Aufsichtsratsvorsitzender: Thomas Frank
Company Register / Handelsregister: HRB 107644 Amtsgericht Mannheim
please visit our homepage / Bitte besuchen Sie unsere Homepage:
http://www.abas.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIonopdJJ1JNEzpd0RAhCIAJ4lvvOwzQAhV3vtA2u7ilwtlBQPlQCgupns
63R7vjvwbY6O3QUEeNwdEO0=3D
=3DFxwe
-----END PGP SIGNATURE-----
