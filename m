From: Ptitjes <ptitjes@free.fr>
Subject: RME HDSP driver enhancements for HDSPe cards
Date: Wed, 17 Oct 2007 11:22:20 +0200
Message-ID: <4715D44C.10407@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp25.orange.fr (smtp25.orange.fr [193.252.22.23])
	by alsa0.perex.cz (Postfix) with ESMTP id 7427624544
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 11:22:49 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2508.orange.fr (SMTP Server) with ESMTP id A65CF1C00099
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 11:22:48 +0200 (CEST)
Received: from [10.0.1.12] (AVelizy-154-1-99-147.w90-2.abo.wanadoo.fr
	[90.2.57.147])
	by mwinf2508.orange.fr (SMTP Server) with ESMTP id 3406A1C00095
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 11:22:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

First, sorry for the cross-post, but as i did not know where to start, i
wanted to ask to both lists.

I bought a RME HDSPe PCI card. I should receive it in the following
days. My plan is to:

1) Determine whether the current driver works as is with the HDSPe cards
and make my report to both lists.

2) Enhance the current driver in order to take profit of the new feature
(32bit float format)

However, i am new to Alsa, Jack and HDSP driver internal code structure.
So i wanted to collect informations and hints as where to start from and
be the most efficient in starting the work as i can.

Could you please give me links as to:
- - General Alsa driver structure and data flow
- - Work done by Alsa HDSP driver and work done by Jack (I ever thought
most of the work is done by Jack as my current HDSP PCCard do not work
with Alsa only)
- - Parts of the Alsa HDSP driver that would a priori need changes.
- - Parts of Jack that would a priori need changes.

Thank you very much for your help.
I hope i did not bother everyone with my newbie questions.

Best regards,
Didier.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHFdRLVE1mALQL3JsRAvp1AKCV7L7DdX1doenajmXFX8vnYkbbqQCgkbuS
GZgsAKdtGyiwfP4vNYYdZb4=
=vvgU
-----END PGP SIGNATURE-----
