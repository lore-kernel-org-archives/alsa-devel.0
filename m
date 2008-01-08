From: Jaroslav Kysela <perex@perex.cz>
Subject: Driver - PCM MMAP mode timestamps
Date: Tue, 8 Jan 2008 10:45:34 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801081031240.22730@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FC2D24ACC
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 10:45:35 +0100 (CET)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	5E1C2149EE9
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 10:45:35 +0100 (CET)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	A09F784364
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 10:45:34 +0100 (CET)
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

Hi,

	it seems that we have another inconsistency with PCM MMAP mode
timestamps. If I read code correctly, snd_pcm_status() returns timestamp 
from last interrupt BUT updates hw_ptr to current (calling 
snd_pcm_update_hw_ptr() again).
	It means, that application will get unrelated timestamp to 
hw position returned in snd_pcm_status() in case of mmap mode. I don't see 
any way to use this timestamp now.
	To fix this issue, I would like to create a next status ioctl 
which will return only mmap timestamp plus last related interrupt ring 
buffer position and remove 'if (runtime->tstamp_mode == 
SNDRV_PCM_TSTAMP_MMAP)' condition from snd_pcm_status() in driver 
completely.
	Any opinion? Other idea?

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
