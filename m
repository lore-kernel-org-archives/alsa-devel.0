From: Jochem Wichers Hoeth <wiho-alsa@wihome.net>
Subject: Duplicate configuration nodes
Date: Mon, 7 Sep 2009 16:43:58 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909071607400.15189@wihome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.gn.mail.iss.as9143.net (smtpq1.gn.mail.iss.as9143.net
	[212.54.34.164]) by alsa0.perex.cz (Postfix) with ESMTP id B6D362439F
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 16:44:01 +0200 (CEST)
Received: from [212.54.34.144] (helo=smtp13.gn.mail.iss.as9143.net)
	by smtpq1.gn.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <wiho-alsa@wihome.net>) id 1MkfRo-0007VM-N1
	for alsa-devel@alsa-project.org; Mon, 07 Sep 2009 16:44:00 +0200
Received: from 53519392.cable.casema.nl ([83.81.147.146] helo=mail.wihome.net)
	by smtp13.gn.mail.iss.as9143.net with esmtp (Exim 4.69)
	(envelope-from <wiho-alsa@wihome.net>) id 1MkfRn-0007G2-VG
	for alsa-devel@alsa-project.org; Mon, 07 Sep 2009 16:44:00 +0200
Received: from mail.wihome.net (localhost.localdomain [127.0.0.1])
	by mail.wihome.net (Postfix) with ESMTP id D8268C022
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 16:43:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.wihome.net (Postfix) with ESMTP id 3B271C022
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Sep 2009 16:43:58 +0200 (CEST)
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

Since I upgraded from alsa-lib 1.0.20 to 1.0.21 my configuration is not 
parsed correctly anymore:

$ aplay test.wav 
ALSA lib conf.c:4639:(snd_config_expand) Expand error (walk): File exists
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono

As a result of this error, ALSA seems to ignore the second half of 
HDA-Intel.conf, including the iec958 definition.

I traced the "File exists" error back to snd_config_add() returning 
-EEXIST, while evaluating the "strings" node at line 36 of 
cards/HDA-Intel.conf. I verified that at that point the src node indeed 
has four children: two duplicates of each child node of the original 
strings array.

I'm not exactly sure what's happening here, but I do see that the 
HDA-Intel.conf file (and all of its included files) are actually read 
*twice* by aplay. With alsa-lib 1.0.20 aplay only reads these files once.

The problem seems to be related to commit 
96da0c842d14b40ce8e37726b259229634b3aa21 ("Fix driver conf parsing in 
snd_config_hook_load_for_all_cards()"), which subtly changes the logic 
when the same driver is encountered for the second time. I have two cards 
using the HDA-Intel config (one analog and one digital). For the first 
card, the config is loaded without issues. But for the second card, 
snd_config_search(root, fdriver, &n) succeeds but snd_config_get_string(n, 
&driver) fails. In 1.0.20 this results in a "goto __err", skipping the 
actual config load. But in 1.0.21 this results in the else-branch being 
chosen (driver = fdriver) and next snd_config_hook_load being called.

I know too little of the entire config loading process to be sure what 
exactly is going wrong here, but a assume that the second call to 
snd_config_hook_load for the same configaration file somehow 
eventually results in the duplicate node error in snd_config_add().

I've verified that reverting 96da0c842d14b40ce8e37726b259229634b3aa21 
fixes the problem, or at least the symptoms. :-)

Please let me know if you need extra information, of if you'd like me to 
do some more testing.

Cheers,
Jochem Wichers Hoeth
