From: David Favor <david@davidfavor.com>
Subject: Re: SB X-Fi driver still fails with Kernel 2.6.31-9 +
 ALSA 1.0.21
Date: Tue, 01 Sep 2009 13:52:18 -0500
Message-ID: <4A9D6D62.6020606@davidfavor.com>
References: <200908242143.20046.esken@kde.org>
	<s5hvdkc5t1q.wl%tiwai@suse.de>	<4A9D6161.1050304@davidfavor.com>
	<s5htyzm4ji3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp101.sbc.mail.mud.yahoo.com (smtp101.sbc.mail.mud.yahoo.com
	[68.142.198.200])
	by alsa0.perex.cz (Postfix) with SMTP id D51E61037EE
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 20:52:20 +0200 (CEST)
In-Reply-To: <s5htyzm4ji3.wl%tiwai@suse.de>
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
Cc: Christian Esken <esken@kde.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 01 Sep 2009 13:01:05 -0500,
> David Favor wrote:
>> I'm using Ubuntu + Kernel 2.6.31-9 + ALSA 1.0.21 from today.
>>
>> For the X-Fi CA0110 card I have the codec stanzas are missing.
>> I've built ALSA with --debug=verbose so if anyone has any idea
>> what I can do to debug this problem, let me know.
> 
> As I mentioned in another thread, this is likely the communication
> error between the codec and the controller.  But I have no idea what
> is exactly wrong about it.  Until now there is no change regarding this,
> thus no fix yet.
> 
> You may poke around the codec communication part in hda_intel.c, e.g.
> adding some delay or so...

I'm new to working with drivers on Linux. If you can point me to where
to look in logs to get started looking at debugging info, I'll take a
look at the .c file and see if I can make heads or tails of it by inserting
additional debug logic/messaging.

Thanks.

> Takashi
> 
>> Thanks.
>> _______
>>
>> david@home1:~/bin$ uname -a
>> Linux home1 2.6.31-9-generic #29-Ubuntu SMP Sun Aug 30 17:39:23 UTC 2009 i686 GNU/Linux
>>
>> david@home1:/etc/pulse$ lspci | grep -i audio
>> 0d:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
>>
>> david@home1:/etc/pulse$ lsmod | grep -i ca0110
>> snd_hda_codec_ca0110     7772  1
>> snd_hda_codec          81884  2 snd_hda_codec_ca0110,snd_hda_intel
>> snd                    65092  22 
>> snd_hda_codec_ca0110,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm_oss,snd_mixer_oss, \
>>      snd_pcm,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq_midi_event,\
>>      snd_seq,snd_timer,snd_seq_device
>>
>> david@home1:/etc/pulse$ modinfo snd-hda-codec-ca0110
>> filename:       /lib/modules/2.6.31-9-generic/updates/alsa/pci/hda/snd-hda-codec-ca0110.ko
>> description:    Creative CA0110-IBG HD-audio codec
>> license:        GPL
>> alias:          snd-hda-codec-id:1102000d
>> alias:          snd-hda-codec-id:1102000b
>> alias:          snd-hda-codec-id:1102000a
>> srcversion:     32AD360281DB96C479EA380
>> depends:        snd-hda-codec,snd
>> vermagic:       2.6.31-9-generic SMP mod_unload modversions 586
>>
>> david@home1:~/bin$ audio-codecs
>> /proc/asound/card0/codec#1
>> Codec: Creative CA0110-IBG
>> Address: 1
>> Function Id: 0x1
>> Vendor Id: 0x1102000a
>> Subsystem Id: 0x11021007
>> Revision Id: 0x100000
>> No Modem Function Group found
>> Default PCM:
>> N/A
>> Default Amp-In caps: N/A
>> Default Amp-Out caps: N/A
>> GPIO: io=255, o=255, i=255, unsolicited=1, wake=1
>>
>> -- 
>> Love feeling your best ever, all day, every day?
>> Click http://RadicalHealth.com for the easy way!
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Love feeling your best ever, all day, every day?
Click http://RadicalHealth.com for the easy way!
