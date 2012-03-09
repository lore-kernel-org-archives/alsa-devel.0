From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] Initialize volumes of HD-audio slave ctls
Date: Fri, 9 Mar 2012 11:13:38 +0800
Message-ID: <CAN8ccibTiaJtz5=zaSvw3srroe4zj7Y2EabpKnuCaDOvLaGQmg@mail.gmail.com>
References: <s5haa3ryuxb.wl%tiwai@suse.de>
	<4F594709.6090303@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 365BB24398
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 04:13:40 +0100 (CET)
Received: by wgbed3 with SMTP id ed3so876614wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 19:13:38 -0800 (PST)
In-Reply-To: <4F594709.6090303@canonical.com>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2012/3/9, David Henningsson <david.henningsson@canonical.com>:
> On 03/08/2012 04:27 PM, Takashi Iwai wrote:

>> diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
>> index 9771b07..f450f2a 100644
>> --- a/sound/pci/hda/patch_analog.c
>> +++ b/sound/pci/hda/patch_analog.c
>> @@ -82,6 +82,7 @@ struct ad198x_spec {
>>   	unsigned int inv_jack_detect: 1;/* inverted jack-detection */
>>   	unsigned int inv_eapd: 1;	/* inverted EAPD implementation */
>>   	unsigned int analog_beep: 1;	/* analog beep input present */
>> +	unsigned int avoid_init_slave_vol:1;
>>
>>   #ifdef CONFIG_SND_HDA_POWER_SAVE
>>   	struct hda_loopback_check loopback;
>> @@ -223,11 +224,12 @@ static int ad198x_build_controls(struct hda_codec
>> *codec)
>>   		unsigned int vmaster_tlv[4];
>>   		snd_hda_set_vmaster_tlv(codec, spec->vmaster_nid,
>>   					HDA_OUTPUT, vmaster_tlv);
>> -		err = snd_hda_add_vmaster(codec, "Master Playback Volume",
>> +		err = __snd_hda_add_vmaster(codec, "Master Playback Volume",
>>   					  vmaster_tlv,
>>   					  (spec->slave_vols ?
>>   					   spec->slave_vols : ad_slave_pfxs),
>> -					  "Playback Volume");
>> +					  "Playback Volume",
>> +					  !spec->avoid_init_slave_vol);
>>   		if (err<  0)
>>   			return err;
>>   	}
>> @@ -3604,6 +3606,7 @@ static int patch_ad1884(struct hda_codec *codec)
>>   	spec->vmaster_nid = 0x04;
>>   	/* we need to cover all playback volumes */
>>   	spec->slave_vols = ad1884_slave_vols;
>> +	spec->avoid_init_slave_vol = 1;
>>
>>   	codec->patch_ops = ad198x_patch_ops;
>>

https://bugs.launchpad.net/alsa-driver/+bug/526201

https://bugzilla.novell.com/show_bug.cgi?id=595544

Some HP desktops seem have internal speaker connected to mono port

, line out at rear panel and HP at front panel



Node 0x11 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001f: OUT HP Detect Trigger ImpSense
  Pin Default 0x02211030: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Black
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x07
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001001f: OUT HP EAPD Detect Trigger ImpSense
  EAPD 0x0:
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0a
Node 0x13 [Pin Complex] wcaps 0x40050c: Mono Amp-Out
  Control: name="Mono Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="Mono Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x00010010: OUT EAPD
  EAPD 0x0:
  Pin Default 0x99131150: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Black
    DefAssociation = 0x5, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x1f


DAC0 is not used and there is amp at node 0x13
dB range of volume control node 0x13 is different from node 0x03 and 0x04


Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Control: name="PCM Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="AD198x Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1a 0x1a]
  Converter: stream=0, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
