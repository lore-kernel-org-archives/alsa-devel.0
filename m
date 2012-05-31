From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: HDA codec in embedded device
Date: Thu, 31 May 2012 08:13:02 +0200
Message-ID: <20120531061302.GA11605@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2192265767708610558=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by alsa0.perex.cz (Postfix) with ESMTP id BAD282436A
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 08:13:04 +0200 (CEST)
Received: from mailbox.adnet.avionic-design.de
	(add-virt-zarafa.adnet.avionic-design.de [172.20.129.9])
	by benhur.adnet.avionic-design.de (Postfix) with ESMTP id 682502C4112
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 08:13:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 727CC2A282AD
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 08:13:03 +0200 (CEST)
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
	by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id asRKDIae+ISi for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 08:13:02 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
	(Authenticated sender: thierry.reding)
	by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id
	9C4D62A2809D for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 08:13:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2192265767708610558==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I work on an Atom-based platform that uses a Realtek ALC892 codec connected
via HDA. The current code in patch_realtek.c seems to assume a standard
desktop setup and maps the ports accordingly. The setup that I have is
entirely different and involves, among other things, to reconfigure some of
the ports typically used as outputs as inputs and vice versa. It'll also need
to provide a way to pass through some inputs on the outputs without going
through the DAC.

All of these features are supported by the ALC982, but I don't see how this
could be implemented with the current driver. My question is how this could
possibly be solved in a way acceptable for mainline?

Thierry

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/HC+4ACgkQZ+BJyKLjJp/jEACeMYCV3wnkMqtSz9eTPhbYBPO9
GE8AnAxrlYErYFifWnRAhEYE+xrnZw82
=eUNh
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--===============2192265767708610558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2192265767708610558==--
