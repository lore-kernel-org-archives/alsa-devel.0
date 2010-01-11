From: Markus Luttenberger <m.luttenberger@avibit.com>
Subject: Problems with snd_pcm_wait(..)
Date: Mon, 11 Jan 2010 12:38:56 +0100
Message-ID: <4B4B0DD0.8090900@avibit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avibit.com (avserver.avibit.com [62.99.140.194])
	by alsa0.perex.cz (Postfix) with ESMTP id CA22524589
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 12:38:56 +0100 (CET)
Received: from pc14.avibit.com (pc14.avibit.com [10.1.1.54])
	by avibit.com (Postfix) with ESMTP id 43C9E684131
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 12:38:56 +0100 (CET)
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

Hey,


I tried to implement a callback functionality with ALSA based on the 
example given at 
http://www.cs.utk.edu/~vose/linux/equalarea.com/alsa-audio.html#interruptex. 
Especially the while-loop is basically the same in my program. However, 
it doesn't work. I can trace the program to snd_pcm_wait(..) which just 
waits endlessly.

The whole thing is called within a thread. The thread is still 
accessible from elsewhere in the pogram. It's just the 
snd_pcm_wait(..)-function which does not return although a time-out of 
1000 ms is given.

If I don't wait for the device I get the following assertion:
pcm.c:1079: snd_pcm_writei: Assertion `size == 0 || buffer' failed.

Any ideas what could be wrong?




greetings..
..Markus
