From: Jaroslav Kysela <perex@perex.cz>
Subject: alsa-lib 1.0.21a release
Date: Wed, 9 Sep 2009 14:51:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0909091444530.12929@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8905D2442A
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 14:51:00 +0200 (CEST)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	8225A14996D for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 14:51:00 +0200 (CEST)
Received: from eeebox2.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	716BC8453F for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 14:51:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

 	I made a quick release 1.0.21a of the alsa-lib package to fix 
regression for the configuration parsing (makes some device names 
unavailable). These patches were included:

19abc37 PCM - Change the hw_params determination order
d1b70af Change dmix.conf to accept user configuration from
         defaults.dmix.<driver_id>.xxx
eb9ae58 Revert "Fix driver conf parsing in
         snd_config_hook_load_for_all_cards()"
f0a32a6 mixer: Add Speaker and Beep names to the weight list

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
