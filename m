From: James Courtier-Dutton <James@superbug.co.uk>
Subject: SPDIF rate setting.
Date: Fri, 17 Sep 2004 21:00:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <414B4245.50600@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6EEB1224
	for <alsa-devel@alsa-project.org>; Fri, 17 Sep 2004 22:00:06 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-35.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1C8Otp-000DP0-0Z
	for alsa-devel@alsa-project.org; Fri, 17 Sep 2004 20:00:05 +0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

It seems that more and more people are using SPDIF digital output at 
44.1khz. E.g. DTS tracks on CDs.
Currently, people are having to manually change the SPDIF rate setting 
using iecset or the application is having to play with AES3 in the 
"iec958:AES..." at device open.
How about, when someone opened the device "iec958" and then uses 
snd_pcm_hw_params_set_rate(), it should automatically set the iecset 
rate to equal the rate set by the set_rate function call.

Any comments?

James


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
