From: David Henningsson <david.henningsson@canonical.com>
Subject: via_dmapos_patch
Date: Wed, 29 Sep 2010 10:14:49 +0200
Message-ID: <4CA2F579.201@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id B959A1038B8
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 10:14:54 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1P0roQ-0005If-UP
	for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2010 09:14:50 +0100
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1P0roQ-00071B-RQ
	for alsa-devel@alsa-project.org; Wed, 29 Sep 2010 09:14:50 +0100
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

I'm researching a few bugs where the user claims position_fix=1 helps 
the problem, but adding the quirk for that model surprisingly didn't. So 
looking at the code, I concluded that the difference was 
via_dmapos_patch, and that they all had via_dmapos_patch=1, and that 
via_dmapos_patch=0 helped them solve the problem. Three out of five (not 
all of them have reported back on via_dmapos_patch=0 yet) are VIA 
controllers rev 10.

So we now have VIA controllers that need via_dmapos_patch=0.

I can think of a few approaches here:

1) since position_fix=1 implicitly sets via_dmapos_patch to 0 (maybe 
unintentionally), we should add a position_fix=3 meaning lpib + 
via_dmapos_patch=1

2) figure if something has changed recently (as in "within the last 
year"...) that has made via_dmapos_patch=1 work worse than before

3) figure out if there are several ATI/VIA controllers that actually 
never wants the patch.

Any thoughts?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
