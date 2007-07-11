From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: non-interleaved mode
Date: Wed, 11 Jul 2007 19:44:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0707111935470.7300@tm8103.perex-int.cz>
References: <4693CB01.5060804@embeddedalley.com> <s5hbqejjphf.wl%tiwai@suse.de>
	<20070711091324.43424685.alsauser@pragmasoft.com>
	<s5hps2zhxlb.wl%tiwai@suse.de> <469503F0.80706@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A323F10387F
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 19:44:25 +0200 (CEST)
In-Reply-To: <469503F0.80706@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Longerbeam <stevel@embeddedalley.com>
Cc: Takashi Iwai <tiwai@suse.de>, "J. Scott Merritt" <alsauser@pragmasoft.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 11 Jul 2007, Steve Longerbeam wrote:

> Last night I ran an experiment.  I created a 16-bit stereo .wav file 
> with all left samples = 0x5555, and all right samples = 0xAAAA. I then 
> played the .wav using aplay, and just before trigger start in my driver 
> I searched the DMA buffer for the first occurrence of 0xAAAA. The right 
> samples didn't start until exactly half-way through the entire DMA buffer!

Yes, it's the right non-interleaved behaviour. You can imagine this layout 
as separate "mono" ring buffers for each channels - see 
snd_pcm_lib_ioctl_channel_info() in pcm_lib.c . Driver might modify 
info->offset if required (see hdsp.c driver for example).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
