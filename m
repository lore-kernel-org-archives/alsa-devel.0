From: iain <iain@prettypeople.org>
Subject: Problems with OSS Emulation
Date: Wed, 05 Nov 2003 14:15:17 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1068041717.2963.54.camel@discomachinegun.prettypeople.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from polyethylene.prettypeople.org (userm043.dsl.pipex.com [62.188.60.43])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA22888
	for <alsa-devel@alsa-project.org>; Wed, 5 Nov 2003 15:12:48 +0100
Received: from discomachinegun.prettypeople.org (discomachinegun.prettypeople.org [62.188.60.41])
	by polyethylene.prettypeople.org (Postfix) with ESMTP id 686748331
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2003 14:06:57 +0000 (GMT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

My system is linux-2.6.0-test9, CVS alsa kernel from 3rd November, CVS
alsa-lib from 5th November and an Extigy soundcard using usb-audio
driver

When I try to play anything using OSS Emulation I get no sound and the
program instantly locks up.  

ohci_hcd 0000:00:02.0: bad entry 37b80640 is then printed to dmesg.
Previously, I could get sound from OSS Emulation until there was a high
CPU load, and then it would lock up, but now it locks up imediatly.

Any ideas?
iain
-- 
"Miss Celine Dion sings lovesongs while our cities burn"



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
