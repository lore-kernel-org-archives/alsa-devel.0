From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: model needed for Clevo P150HM (Realtek ALC892)
Date: Thu, 30 Jun 2011 19:00:44 +0200
Message-ID: <4E0CABBC.3070801@gmail.com>
References: <itumu8$r5k$1@dough.gmane.org>	<s5h39j0zpnc.wl%tiwai@suse.de>	<4E036C8F.3080709@gmail.com>	<s5hvcvvzkzq.wl%tiwai@suse.de>	<s5hk4cbzj6s.wl%tiwai@suse.de>	<4E047441.4010003@gmail.com>	<s5hpqm2v0zq.wl%tiwai@suse.de>	<4E05C1B1.50302@gmail.com>	<4E05C704.4080806@gmail.com>	<4E05CE02.1070801@gmail.com>	<s5hei2fvmgw.wl%tiwai@suse.de>	<4E082166.5060902@gmail.com>	<s5hpqlz3a3b.wl%tiwai@suse.de>	<s5hhb7b315l.wl%tiwai@suse.de>	<4E08E33D.3060608@gmail.com>	<s5htybaton8.wl%tiwai@suse.de>	<4E0B62B6.6000007@gmail.com>	<4E0B6BE0.1010003@gmail.com>	<4E0B7D22.3040009@gmail.com>	<s5hei2bsxdv.wl%tiwai@suse.de>	<4E0C17F2.5070704@gmail.com>
	<s5hzkkzreqr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5028D10384A
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Jun 2011 19:00:53 +0200 (CEST)
Received: by wyh21 with SMTP id 21so1867533wyh.38
	for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2011 10:00:52 -0700 (PDT)
In-Reply-To: <s5hzkkzreqr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

W dniu 30.06.2011 08:54, Takashi Iwai pisze:
> At Thu, 30 Jun 2011 08:30:10 +0200,
> Julian Sikorski wrote:
>>
>> W dniu 30.06.2011 07:26, Takashi Iwai pisze:
>>> At Wed, 29 Jun 2011 21:29:38 +0200,
>>> Julian Sikorski wrote:
>>>>
>>>> I also tried merging sound-2.6/master with Linus's tree, but this also
>>>> did not help.
>>>
>>> It's really strange.  Are you sure that this is the kernel you
>>> modified properly?  Before further debugging, check two things:
>>>
>>> - Run "git log sound/pci/hda/patch_realtek.c" and the first few
>>>   entries, whether they come from sound git tree.  For example,
>>>   check the commit below is contained:
>>>
>>>   commit 7ec9c6ccc6007b14a916021d4ba7ffbcc7822ae3
>>>   Author: Takashi Iwai <tiwai@suse.de>
>>>   Date:   Mon Jun 27 15:53:38 2011 +0200
>>>
>>>     ALSA: hda - Fix volume-init for ALC259 with invalid widget caps
>>
>> commit 0b0c8490670a77b937f502491ae9d5236aa4054a
>> Author: Takashi Iwai <tiwai@suse.de>
>> Date:   Tue Jun 28 12:45:47 2011 +0200
>>
>>     ALSA: hda - Create snd_hda_get_conn_index() helper function
>>
>>     Create snd_hda_get_conn_index() helper function for obtaining the
>>     connection index of the widget.  Replaced the similar codes used in
>>     several codec-drivers with this common helper.
>>
>>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>
>> commit 4f574b7b1a1cc8aac617e938459e8f03a641e678
>> Author: Takashi Iwai <tiwai@suse.de>
>> Date:   Mon Jun 27 16:17:07 2011 +0200
>>
>>     ALSA: hda - More volume-init fixes for ALC267 codec
>>
>>     More similar fixes like previous commits: handle the exceptional case
>>     like ALC267 where no volume amp is found in ADC widget but in the
>>     capsrc widget instead.
>>
>>     Also minor checks for avoiding possible erros: no connection-select
>>     when the pin has a single selection, and add beep verbs only when the
>>     0x1d is used for beep.
>>
>>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>
>> To be even more sure, I re-synced your branch again and built a new
>> kernel. I am attaching patch_realtek.c file being built. Fresh
>> alsa-info.sh is here:
>> http://www.alsa-project.org/db/?f=5051b2cb788b1db4273e06e98a78783dd0ec679f
> 
> OK, then it's correct.
> 
>>>     
>>> - Confirm the running kernel is what you really built and installed.
>>>   You can modify the suffix via $CONFIG_LOCALVERSION in .config file.
>>>   Name it uniquely, rebuild, re-install and reboot.  The new suffix
>>>   should appear in the output of "uname -r".
>>
>> belegdol4 is the suffix I added:
>> $ uname -r
>> 3.0-0.rc5.git0.1.belegdol4.fc15.x86_64
>>
>>> - Once when these are correct, check /proc/asound/card0/codec#0:
>>>   the widget NID 0x02 should contain "Speaker Playback Volume" instead
>>>   of "Headphone Playback Volume" with the latest driver.
>>
>> Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
>>   Control: name="Headphone Playback Volume", index=0, device=0
>>
>> Perhaps I need to specify a correct model to enable this code?
> 
> No, you shouldn't pass any model option.
> 
> Could you apply the patch below to add some debug prints, and give
> the relevant kernel messages you get?  Just grep lines with 'XXX'.
> 
> 
> Takashi

Here you go:

$ dmesg | grep XXX
[   12.789557] XXX alc662_auto_fill_dac_nids called
[   12.789716] XXX filled dacs: 2/0/0/0/0, hp 0, ext 0/0/0
[   12.789718] XXX swap primary out to HP
[   12.789719] XXX alc662_auto_fill_dac_nids called
[   12.789845] XXX filled dacs: 2/0/0/0/0, hp 0, ext 0/0/0
[   12.790094] XXX added multi-io pin 1a, dac 3
[   12.790343] XXX added multi-io pin 18, dac 4
[   12.790347] XXX create mixer ch 0 pin 1b dac 2 mix c
[   12.790351] XXX create mixer ch 1 pin 1a dac 3 mix d
[   12.790354] XXX create mixer ch 2 pin 18 dac 4 mix e

Julian
