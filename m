From: Luke Yelavich <themuso@ubuntu.com>
Subject: Clarrification about the alsa volume init framework.
Date: Tue, 10 May 2011 08:48:33 +0200
Message-ID: <20110510064833.GB5736@acapella.yelavich.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C8481038BD
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 08:48:35 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112])
	by adelie.canonical.com with esmtp (Exim 4.71 #1 (Debian))
	id 1QJgkE-0003lp-JN
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2011 06:48:34 +0000
Received: from business-89-133-214-82.business.broadband.hu ([89.133.214.82]
	helo=localhost) by youngberry.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.71)
	(envelope-from <themuso@ubuntu.com>) id 1QJgkE-00030W-Es
	for alsa-devel@alsa-project.org; Tue, 10 May 2011 06:48:34 +0000
Content-Disposition: inline
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

Hi,
So I am looking at cleaning up Ubuntu's collection of volume init db data originally set up in Ubuntu's/Debian old big init script. The switch has already been made to the new init system, and any existing settings were migrated from our old init script to the new system, however this is somewhat unclean.

Is my understanding correct in that the new volume init system was designed to have quirks for hardware that needs particular volume settings? If so, how would upstream like these to be submitted, and would you want to have several dozen or more quirk files in the init db for different hardware? 
Thanks in advance.

Luke
