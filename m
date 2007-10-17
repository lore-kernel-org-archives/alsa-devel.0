From: Trent Piepho <xyzzy@speakeasy.org>
Subject: [patch] Fix bug with bt87x driver's load_all option
Date: Wed, 17 Oct 2007 15:55:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0710171553210.16052@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.sea5.speakeasy.net (mail3.sea5.speakeasy.net
	[69.17.117.5]) by alsa0.perex.cz (Postfix) with ESMTP id 04F5924469
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Oct 2007 00:55:56 +0200 (CEST)
Received: from shell4.sea5.speakeasy.net ([69.17.116.5])
	(envelope-sender <xyzzy@speakeasy.org>)
	by mail3.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted
	SMTP for <alsa-devel@alsa-project.org>; 17 Oct 2007 22:55:54 -0000
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

snd-bt87x: Make the load_all option work correctly

If the load_all option was turned on all cards would be treated as unknown,
even those which are in the database.  Of course, if the card is in the
database there is no reason to use the load_all option.  It's there to force
loading when the card isn't in the database.  But there are out of date wikis
that say to do this and some distros might turn this option on by default.

So, we keep the load_all option from turning known cards into unknown cards.

Signed-off-by: Trent Piepho <xyzzy@speakeasy.org>

diff --git a/pci/bt87x.c b/pci/bt87x.c
--- a/pci/bt87x.c
+++ b/pci/bt87x.c
@@ -1021,7 +1021,7 @@ static int __devinit snd_bt87x_detect_ca
 	int i;
 	const struct pci_device_id *supported;

-	supported = pci_match_device(&driver, pci);
+	supported = pci_match_id(snd_bt87x_ids, pci);
 	if (supported && supported->driver_data > 0)
 		return supported->driver_data;
