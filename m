From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: ascenario: Second batch
Date: Thu,  8 Oct 2009 17:29:16 +0200
Message-ID: <1255015758-4269-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CDD72412E
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 17:29:25 +0200 (CEST)
Received: from p5b03540e.dip.t-dialin.net ([91.3.84.14] helo=excalibur)
	by sirius.lasnet.de with esmtpsa
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 #1)
	id 1Mvuvi-000645-0x by authid <stefan@sostec.de> with cram_md5
	for <alsa-devel@alsa-project.org>; Thu, 08 Oct 2009 17:29:24 +0200
Received: from stefan by excalibur with local (Exim 4.69)
	(envelope-from <stefan@excalibur.local>) id 1Mvuvh-00017d-V0
	for alsa-devel@alsa-project.org; Thu, 08 Oct 2009 17:29:22 +0200
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

Hello.

Two more patches for ascenario. To be applied on top of the batch from
yesterday.

[PATCH 1/2] ascenario: Bring back a bugfix and config token change from latest ascenario

That one got missed as Jaroslav applied the initial ascenario patch. There was a
later one which added this changes.

[PATCH 2/2] ascenario: Reduce SND_SCN_* defines to the basics.

I still need feedback here how you guys want to handle the defines. Could be
seen as an RFC if you like.

For the better part of the day I'm looking into some bug regarding the
control_id fucntion. Hopefully another fix I can submit tomorrow.

regards
Stefan Schmidt
