From: Eliot Blennerhassett <linux@audioscience.com>
Subject: error in snd_pcm_drain()
Date: Thu, 05 Jul 2007 19:37:41 +1200
Message-ID: <200707051937.42073.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 2054A1038C4
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2007 09:36:05 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JKP001BE3RNJ730@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 05 Jul 2007 19:35:52 +1200 (NZST)
Content-disposition: inline
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

Maybe an error in snd_pcm_drain - not sure what effect it might have...
	
snd_pcm_group_for_each_entry(s, substream) {
		runtime = s->runtime;
...
	}
	up_read(&snd_pcm_link_rwsem);
	snd_pcm_stream_lock_irq(substream);

/* pcm_native.c around line 1491: */
/* error? runtime has been changed by group_for_each 
should use substream->runtime instead?
*/

	/* resume pause */
	if (runtime->status->state == SNDRV_PCM_STATE_PAUSED)
		snd_pcm_pause(substream, 0);


--
Eliot
