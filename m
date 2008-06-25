From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: sw parameter boundary
Date: Wed, 25 Jun 2008 10:44:19 +0200
Message-ID: <48620563.3050207@aimvalley.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr10.xs4all.nl (smtp-vbr10.xs4all.nl [194.109.24.30])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B29A103828
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 10:44:30 +0200 (CEST)
Received: from mail3.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id m5P8iOrm046254
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 10:44:29 +0200 (CEST)
	(envelope-from nvbolhuis@aimvalley.nl)
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


is the boundary sw parameter still used ?
where is it for ?

in the PCM kernel core (e.g. snd_pcm_playback_avail) it clearly serves
as a pointers wrap point, but which one ?
The one at the end of the DMA buffer or the one at the end of a process
(virtual) address range (4 GB) ?




-- 
This message has been scanned for viruses and is believed to be clean
