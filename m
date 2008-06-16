From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Still have choppy audio using 1.0.17
Date: Mon, 16 Jun 2008 17:04:56 -0300
Message-ID: <4856C768.1060404@tet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail.tteng.com.br [201.86.232.130])
	by alsa0.perex.cz (Postfix) with ESMTP id AF836243F6
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 22:04:53 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id AC66212000A
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 17:04:51 -0300 (BRST)
Received: from [192.168.0.84] (gserra.tteng.com.br [192.168.0.84])
	by einstein.tteng.com.br (Postfix) with ESMTP id 64528120008
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 17:04:48 -0300 (BRST)
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

I have been trying for many weeks to solve this problem, but with no 
success. After updating to Alsa 1.0.17, which include changes to aloop, 
I still have choppy audio. I will try to summarize what happens:

- I need to use aloop, if I change to a sound card all the problems are 
gone;
- After some time of continuous play, applications start to reproduce 
choppy audio. Choppy audio doesn't happens all the time;
- If I repeatedly start and stop my sound capture application choppy 
audio occur sooner;
- Start/stop my application restores the sound quality (after some tryies);
- This happens with ALSA applications (xine, vlc) and OSS emulated;
- I have tryied many period_size and buffer_size in asound.conf, now I 
am using 960 for period and 3840 for buffer. As I decrease period size, 
the audio quality improves, but choppy audio still happens;
- I test for overrun but no errors occur.
- I am using block mode, interleaved, 44100, 16 bit, 2 channels
- I am using dmix, dsnoop, removing them does not correct the audio

These are some of the information I have, I don't know if is is enough. 
If necessary I can provide any other information.
What do you suggest that I do? Are there any known issues or 
configuration requirements?

Thanks in advance.
