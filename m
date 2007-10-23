From: Didier Villevalois <ptitjes@free.fr>
Subject: Re: [Jackit-devel] RME HDSPe floating point question
Date: Tue, 23 Oct 2007 11:41:14 +0200
Message-ID: <471DC1BA.1090502@free.fr>
References: <20070910193546.GA3202@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp25.orange.fr (smtp25.orange.fr [193.252.22.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 4CCC8249A8
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Oct 2007 11:41:40 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2529.orange.fr (SMTP Server) with ESMTP id 3E1DB1C00389
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Oct 2007 11:41:22 +0200 (CEST)
In-Reply-To: <20070910193546.GA3202@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa devel <alsa-devel@alsa-project.org>, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

(Cross-posting my report - last time i do this)

Great news (almost for me in anyways). RME HDSPe PCI *works as is* with
the current driver. Firmware uploads as well. I had nothing to do to
make it work! (I think the ExpressCard should work as well...)

Maybe the alsa-project wiki page can be updated.

Little by little in the next weeks, I will delve into the driver's code
to identify parts that needs to be enhanced in order to take profit of
the 32bit floating point format that the HDSPe card can provide. When
ready, I'll contact RME to request them for informations about the
activation of this mode.

Didier.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHHcG6VE1mALQL3JsRAjeZAKCJqicClHgy1UDc1YvAywuw1FokyQCeJO2d
BhWpkxL8xLGxKB3zmbWFQpk=
=wpbm
-----END PGP SIGNATURE-----
