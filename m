From: Pedro Sanchez <psanchez@fosstel.com>
Subject: ASoC: Choppy audio on OMAP using McBSP3 interface
Date: Tue, 31 May 2011 09:21:47 -0400
Message-ID: <4DE4EB6B.8090605@fosstel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a2s40.a2hosting.com (a2s40.a2hosting.com [216.119.135.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D19F103806
	for <alsa-devel@alsa-project.org>;
	Tue, 31 May 2011 15:21:54 +0200 (CEST)
Received: from [207.35.173.122] (helo=[192.168.220.60])
	by a2s40.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <psanchez@fosstel.com>)
	id 1QROtI-003B9Q-6l
	for alsa-devel@alsa-project.org; Tue, 31 May 2011 09:21:48 -0400
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

Hello,

I wrote a ASoC driver for a TI DM3730-based custom board interfacing a 
TI TAS5709 codec over the McBSP2 interface. I'm using the Linux kernel 
2.6.32. The driver works very well, no problems with the sound quality 
at all.

Unfortunately due to reasons alien to me I needed to move the driver to 
work using the McBSP3 interface instead. All I did was then to change 
the pointer in my machine code to point to the McBSP3 interface:

static struct snd_soc_dai_link bp_audio_dai = {
     .name = "tas5709",
     .stream_name = "tas5709",
     .cpu_dai = &omap_mcbsp_dai[2], <-- from [1] to [2]
     .codec_dai = &tas5709_dai,
     .init = bp_audio_init,
     .ops = &bp_audio_ops,
};

and in my machine init code:

*(unsigned int *)bp_audio_dai.cpu_dai->private_data = 2;

With this change the audio driver works well when playing local audio 
files via the aplay command. But it fails miserably when playing 
streaming audio from a VoIP connection, the audio is very choppy as it 
happens when there is a large packet loss. However audio is mono 16 bits 
@8 KHz, not really very demanding.

I realize there is a big difference in the internal buffer size for the 
two interfaces, the McBSP2 having 10 times the buffer space of the 
McBSP3. I suspect this is somehow the source of my problems. I'm 
inclined to believe that there is some DMA-related optimization issue 
that has to be addressed somehow, but this is just a guess.

I fail to understand why is it that I can play local audio files but not 
streaming audio. What makes the difference? Any suggestions on how to 
address this issue?

Thank you,


-- 
Pedro
