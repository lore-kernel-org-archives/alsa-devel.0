From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Playback PCM drain and card fifos
Date: Wed, 17 Aug 2011 16:21:34 +1200
Message-ID: <4E4B41CE.9030208@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id EE1821038A5
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 06:22:14 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LQ2004601FYZY40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 17 Aug 2011 16:21:34 +1200 (NZST)
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

Greetings,

I am seeing playback audio get truncated at the end of playback. The
amount lost is about what is in the on-card fifo. (asihpi driver)
For example in a specific test this is about 100ms of audio, though in
theory could go much higher if I let the card fifo fill completely.

The current driver calls snd_pcm_period_elapsed when the card has read
from the alsa ringbuffer. I.e. it is notifying that the buffer is
available for more data to be written.

As soon as the driver notifies that the final data has been read by the
card, the trigger stop is called, which in turn stops the card playback
immediately.

However, the data just read has not been played back yet so the audio is
truncated.

During playback the driver sets runtime->delay = on_card_bytes

I'm trying to work out what I can do in the driver (or in alsa mid layer
if necessary), to make this work better?


regards


-- 
Eliot Blennerhassett
AudioScience Inc.
