From: Kevin Hilman <khilman@ti.com>
Subject: Re: HDA intel, wired headset w/mic, jack mic detect
Date: Thu, 15 Mar 2012 11:03:03 -0700
Message-ID: <87bonxbv3c.fsf@ti.com>
References: <87ehtlwen3.fsf@ti.com> <4F472D4F.3000904@canonical.com>
	<CALyTGODsDRToe7efiHoVecvQ2JAYVj+G1Rv+upf2tBDDjPpzCg@mail.gmail.com>
	<CAN8cciZm2s-1Y69cohepoNNYsyBq4qQzyvbkXF2K4aDspfVtGQ@mail.gmail.com>
	<87zkc1cvaa.fsf@ti.com>
	<CAN8ccib90y8m0KLTYKe7Jz5sXVZFY=D7aUwm8vog3aZvZPHH0Q@mail.gmail.com>
	<874nu99k9y.fsf@ti.com>
	<CAN8cciayARuQGLH=DHsReH0sYbz92K3BPNhmNEqYmSjc6wUUVw@mail.gmail.com>
	<87d38wfag6.fsf@ti.com>
	<CAN8cciaB6-GUvsPS8+bpftLb7BaawdpCsgY3Z7R9H+XdkJ8LNA@mail.gmail.com>
	<87booesssh.fsf@ti.com>
	<CAN8ccibbw109Sxb_X_ZKVO4GnpVUfbEyK0yyM8g90g8K8v4Jtw@mail.gmail.com>
	<87zkbvne5k.fsf@ti.com>
	<CAN8cciaEKB2Gf3n6NWFkoJmk=kuH6nNHJYLqQtoRiiPmfLcFcw@mail.gmail.com>
	<s5h62eiqlcn.wl%tiwai@suse.de> <87399lfpef.fsf@ti.com>
	<s5h1up5qxmc.wl%tiwai@suse.de> <87ipid4rvv.fsf@ti.com>
	<CAN8cciZqB3oVVGMS4=RBSGZH+nSJAZoUT_a8hFu=pBnNJ3gwfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 88346104641
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 19:03:04 +0100 (CET)
Received: by mail-gx0-f178.google.com with SMTP id o1so4108821ggn.37
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 11:02:50 -0700 (PDT)
In-Reply-To: <CAN8cciZqB3oVVGMS4=RBSGZH+nSJAZoUT_a8hFu=pBnNJ3gwfw@mail.gmail.com>
	(Raymond Yau's message of "Wed, 14 Mar 2012 08:50:53 +0800")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau <superquad.vortex2@gmail.com> writes:

> 2012/3/10, Kevin Hilman <khilman@ti.com>:
>>
>> Ah, that's a little easier to tinker with for the uninformed like me. :)
>>
>> Using that, it seems that the above registers work on my coded (cs4206)
>> too.  I was able to determine that the built-in mic is ADC2 right
>> channel, and can at least make the built-in mic switch from the right to
>> left (swap channel mode)
>>
>>     sudo hda-verb /dev/snd/hwC0D0 0x11 SET_COEF_INDEX 2
>>     sudo hda-verb /dev/snd/hwC0D0 0x11 SET_PROC_COEF 0x180a
>>
>> or make the right channel go to both HDA channels (mono mode):
>>
>>     sudo hda-verb /dev/snd/hwC0D0 0x11 SET_COEF_INDEX 2
>>     sudo hda-verb /dev/snd/hwC0D0 0x11 SET_PROC_COEF 0x100a
>>
>> However, I still can't figure out where the headset mic is and how to
>> enable it.
>>
>> Here's what I think I know (c.f. alsa-info.sh  output below)
>>
>
> do you mean that you cannot record mono using sysdefault  which use a
> route to copy left channel channel to both if the internal mic is at
> the right channel?
>
> arecord --vumeter=mono -c 1 -f S16_LE -r 48000 -Dsysdefault /dev/null

Not sure exactly what you mean by sysdefault, but trying that fails:

$ arecord --vumeter=mono -c 1 -f S16_LE -r 48000 -Dsysdefault /dev/null
ALSA lib pcm.c:2212:(snd_pcm_open_noupdate) Unknown PCM sysdefault
arecord: main:660: audio open error: No such file or directory

Kevin
