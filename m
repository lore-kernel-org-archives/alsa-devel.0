From: jarek <jarek@poczta.srv.pl>
Subject: wm9713 problem
Date: Mon, 23 Apr 2012 14:44:40 +0200
Message-ID: <1335185080.29833.61.camel@jlap2.macro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.srv.pl (mail.srv.pl [217.17.32.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 49A1A24561
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 14:44:53 +0200 (CEST)
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

Hi!
	I've problem with ARM board with WM9713 codec. I have very simple test
application, which reads samples with snd_pcm_readi and then writes them
with snd_pcm_writei.
I've tested this on few PC-s and it works fine. However on FirendlyARM
tiny6410 it hangs after few seconds on call to snd_pcm_readi.
What is more funny If I'm writing samples with 0 (silence), reading
works fine. It hangs only if I'm writing non-silence.
If I break program with Ctrl+C, I can see in dmesg:

s3c64xx_dma_stop: channel still active.

and audio driver is not working any more. I need to restart board to
make it working.

What it can be ? Where to look for problem ?
The kernel is 2.6.38 PREEMPT

best regards
Jarek
