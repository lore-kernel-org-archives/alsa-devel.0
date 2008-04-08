From: Rong-Jhe <r93922118@ntu.edu.tw>
Subject: XRUN happens too often.
Date: Tue, 8 Apr 2008 10:15:05 +0000 (UTC)
Message-ID: <loom.20080408T090019-595@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id C362624682
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Apr 2008 13:15:03 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JjBn4-0007mA-BE
	for alsa-devel@alsa-project.org; Tue, 08 Apr 2008 11:15:03 +0000
Received: from 220.128.79.26 ([220.128.79.26])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 08 Apr 2008 11:15:02 +0000
Received: from r93922118 by 220.128.79.26 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 08 Apr 2008 11:15:02 +0000
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

I use "default" pcm and open it in block mode.
Then, I set the this pcm to perform 16-bit, two channels, and 44100 bps 
sampling rate audio data.
The number of periods per buffer is 10.

The follows are the parameters that I read from the pcm.
sampling rate = 44100 bps
period time = 21333 us
period size = 940 frames
buffer time = 213330 us
buffer size = 9408 frames

A sample in 16-bit, two channels is 4 bytes.
I allocate a audio data of 9408x4=37632 bytes.

audio_data=malloc(buffer_size*4);

This audio_data buffer will receive audio data from the network.
If this buffer is full, I use snd_pcm_writei( ) to put the buffer into the pcm.

snd_pcm_sframes_t frames;
snd_pcm_t *handle;

while((frame=snd_pcm_writei(handle, audio_data, buffer_size))<0)
{
   if(frames==-EPIPE)
      snd_pcm_prepare(handle);
   else
      printf("snd_pcm_writei error %d\n", frames);
}

The codes states that I put the entire buffer into the pcm at each time. The 
pcm use 10 periods to perform this buffer. The program can work normally.

If the sampling rate is changed, the program will encounter XRUN frequently.

The follows are the parameters that I read from the pcm after setting sampling 
rate to 48000.
sampling rate = 48000 bps
period time = 21333 us
period size = 1024 frames
buffer time = 213330 us
buffer size = 10240 frames
audio_data=malloc(buffer_size*4); //10240x4=40960

I also put the entire buffer into the pcm at each time, but snd_pcm_writei( )
will return -PIPE frequently.

What is the problem?
