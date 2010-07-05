From: Smilen Dimitrov <sd@imi.aau.dk>
Subject: Help with dummy.c (where/how to write?)
Date: Mon, 05 Jul 2010 22:46:46 +0200
Message-ID: <4C3244B6.6080409@imi.aau.dk>
Reply-To: sd@imi.aau.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mho-02-ewr.mailhop.org (mho-02-ewr.mailhop.org [204.13.248.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E38E24528
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Jul 2010 22:46:57 +0200 (CEST)
Received: from x1-6-00-0e-a6-3f-d7-8d.k943.webspeed.dk ([87.60.144.211]
	helo=[192.168.1.11])
	by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.68) (envelope-from <sd@imi.aau.dk>) id 1OVsZ6-0003pa-KP
	for alsa-devel@alsa-project.org; Mon, 05 Jul 2010 20:46:56 +0000
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

I am trying to work on dummy.c:

http://lxr.linux.no/#linux+v2.6.32/sound/drivers/dummy.c

as an exercise, and I'd like to modify it so it behaves as an 
'oscillator'; that is, when I choose 'dummy' as an input in say 
Audacity, and press Record - I'd like to be able to write something to 
the audio (pcm) buffer of the driver directly from the driver itself 
(say a single sample), and be able to observe those samples recorded in 
Audacity.

So far, by adding some debug statements, the only thing I can figure, is 
that when 'Record' in Audacity is pressed, 'dummy_hrtimer_callback' is 
called continuously - but I cannot tell what functions to use to modify 
/ write to output buffers (not even sure what the output buffers there 
are, I guess dpcm->substream->private_data).

Could anyone point to me if there is a similar example existing already, 
or if not. provide me with some pointers on how to do this?

Thanks in advance,
Cheers!
