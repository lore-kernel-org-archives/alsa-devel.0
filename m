From: Timur Tabi <timur@freescale.com>
Subject: Question about snd_pcm_update_hw_ptr_post()
Date: Mon, 03 Mar 2008 14:42:45 -0600
Message-ID: <47CC62C5.5010308@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4845024390
	for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2008 21:42:50 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m23KgkeN025959
	for <alsa-devel@alsa-project.org>; Mon, 3 Mar 2008 13:42:47 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m23KgkCm001880
	for <alsa-devel@alsa-project.org>; Mon, 3 Mar 2008 14:42:46 -0600 (CST)
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

Can someone explain to me this snippet from snd_pcm_update_hw_ptr_post():

if (avail >= runtime->stop_threshold) {
	if (substream->runtime->status->state == SNDRV_PCM_STATE_DRAINING)
		snd_pcm_drain_done(substream);
	else
		xrun(substream);
	return -EPIPE;
}

During playback, avail = snd_pcm_playback_avail().  Does this mean that avail is
number of frames available in the playback DMA buffer for new data?

If so, why is avail >= runtime->stop_threshold considered an underrun condition?
 Does ALSA try to keep the amount of available data to a minimum?

If so, how can I adjust runtime->stop_threshold?  I'd like to see what happens
if I make stop_threshold equal to the size of my DMA buffer.

-- 
Timur Tabi
Linux kernel developer at Freescale
