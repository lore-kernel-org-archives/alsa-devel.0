From: Jaroslav Kysela <perex@perex.cz>
Subject: snd_pcm_htimestamp & more PCM mmap timestamping in
	driver
Date: Wed, 9 Jan 2008 14:17:28 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801091350500.30240@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 676A924489
	for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2008 14:17:29 +0100 (CET)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	5B84A149E8B
	for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2008 14:17:29 +0100 (CET)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	494A884369
	for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2008 14:17:29 +0100 (CET)
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

Hi all,

	I just added snd_pcm_htimestamp() function to alsa-lib:

int snd_pcm_htimestamp(snd_pcm_t *pcm, snd_pcm_uframes_t *avail, 
		       snd_htimestamp_t *tstamp);

	If you have any complaints, please, do now.

	Also, I would like to change SNDRV_PCM_TSTAMP_MMAP semantics to 
SNDRV_PCM_TSTAMP_ENABLE - when hw_ptr is updated in the driver, a 
timestamp would be always grabbed to ensure that we have always a valid 
timestamp & position pair. In current implementation, if an application 
updates hw_ptr in driver (using for example PCM delay ioctl), timestamp 
grabbed in the interrupt handler won't be associated with any real ring 
buffer position which makes things complicated and not too much abstract. 
Opinions?

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
