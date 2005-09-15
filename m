From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Problems with multiple simultaneous ac97 quirks
Date: Thu, 15 Sep 2005 19:04:15 +0100
Message-ID: <20050915180415.GA24705@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vavatch.codon.org.uk (cavan.codon.org.uk [217.147.92.49])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D58B6184
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 20:04:16 +0200 (MEST)
Received: from mjg59 by vavatch.codon.org.uk with local (Exim 4.50)
	id 1EFy5n-0006aN-C1
	for alsa-devel@alsa-project.org; Thu, 15 Sep 2005 19:04:15 +0100
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Lots of current HP hardware would benefit from both AC97_TUNE_MUTE_LED 
and AC97_TUNE_HP_ONLY. However, this is made difficult by the fact that 
both of these options set the master volume switch put function to their 
own one. This is easy enough to work around by adding another quirk, 
but that would soon lead to combinatorial explosion. What's the best 
approach to being able to add multiple interacting quirks?

-- 
Matthew Garrett | mjg59@srcf.ucam.org


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
