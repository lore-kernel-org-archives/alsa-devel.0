From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: ascenario: Last batch of fixes.
Date: Fri,  9 Oct 2009 17:53:28 +0200
Message-ID: <1255103612-11134-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 34F38103B3E
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 17:53:44 +0200 (CEST)
Received: from p5b035445.dip.t-dialin.net ([91.3.84.69] helo=excalibur)
	by sirius.lasnet.de with esmtpsa
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 #1)
	id 1MwHmh-0006dx-PF by authid <stefan@sostec.de> with cram_md5
	for <alsa-devel@alsa-project.org>; Fri, 09 Oct 2009 17:53:38 +0200
Received: from stefan by excalibur with local (Exim 4.69)
	(envelope-from <stefan@excalibur.local>) id 1MwHmg-0002uV-E5
	for alsa-devel@alsa-project.org; Fri, 09 Oct 2009 17:53:34 +0200
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

This is the last set of fixes I have in my queue.

[PATCH 1/3] ascenario: Add check for set scenario in snd_scenario_get_control_id()
Debugged some hours that I should test it after _set() and not only after
_list(). Better let the user know that no scenario is set instead of silently
using a non existing scenario and fail.

[PATCH 2/3] ascenario: Convert last sprintf() to snprintf()
Some more sprintf() replaced with the more secure snprintf().

[PATCH 3/3] ascenario: Make sequences unique for every scenario.
That one actually got me some grey hairs. I'm pretty sure I tested it earlier
and it worked as it should, but I can find now traces of this. Fixed for good
now.

[PATCH] ascenario: Add dump and configure utils for ascneario.
Reference patch against alsa-utils for some small utilities using the new
scenario API. Only change from the last time is that _dump() now has two
parameters even if the new one is still unused.

regards
Stefan Schmidt
