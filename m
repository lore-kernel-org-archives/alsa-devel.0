From: =?iso-8859-2?Q?Milan=20K=F8=E1pek?= <Hellbard@seznam.cz>
Subject: PCM device volume
Date: Wed, 07 Oct 2009 09:48:54 +0200 (CEST)
Message-ID: <5316.7786-14302-1023345306-1254901734@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxh.seznam.cz (mxh.seznam.cz [77.75.76.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 673FA244AA
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 09:48:55 +0200 (CEST)
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

Hi, 
 I am new with alsa. I am developing application that will have audio output on linux systems via alsa. I found many hints when I was trying to play some audio. I used 

snd_pcm_open(&pcm_handle, pcm_name, SND_PCM_STREAM_PLAYBACK, SND_PCM_NONBLOCK);
snd_pcm_hw_params_any(pcm_handle, hwparams);

to open and set my PCM device for writting audio. 

But I have got lost when I tried to change my audio volume. I suppose that I need to get some mixer

int 	snd_mixer_open (snd_mixer_t **mixer, int mode)

but I could not find how to code that the new mixer will control the PCM device. Pleas is there any tutorial how to do it? Or can somebody show me any code snippet? I have tried to find any similar topic, but without success.

Thanks for any advice

Milan
