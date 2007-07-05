From: Eliot Blennerhassett <linux@audioscience.com>
Subject: linked streams question
Date: Thu, 05 Jul 2007 19:53:36 +1200
Message-ID: <200707051953.36150.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id B94BC1038C6
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2007 09:51:43 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JKP009IO4I5FL30@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 05 Jul 2007 19:51:41 +1200 (NZST)
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

Greetings,

I'm adding linked stream support to my driver (asihpi), and having some 
trouble with the end of playback.

What happens is that the slave streams never transition to SETUP state at the 
end of playback.
(Eg playing 4 channel wav file to 2 linked stereo streams with aplay).

The master stream reaches snd_pcm_drain_done() which then causes 
trigger(stop),  resulting in all linked streams being stopped.
But only the master state is set to SETUP

However, now the slave streams are stopped,  period_elapsed() is not called 
for a final time to (I assme) cause them to transition to the SETUP state.
Eventually I get "playback drain error (DMA or IRQ trouble?)\n"

My workaround is to set the state of each substream to SETUP in the 
trigger-stop operator, but no other driver needs to do this so I think it is 
probably the wrong solution - maybe misses some other cleanup code?  

Any suggestions on the proper way to handle this?

regards

Eliot
