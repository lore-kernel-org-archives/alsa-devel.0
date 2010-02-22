From: Jaroslav Kysela <perex@perex.cz>
Subject: alsa-compile.sh - easy testing of latest ALSA code
Date: Mon, 22 Feb 2010 17:37:29 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002221725120.28127@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C7BE10384E
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 17:37:30 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi all,

 	I'm instroducing a new bash script - alsa-compile.sh - to allow 
easy testing of new ALSA code by all users using standard Linux 
desktop distributions. For example to get latest driver snapshot from 
www.alsa-project.org, compile it and insert new kernel modules, just type:

  wget -O alsa-compile.sh http://www.alsa-project.org/alsa-compile.sh
  chmod 755 alsa-compile.sh
  ./alsa-compile.sh --driver --kmodules

More information are available using --help option.
More examples are available using --examples option.

Actually, Fedora and openSUSE distributions are supported. Please, 
send patches extending functionality for other distributions to this list 
or directly to me.

Takashi, you might want to add support (option) for your driver tarballs. 
It would be probably a good idea to create a link to latest tarball in 
your web directory.

Please, send ideas, bugs, patches and any other issues to this list.

 					Thanks,
 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
