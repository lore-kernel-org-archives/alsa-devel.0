From: Jaroslav Kysela <perex@perex.cz>
Subject: alsactl init - next round
Date: Mon, 18 Aug 2008 17:30:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0808181706320.21669@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 90B3124456
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 17:30:30 +0200 (CEST)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	804C7149E11 for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 17:30:30 +0200 (CEST)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	6B61084378 for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 17:30:30 +0200 (CEST)
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

	The 'alsactl init' command becomes more powerful now.

- support for dB
- better support for enumerated controls
- better "ready to use" udev support, expected use:
    RUN="/usr/sbin/alsactl -r /var/run/alsactl.init restore $name"
- initialization using a guess method - the init/default configuration
    mostly copied from the alsaconf script, see
    http://git.alsa-project.org/?p=alsa-utils.git;a=blob_plain;f=alsactl/init/default;hb=HEAD

The cardinfo database is slowly filling. We have over 120 files there now. 
Any volunteer for watching of these files and writting a suitable 
configuration files for 'alsactl init' here?

I'm not sure about the initialization procedure. I selected the method - 
look to database and if not found - use the default "guess" method 
(without any warranty). But the opposite way is also possible - do a 
universal initialization and modify only special parameters for specific 
hardware.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
