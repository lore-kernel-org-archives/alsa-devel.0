From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: alsa device drain power
Date: Fri, 18 Dec 2009 13:20:51 +0100
Message-ID: <4B2B73A3.1010702@gandalf.sssup.it>
References: <4B29F03F.4020100@gandalf.sssup.it>
	<20091217110334.GB12245@sirena.org.uk>
	<4B2B536F.4060800@gandalf.sssup.it>
	<20091218113225.GD19544@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from panicking.kicks-ass.org (unknown [77.224.194.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 610B010380E
	for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2009 13:21:06 +0100 (CET)
In-Reply-To: <20091218113225.GD19544@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Mark Brown wrote:
> On Fri, Dec 18, 2009 at 11:03:27AM +0100, Michael Trimarchi wrote:
>
>   
>> As reported by the datasheet the LM4853 has a bias circuitry shutdown.
>> This shutdown function is activated by applying a logic high to the
>> SHUTDOWN pin. This pin as command by the
>>     
>
> So this is an ASoC-specific question, not a generic ALSA one...
>
>   
no, there are others embedded devices but I can test only on gta02
>> static int lm4853_event(struct snd_soc_dapm_widget *w,
>>                         struct snd_kcontrol *k,
>>                         int event)
>>     
>
>   
>> in gta02. I don't put any debug stuff there but I suppose
>> if I open the device with and asound.conf that set
>> the value to true of the Stereo Out this event is called. Is it right?
>>     
>
> ASoC will only power things up if they're being used so setting that
> control may or may not power things up.  I'm still not sure what you're
> getting at with these questions - are you experiencing some problem, or
> is this just a case of getting things straight in your head?
>
>   
Ok this is the stack dump

<6>Power up lm4853 <6>ON
<4>[<c0032948>] (dump_stack+0x0/0x14) from [<c02b40d8>] 
(lm4853_event+0x58/0x70)
<4>[<c02b4080>] (lm4853_event+0x0/0x70) from [<c02b09f4>] 
(dapm_power_widgets+0x360/0x3d8)
<4> r4:c697b960
<4>[<c02b0694>] (dapm_power_widgets+0x0/0x3d8) from [<c02b0b64>] 
(snd_soc_dapm_stream_event+0xf8/0x100)
<4>[<c02b0a6c>] (snd_soc_dapm_stream_event+0x0/0x100) from [<c02ae118>] 
(soc_pcm_prepare+0x17c/0x1e0)
<4> r8:c6987a08 r7:c0481464 r6:c04807f8 r5:c69bed60 r4:00000000
<4>[<c02adf9c>] (soc_pcm_prepare+0x0/0x1e0) from [<c02a1f88>] 
(snd_pcm_do_prepare+0x20/0x40)
<4>[<c02a1f68>] (snd_pcm_do_prepare+0x0/0x40) from [<c02a1b0c>] 
(snd_pcm_action_single+0x40/0x7c)
<4> r4:c048034c
<4>[<c02a1acc>] (snd_pcm_action_single+0x0/0x7c) from [<c02a4110>] 
(snd_pcm_action_nonatomic+0x5c/0x74)
<4> r7:c69873cc r6:c048034c r5:00020002 r4:c69bed60
<4>[<c02a40b4>] (snd_pcm_action_nonatomic+0x0/0x74) from [<c02a417c>] 
(snd_pcm_prepare+0x54/0x6c)
<4> r6:00020002 r5:00000000 r4:c69bed60
<4>[<c02a4128>] (snd_pcm_prepare+0x0/0x6c) from [<c02a6c50>] 
(snd_pcm_common_ioctl1+0x1f0/0x354)
<4> r7:c69bed60 r6:00004140 r5:00079f18 r4:00000000
<4>[<c02a6a60>] (snd_pcm_common_ioctl1+0x0/0x354) from [<c02a73c4>] 
(snd_pcm_playback_ioctl1+0x2c8/0x2fc)
<4> r5:00079f18 r4:00000000
<4>[<c02a70fc>] (snd_pcm_playback_ioctl1+0x0/0x2fc) from [<c02a74e0>] 
(snd_pcm_playback_ioctl+0x34/0x40)
<4> r7:00000036 r6:00004140 r5:00079f18 r4:c6bd58a0
<4>[<c02a74ac>] (snd_pcm_playback_ioctl+0x0/0x40) from [<c00b2d54>] 
(vfs_ioctl+0x3c/0x9c)
<4>[<c00b2d18>] (vfs_ioctl+0x0/0x9c) from [<c00b3418>] 
(do_vfs_ioctl+0x184/0x1ac)
<4> r6:c6bd58a0 r5:00079f18 r4:0000000b
<4>[<c00b3294>] (do_vfs_ioctl+0x0/0x1ac) from [<c00b3480>] 
(sys_ioctl+0x40/0x60)
<4> r6:00004140 r5:fffffff7 r4:c6bd58a0
<4>[<c00b3440>] (sys_ioctl+0x0/0x60) from [<c002de20>] 
(ret_fast_syscall+0x0/0x2c)
<4> r6:00060304 r5:ab79ddc4 r4:00079ed8

I don't send any sound to the device so it remains on, it's the correct 
behavior?

I will try to explain better:

android start and open playback device, and the system has the lm on, so 
it drains more power
that it needs. Of course when you do some call, it change again the 
status to OFF but return
to ON again

Michael



Michael
