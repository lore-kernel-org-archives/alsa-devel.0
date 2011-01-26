From: Jaroslav Kysela <perex@perex.cz>
Subject: hdspmixer
Date: Wed, 26 Jan 2011 10:49:51 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101261044110.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E334244E9
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 10:49:52 +0100 (CET)
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

 	working on new ALSA release, but it seems that 
alsa-tools/hdspmixer is out of sync with current 
linux/sound/hdsp.h / hdspm.h after this commit:

commit e24e56795ea57e3dd7da45063ab71f04e231192d
Author: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Date:   Sun Jan 9 19:42:59 2011 +0100

     Add support for RME MADI, RayDAT and AIO

     Merged the work by Florian Faber that's distributed separately as
     hdspmixer64.

     Code taken from 
http://wiki.linuxproaudio.org/index.php/App:hdspmixer_64

     Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
     Signed-off-by: Takashi Iwai <tiwai@suse.de>

 	Any clue what to do to get things fixed?

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
