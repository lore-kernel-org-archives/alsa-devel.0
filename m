From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: Problems with the DP MST audio support patchset
Date: Fri, 26 May 2017 04:56:17 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19524AC2F3@SHSMSX103.ccr.corp.intel.com>
References: <6800ee6e-31c2-b5eb-fbb2-6826d8c66dc9@pa-w.de>
 <bceb4859-6dc9-b7a8-4d3a-81ac2a1fa907@pa-w.de>
 <96A12704CE18D347B625EE2D4A099D19524850F3@SHSMSX103.ccr.corp.intel.com>
 <63a71394-1cd4-e3e3-7364-37c2da90c791@pa-w.de>
 <CAGw6cBusfo6OjNWrbsGnDLx_D=K_DQ-X8aVfQ0awgG_tf8TBMA@mail.gmail.com>
 <CAGw6cBsQipd3zGk_0ggkaVx15=cBcSp78AGQT7wAh+DYtzD4qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 96486267428
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 06:56:37 +0200 (CEST)
In-Reply-To: <CAGw6cBsQipd3zGk_0ggkaVx15=cBcSp78AGQT7wAh+DYtzD4qw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Forney <mforney@mforney.org>
Cc: Libin Yang <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pascal Wichmann <pascal.wichmann@pa-w.de>
List-Id: alsa-devel@alsa-project.org

Hi Michael,

>-----Original Message-----
>From: Michael Forney [mailto:mforney@mforney.org]
>Sent: Friday, May 26, 2017 12:10 PM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: Libin Yang <libin.yang@linux.intel.com>; alsa-devel@alsa-project.org;
>Pascal Wichmann <pascal.wichmann@pa-w.de>
>Subject: Re: [alsa-devel] Problems with the DP MST audio support patchset
>
>On Thu, May 25, 2017 at 1:21 AM, Michael Forney <mforney@mforney.org>
>wrote:
>> Hi,
>>
>> I recently updated my kernel to 4.11, and am experiencing similar
>> problems as Pascal. I have a Skylake processor and DP output hooked up
>> with a DP to HDMI cable to an Onkyo SR-606 receiver.
>>
>> I can't get audio to work at all through my receiver anymore. I tried
>> both DTS and PCM audio files. I bisected it to the above mentioned
>> commit 9152085defb6426ce8f9989ca27e4450daefbd89 (ALSA: hda - add DP
>> MST audio support).
>>
>>>> Do you know if the DP MST audio mode is used in your case?
>>
>> I don't know what DP MST is or how to tell if I'm using it. However, I
>> noticed that when it does work, `aplay -L` gives me
>>
>> hdmi:CARD=PCH,DEV=0
>>     HDA Intel PCH, HDMI 0
>>     HDMI Audio Output
>> hdmi:CARD=PCH,DEV=1
>>     HDA Intel PCH, HDMI 1
>>     HDMI Audio Output
>>
>> and when it doesn't, I get
>>
>> hdmi:CARD=PCH,DEV=0
>>     HDA Intel PCH, Generic Digital
>>     HDMI Audio Output
>
>Well, I noticed in my dmesg log for 4.11:
>
><4>[    1.201789] snd_hda_intel 0000:00:1f.3: Too many HDMI devices
><4>[    1.201790] snd_hda_intel 0000:00:1f.3: Consider building the
>kernel with CONFIG_SND_DYNAMIC_MINORS=y
><4>[    1.201792] snd_hda_intel 0000:00:1f.3: Too many HDMI devices
><4>[    1.201794] snd_hda_intel 0000:00:1f.3: Consider building the
>kernel with CONFIG_SND_DYNAMIC_MINORS=y
><4>[    1.201795] snd_hda_intel 0000:00:1f.3: Too many HDMI devices
><4>[    1.201797] snd_hda_intel 0000:00:1f.3: Consider building the
>kernel with CONFIG_SND_DYNAMIC_MINORS=y
><3>[    1.202668] snd_hda_intel 0000:00:1f.3: control 3:0:0:ELD:0 is
>already present
><4>[    1.202737] snd_hda_codec_hdmi: probe of hdaudioC0D2 failed with
>error -16
><4>[    1.204335] snd_hda_intel 0000:00:1f.3: Too many HDMI devices
><4>[    1.204337] snd_hda_intel 0000:00:1f.3: Consider building the
>kernel with CONFIG_SND_DYNAMIC_MINORS=y
><4>[    1.204338] snd_hda_intel 0000:00:1f.3: Too many HDMI devices
><4>[    1.204340] snd_hda_intel 0000:00:1f.3: Consider building the
>kernel with CONFIG_SND_DYNAMIC_MINORS=y
><4>[    1.204341] snd_hda_intel 0000:00:1f.3: Too many HDMI devices
><4>[    1.204343] snd_hda_intel 0000:00:1f.3: Consider building the
>kernel with CONFIG_SND_DYNAMIC_MINORS=y
><3>[    1.205412] snd_hda_intel 0000:00:1f.3: control 3:0:0:ELD:0 is
>already present
><4>[    1.205464] snd_hda_codec_hdmi: probe of hdaudioC0D2 failed with
>error -16
><6>[    1.205644] snd_hda_codec_generic hdaudioC0D2: ignore pin 0x7,
>too many assigned pins
><6>[    1.205648] snd_hda_codec_generic hdaudioC0D2: autoconfig for
>Generic: line_outs=0 (0x0/0x0/0x0/0x0/0x0) type:line
><6>[    1.205651] snd_hda_codec_generic hdaudioC0D2:    speaker_outs=0
>(0x0/0x0/0x0/0x0/0x0)
><6>[    1.205653] snd_hda_codec_generic hdaudioC0D2:    hp_outs=0
>(0x0/0x0/0x0/0x0/0x0)
><6>[    1.205655] snd_hda_codec_generic hdaudioC0D2:    mono:
>mono_out=0x0
><6>[    1.205656] snd_hda_codec_generic hdaudioC0D2:    dig-out=0x5/0x6
><6>[    1.205658] snd_hda_codec_generic hdaudioC0D2:    inputs:
><6>[    1.207882] input: HDA Intel PCH Mic as
>/devices/pci0000:00/0000:00:1f.3/sound/card0/input4
><6>[    1.207979] input: HDA Intel PCH Front Headphone as
>/devices/pci0000:00/0000:00:1f.3/sound/card0/input5
><6>[    1.208070] input: HDA Intel PCH HDMI/DP,pcm=3 as
>/devices/pci0000:00/0000:00:1f.3/sound/card0/input6
><6>[    1.208158] input: HDA Intel PCH HDMI/DP,pcm=7 as
>/devices/pci0000:00/0000:00:1f.3/sound/card0/input7
><6>[    1.208246] input: HDA Intel PCH HDMI/DP as
>/devices/pci0000:00/0000:00:1f.3/sound/card0/input8
><6>[    1.208335] input: HDA Intel PCH HDMI/DP as
>/devices/pci0000:00/0000:00:1f.3/sound/card0/input9
><6>[    1.208441] input: HDA Intel PCH HDMI as
>/devices/pci0000:00/0000:00:1f.3/sound/card0/input12
><6>[    1.208582] input: HDA Intel PCH HDMI as
>/devices/pci0000:00/0000:00:1f.3/sound/card0/input13
><4>[    1.208700] ------------[ cut here ]------------
><4>[    1.208708] WARNING: CPU: 0 PID: 43 at fs/proc/generic.c:346
>proc_register+0xe9/0x110
><4>[    1.208709] proc_dir_entry 'card0/eld#2.0' already registered
><4>[    1.208710] Modules linked in:
><4>[    1.208715] CPU: 0 PID: 43 Comm: kworker/0:1 Not tainted 4.11.3+ #41
><4>[    1.208716] Hardware name: HP HP EliteDesk 800 G2 DM 35W/8055,
>BIOS N21 Ver. 02.14 04/28/2016
><4>[    1.208721] Workqueue: events azx_probe_work
><4>[    1.208723] Call Trace:
><4>[    1.208729]  dump_stack+0x4d/0x66
><4>[    1.208733]  __warn+0xc6/0xe0
><4>[    1.208737]  warn_slowpath_fmt+0x46/0x50
><4>[    1.208742]  proc_register+0xe9/0x110
><4>[    1.208746]  proc_create_data+0x71/0xc0
><4>[    1.208750]  snd_info_register+0x66/0xd0
><4>[    1.208753]  snd_info_register_recursive+0x5b/0x70
><4>[    1.208756]  snd_info_register_recursive+0x46/0x70
><4>[    1.208759]  snd_info_card_register+0x25/0xa0
><4>[    1.208764]  snd_card_register+0x140/0x190
><4>[    1.208769]  ? device_attach+0xb/0x10
><4>[    1.208773]  ? snd_hda_codec_configure+0xb1/0x120
><4>[    1.208776]  azx_probe_work+0x47d/0x860
><4>[    1.208778]  ? azx_probe_work+0x47d/0x860
><4>[    1.208783]  process_one_work+0x1ec/0x480
><4>[    1.208787]  worker_thread+0x43/0x4d0
><4>[    1.208790]  kthread+0x104/0x140
><4>[    1.208794]  ? process_one_work+0x480/0x480
><4>[    1.208797]  ? kthread_create_on_node+0x40/0x40
><4>[    1.208802]  ret_from_fork+0x29/0x40
><4>[    1.208805] ---[ end trace 538d7309f1b9646f ]---
>
>So I added CONFIG_SND_DYNAMIC_MINORS=y as suggested (previously it was
>disabled based on the help text). That seemed to do the trick.

So the audio works well?

>However, the `proc_dir_entry 'card0/eld#2.0' already registered` warning
>seems like it could be a bug despite this.
>
>I guess the problem was this new MST feature means that now I have 5 HDMI
>outputs showing up, which is too many.

Yes, in dynamic mode, there are 5 HDMI/DP outputs for the compatibility
with pulseaudio.

Regards,
Libin

>
>Sorry for the noise.
