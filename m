From: Natanael Olaiz <nolaiz@gmail.com>
Subject: Problem calling "snd_pcm_hw_params_set_channels" with
 a RME 9652 (the same call -with more channels- works OK on a MADI one)
Date: Mon, 12 Dec 2011 13:28:44 +0100
Message-ID: <4EE5F37C.7060506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1304E24516
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 13:30:02 +0100 (CET)
Received: by qcol42 with SMTP id l42so3600675qco.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 04:30:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

I have a problem with an application that worked OK on a RME Madi but 
now is failing with a 9652.
It fails calling to snd_pcm_hw_params_set_channels . With the 9652 i'm 
getting an error -22 "invalid argument", with any number of channels (I 
understand it should be 24 ?)

Any idea?

Alsa ver. : 1.0.24
Kernel: 3.0.4
/proc/asound/cards :
     0 [DSP            ]: H-DSP - Hammerfall DSP
                           RME Hammerfall HDSP 9652 at 0xfebf0000, irq 23


Thanks in advance,
Natanael.
