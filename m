From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA intel, wired headset w/mic, jack mic detect
Date: Fri, 16 Mar 2012 07:57:19 +0800
Message-ID: <CAN8cciYAvhKx5bL15tb4iVinVY+=K-Rspgud9O5mkAnHy0U=ew@mail.gmail.com>
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
	<87bonxbv3c.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id CB4DE2417B
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 00:57:20 +0100 (CET)
Received: by werg1 with SMTP id g1so3640900wer.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 16:57:19 -0700 (PDT)
In-Reply-To: <87bonxbv3c.fsf@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/3/16, Kevin Hilman <khilman@ti.com>:
> Raymond Yau <superquad.vortex2@gmail.com> writes:
>
>> 2012/3/10, Kevin Hilman <khilman@ti.com>:
>>>
>>> Ah, that's a little easier to tinker with for the uninformed like me. :)
>>>
>>> Using that, it seems that the above registers work on my coded (cs4206)
>>> too.  I was able to determine that the built-in mic is ADC2 right
>>> channel, and can at least make the built-in mic switch from the right to
>>> left (swap channel mode)
>>>
>>>     sudo hda-verb /dev/snd/hwC0D0 0x11 SET_COEF_INDEX 2
>>>     sudo hda-verb /dev/snd/hwC0D0 0x11 SET_PROC_COEF 0x180a
>>>
>>> or make the right channel go to both HDA channels (mono mode):
>>>
>>>     sudo hda-verb /dev/snd/hwC0D0 0x11 SET_COEF_INDEX 2
>>>     sudo hda-verb /dev/snd/hwC0D0 0x11 SET_PROC_COEF 0x100a
>>>
>>> However, I still can't figure out where the headset mic is and how to
>>> enable it.
>>>
>>> Here's what I think I know (c.f. alsa-info.sh  output below)
>>>
>>
>> do you mean that you cannot record mono using sysdefault  which use a
>> route to copy left channel channel to both if the internal mic is at
>> the right channel?
>>
>> arecord --vumeter=mono -c 1 -f S16_LE -r 48000 -Dsysdefault /dev/null
>
> Not sure exactly what you mean by sysdefault, but trying that fails:
>
> $ arecord --vumeter=mono -c 1 -f S16_LE -r 48000 -Dsysdefault /dev/null
> ALSA lib pcm.c:2212:(snd_pcm_open_noupdate) Unknown PCM sysdefault
> arecord: main:660: audio open error: No such file or directory
>
> Kevin
>


http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=e6f990e5c9be5cac6f36924d20a75d0f69d27297



 pcm.default cards.pcm.default
+pcm.sysdefault cards.pcm.default
 pcm.front cards.pcm.front



http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/conf/cards/HDA-Intel.conf

HDA-Intel.pcm.default


  capture.pcm {


                 # to avoid possible phase inversions with digital mics
                 route_policy copy
