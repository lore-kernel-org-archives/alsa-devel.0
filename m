From: Steve Longerbeam <stevel@embeddedalley.com>
Subject: Re: non-interleaved mode
Date: Wed, 11 Jul 2007 11:12:49 -0700
Message-ID: <46951DA1.9000500@embeddedalley.com>
References: <4693CB01.5060804@embeddedalley.com>
	<s5hbqejjphf.wl%tiwai@suse.de>	<20070711091324.43424685.alsauser@pragmasoft.com>	<s5hps2zhxlb.wl%tiwai@suse.de>
	<469503F0.80706@embeddedalley.com>
	<Pine.LNX.4.61.0707111935470.7300@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp110.biz.mail.mud.yahoo.com (smtp110.biz.mail.mud.yahoo.com
	[68.142.201.179])
	by alsa0.perex.cz (Postfix) with SMTP id BCB761038FD
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 20:12:57 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0707111935470.7300@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "J. Scott Merritt" <alsauser@pragmasoft.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 11 Jul 2007, Steve Longerbeam wrote:
>
>   
>> Last night I ran an experiment.  I created a 16-bit stereo .wav file 
>> with all left samples = 0x5555, and all right samples = 0xAAAA. I then 
>> played the .wav using aplay, and just before trigger start in my driver 
>> I searched the DMA buffer for the first occurrence of 0xAAAA. The right 
>> samples didn't start until exactly half-way through the entire DMA buffer!
>>     
>
> Yes, it's the right non-interleaved behaviour. You can imagine this layout 
> as separate "mono" ring buffers for each channels - see 
> snd_pcm_lib_ioctl_channel_info() in pcm_lib.c . Driver might modify 
> info->offset if required (see hdsp.c driver for example).
>   

thanks, that cleared everything up for me.

Steve
