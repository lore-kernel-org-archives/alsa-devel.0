From: Markus Luttenberger <m.luttenberger@avibit.com>
Subject: Play multiple sounds concurrently
Date: Fri, 18 Dec 2009 14:44:30 +0100
Message-ID: <4B2B873E.6010906@avibit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avibit.com (avserver.avibit.com [62.99.140.194])
	by alsa0.perex.cz (Postfix) with ESMTP id DF3B81038F9
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 14:44:30 +0100 (CET)
Received: from pc14.avibit.com (pc14.avibit.com [10.1.1.54])
	by avibit.com (Postfix) with ESMTP id 90D38684134
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 14:44:30 +0100 (CET)
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


I want to play multiple sounds concurrently with ALSA. The audio data is 
mono and G.711 a-law encoded. I can successfully play a single source of 
audio data but the sound is distorted when I try to play two sources.

Basically, this is what I'm doing:

-----8<-----------------
char buf1[1024];    // filled with audio data from source 1
char buf2[1024];    // filled with audio data from source 2
char wr_buf[1024];

for (int count = 0; count < 1024; count++)
   wr_buf[count] = (char) (0.5 * buf1[count]) +
                   (char) (0.5 * buf2[count]);

snd_pcm_writei(dev_handle, wr_buf, 1024);
-----8<-----------------


I think I have to use a scale value to correct the values or else 
clipping occures. However, this is the problem. How do I have to modify 
the audio bytes in order to add them together and write them into one 
buffer?




greetings..
..Markus
