From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Underrun problem and some basic queries
Date: Mon, 04 Jan 2010 11:09:53 +0000 (GMT)
Message-ID: <18229629.327131262603393053.JavaMail.weblogic@epml01>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 871E81037F2
	for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2010 12:09:56 +0100 (CET)
Received: from ep_ms13_bk (mailout3.samsung.com [203.254.224.33])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KVP004C9Z0H1E@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 04 Jan 2010 20:09:53 +0900 (KST)
Received: from ep_spt02 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KVP00GKBZ0H2C@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 04 Jan 2010 20:09:53 +0900 (KST)
Content-return: prohibited
MIME-version: 1.0
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Dear ALSA Team,
I have some queries.Please answer them.(previous post please ignore as they couldn't appear because of encoding problem)
I am getting underrun problem whenever the playback is about to get finished.
happening in snd_pcm_update_hw_ptr_post function:
if (avail >= stop_threshold) {
        if (substream->runtime->status->state == SNDRV_PCM_STATE_DRAINING)
            snd_pcm_drain_done(substream);
        else
            xrun(substream); //here it is happening..........
        return -EPIPE;
}
1. As i understand if i dont call drain function this will happen.Ismy understanding correct?Because if am calling drain function then thisproblem is not happening.If the application doesn't call drain functionthen xrun is the only way to stop ALSA or does ALSA detect that thereare no more samples to play and automatically stop the play(if yes,canyou point out the source code)?
2. snd_pcm_playback_avail() returns the number of samples that stillneeds to be played?Below is the diagram which is my understanding.
        
    Ring buffer (DMA buffer created using preallocated buffer during system initalisation)
-----------------------------------------------------------------
|          |          |          |          |          |          |
-----------------------------------------------------------------
    ^  ^            
    |   |
hw_ptr appl_ptr
After first write call:   
-----------------------------------------------------------------
|          |          |          |          |          |          |
-----------------------------------------------------------------
     ^                               ^            
     |                                |
 appl_ptr                     hw_ptr 
So my understanding is once wait_for_avail_min returns insnd_pcm_lib_write1 function.hw_ptr is increased by some amount(periodsize) but appl_ptr will increase only when wait_for_avail_minreturns.And difference of (hw_ptr+runtime->buffersize-appl_ptr) will give us unplayed samples in the case of playback?
Is this whole ring buffer is filled after the snd_pcm_lib_write_transfer function is returned?
3.In some rare cases (playback case) i have seen thatwait_for_avail_min doesn't return and driver pointer function keeps ongetting called causing hw_ptr to increase.This causessnd_pcm_playback_avail() function to return a value less than avail_min(as hw_ptr is increasing and appl_ptr is stagnant as it is stuck insnd_pcm_lib_write1 function) which inturn causes wake-up fromsnd_pcm_update_hw_ptr_post() not to get called.When this type ofscenario happens?Is it a normal scenario if yes,then how will it willever come out from wait_for_avail_min?
According to my understanding appl_ptr will increase only when we return from wait_for_avail_min?
4.how does alsa know that it is running short of data?As iunderstand that it does not free the memory and data is onlyoverwritten.So how does it distinguish between old and new data?
5.Burst of noise due to stale data problem reported by Jon Smirl and for which Mr Jaroslav has suggested this solution http://mailman.alsa-project.org/pipermail/alsa-devel/2009-May/017119.html.Is it implemented?
 
Best Regards..
