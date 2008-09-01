From: brunal <brunal2496@gmail.com>
Subject: how to convert stereo capture to mono stream (hardware
	incompatibility)
Date: Mon, 1 Sep 2008 14:36:56 +0200
Message-ID: <AAE526C2-EE39-474B-B9E4-683E62B34D33@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by alsa0.perex.cz (Postfix) with ESMTP id D735A2439D
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 14:37:04 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w1so2309457mue.2
	for <alsa-devel@alsa-project.org>; Mon, 01 Sep 2008 05:37:02 -0700 (PDT)
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

Hi all,

I've already asked my question in the alsa-user list, but as nobody  
was able to answer, I'm trying here if I have more chance.

I'm using a USB M-Audio fasttrack pro sound card under linux  
2.6.24.rt, and I want to plug it into a voice recognition software  
named Julius.

There is an implementation of alsa in Julius, but I can't make it  
working with my USB sound card, because when alsa tries to set  
channel capture to 1, I get an error from alsa. Here is the code :

  /* set number of channels */
   if ((err = snd_pcm_hw_params_set_channels(handle, hwparams, 1)) <  
0) {
     jlog("Error: adin_alsa: cannot set PCM channel to %d (%s)\n", 1,  
snd_strerror(err));
     return(FALSE);
   }
Which always return FALSE.

The thing is that when I change this line to set stereo channels,  
Julius recognition engine complains when it runs, and strip lots of  
audio packets, which seems to broke recognition.

So my question is : how can I by-pass this problem?

I've tried to do it with the .asoundrc file, but it seems that plugin  
or dmix stuff only works with playback, not recording.
Does someone have an idea how to make a recording plugin that accept  
stereo stream from hardware and output only the left channel?

I didn't understand how stereo stream are written in the audio buffer  
gave by alsa. Can someone explain me how to separate the two stream  
once it is written in the buffer?

I really thanks all who would take little attention to my questions,  
it's been 5 days I'm digging on the web but I only get code working  
for setreo applications, which doesn't help me so much.
And I know I might have an answer if I look into the audacity code,  
but it seems to me it's like using a bazooka for fishing redfish....

Best Regards,
Bruno.
