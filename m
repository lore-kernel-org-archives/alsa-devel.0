From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: [PATCH] port pcxhr driver do devres
Date: Sun, 21 Sep 2008 17:31:39 +0200
Message-ID: <200809211731.58934.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8054411568425530444=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sf-mail.de (mail.sf-mail.de [62.27.20.61])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C262243F5
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Sep 2008 09:40:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============8054411568425530444==
Content-Type: multipart/signed;
  boundary="nextPart2955432.mpvDHf4Mco";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2955432.mpvDHf4Mco
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

=2D--
I was a bit bored and ported the pcxhr driver to use devres to manage it's
IRQ and PCI resources. This is completely untested as I don't have such a
card but you might find it useful nevertheless.

commit e7df0303a1517bdd0d2f0af5fbdf91acc0b7f426
tree 45fbf9c75c8ea51ae89f0409ed02138380b71624
parent 9824b8f11373b0df806c135a342da9319ef1d893
author Rolf Eike Beer <eike-kernel@sf-tec.de> Sun, 21 Sep 2008 17:26:28 +02=
00
committer Rolf Eike Beer <eike-kernel@sf-tec.de> Sun, 21 Sep 2008 17:26:28 =
+0200

 sound/pci/pcxhr/pcxhr.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index 2c7e253..676389e 100644
=2D-- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1171,12 +1171,6 @@ static int pcxhr_free(struct pcxhr_mgr *mgr)
 		snd_printdd("reset pcxhr !\n");
 	}
=20
=2D	/* release irq  */
=2D	if (mgr->irq >=3D 0)
=2D		free_irq(mgr->irq, mgr);
=2D
=2D	pci_release_regions(mgr->pci);
=2D
 	/* free hostport purgebuffer */
 	if (mgr->hostport.area) {
 		snd_dma_free_pages(&mgr->hostport);
@@ -1185,7 +1179,6 @@ static int pcxhr_free(struct pcxhr_mgr *mgr)
=20
 	kfree(mgr->prmh);
=20
=2D	pci_disable_device(mgr->pci);
 	kfree(mgr);
 	return 0;
 }
@@ -1210,21 +1203,19 @@ static int __devinit pcxhr_probe(struct pci_dev *pc=
i, const struct pci_device_id
 	}
=20
 	/* enable PCI device */
=2D	if ((err =3D pci_enable_device(pci)) < 0)
+	if ((err =3D pcim_enable_device(pci)) < 0)
 		return err;
 	pci_set_master(pci);
=20
 	/* check if we can restrict PCI DMA transfers to 32 bits */
 	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 32bit PCI busmaster D=
MA\n");
=2D		pci_disable_device(pci);
 		return -ENXIO;
 	}
=20
 	/* alloc card manager */
 	mgr =3D kzalloc(sizeof(*mgr), GFP_KERNEL);
 	if (! mgr) {
=2D		pci_disable_device(pci);
 		return -ENOMEM;
 	}
=20
@@ -1238,7 +1229,6 @@ static int __devinit pcxhr_probe(struct pci_dev *pci,=
 const struct pci_device_id
 	/* resource assignment */
 	if ((err =3D pci_request_regions(pci, card_name)) < 0) {
 		kfree(mgr);
=2D		pci_disable_device(pci);
 		return err;
 	}
 	for (i =3D 0; i < 3; i++)
@@ -1247,7 +1237,7 @@ static int __devinit pcxhr_probe(struct pci_dev *pci,=
 const struct pci_device_id
 	mgr->pci =3D pci;
 	mgr->irq =3D -1;
=20
=2D	if (request_irq(pci->irq, pcxhr_interrupt, IRQF_SHARED,
+	if (devm_request_irq(&pci->dev, pci->irq, pcxhr_interrupt, IRQF_SHARED,
 			card_name, mgr)) {
 		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
 		pcxhr_free(mgr);

--nextPart2955432.mpvDHf4Mco
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjWaO4ACgkQXKSJPmm5/E4Q9ACglGoW/U5VRUvqxOju3/DsBCZ1
pIIAnRE8lwKS2ZpSksHvsxLu5TVfaDUN
=IyOx
-----END PGP SIGNATURE-----

--nextPart2955432.mpvDHf4Mco--

--===============8054411568425530444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8054411568425530444==--
