From: Valerio Tesei <valerio.tesei@gmail.com>
Subject: Re: [PATCH ALSA HDA 1/1] Fix alc662_dac_nid and change
 6stack-dig to 5stack-dig
Date: Thu, 07 Apr 2011 21:44:40 +0200
Message-ID: <4D9E1428.1080702@gmail.com>
References: <BANLkTim-aFLPMDOsoBG+ifynovDgT8LO3g@mail.gmail.com>	<s5h8vvnrjea.wl%tiwai@suse.de>	<BANLkTimfTLnPCt2e1gw7tdgpd=omBzbW6A@mail.gmail.com>	<s5hy63nq12a.wl%tiwai@suse.de>	<BANLkTinCh8+93jgcUrVP5J=u6XK3xbZOqg@mail.gmail.com>	<s5htyeb9180.wl%tiwai@suse.de>	<BANLkTim1wU9RBpZ3As9uxb=YEXWVST1FVw@mail.gmail.com>	<BANLkTinSpX+EOs2EMTxTpwKKk4sm89Q_LA@mail.gmail.com>	<BANLkTi=D1AX9b-kU6oZv+F0aWa0fGcuNtg@mail.gmail.com>
	<BANLkTikorXUoaGiJ94i_syzfN-0Oy98tzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 92423243E0
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 21:46:27 +0200 (CEST)
Received: by wyg36 with SMTP id 36so2734797wyg.38
	for <alsa-devel@alsa-project.org>; Thu, 07 Apr 2011 12:46:24 -0700 (PDT)
In-Reply-To: <BANLkTikorXUoaGiJ94i_syzfN-0Oy98tzw@mail.gmail.com>
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

I checkout the takashi kernel tree, selected hda-intel and alsa as
module and reboot.

After probe i get these debug http://pastebin.com/7hGVe4U3 with (i
think) useful informations about,

Looking for the ioremap that Raymond ask about i found :

[ 1048.230360] nvidia: module license 'NVIDIA' taints kernel.
[ 1048.230363] Disabling lock debugging due to kernel taint
[ 1048.664298] nvidia 0000:01:00.0: PCI INT A -> GSI 16 (level, low) ->
IRQ 16
[ 1048.664304] nvidia 0000:01:00.0: setting latency timer to 64
[ 1048.664308] vgaarb: device changed decodes:
PCI:0000:01:00.0,olddecodes=io+mem,decodes=none:owns=io+mem
[ 1048.664529] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  270.18 
Tue Jan 18 21:46:26 PST 2011
[ 1048.866318] ioremap error for 0xdde70000-0xdde71000, requested 0x10,
got 0x0

So i could say that ioremap is about nvidia, do you?

This is my latest alsa-info
http://www.alsa-project.org/db/?f=184ce71bf28e38656c1a31a607f9c38c396808a3

Dont care about "failed to load firmware bla bla bla" i found wrong
google informations about it :)

Hope to be helpful,

V.

Il 07/04/2011 15:13, Raymond Yau ha scritto:
> 2011/4/7 Valerio tesei <valerio.tesei@gmail.com>
>
>> This evening i will check out the Takashi sound-2.6 git kernel tree and
>> update it every day to give feedback on problems with this card on my
>> motherboard.
>>
>> If i could help in any other way (debug, dmesg or others) let me know :)
>>
>> why alsaconf does not find my card? what i'm wrong?
>>
>> anyway, thanks for all this work.
>>
>>
> You have to find out from system log which hardware cannot ioremap
>
> [ 250.950937] ioremap error for 0xdde70000-0xdde71000, requested 0x10, got
> 0x0
>
> Is it normal to have so many hda_codec_cleanup_stream  ?
>
> [ 369.824424] hda_codec_cleanup_stream: NID=0x9
> [ 369.824857] hda_codec_cleanup_stream: NID=0x9
> [ 369.825335] hda_codec_cleanup_stream: NID=0x9
> [ 369.825764] hda_codec_cleanup_stream: NID=0x9
> [ 369.826232] hda_codec_cleanup_stream: NID=0x9
> [ 369.826634] hda_codec_cleanup_stream: NID=0x9
> [ 369.827095] hda_codec_cleanup_stream: NID=0x9
>
>
> The HDA controller seem support multi stream capture
>
> [ 6.748965] hda-intel: chipset global capabilities = 0x4401
>
> Two stereo ADCs support 16/20/24-bit PCM format, multiple stereo recording
>
> but the driver only create 1 capture stream.but two capture volume/switches
> and input sources
>
> ARECORD
> **** List of CAPTURE Hardware Devices ****
> card 0: Intel [HDA Intel], device 0: ALC892 Analog [ALC892 Analog]
>  Subdevices: 1/1
>  Subdevice #0: subdevice #0
>
> Simple mixer control 'Input Source',0
>  Capabilities: cenum
>  Items: 'Rear Mic' 'Front Mic' 'Line'
>  Item0: 'Rear Mic'
> Simple mixer control 'Input Source',1
>  Capabilities: cenum
>  Items: 'Rear Mic' 'Front Mic' 'Line'
>  Item0: 'Rear Mic'
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
*Email:* valerio.tesei@gmail.com
*Cellulare:* +39.3394768306
*Gtalk:* valerio.tesei@gmail.com
*LinkedIn:* http://www.linkedin.com/pub/valerio-tesei/22/a87/577
