From: Cefn Hoile <alsa-project.org@cefn.com>
Subject: Re: Dell N5110 HDA External Speaker is mute
Date: Thu, 12 Jan 2012 10:52:57 +0000
Message-ID: <CA+P0tC_Pnx_JTE7dfiH+PY+hCf-wVsY+vp9H_KVdHpOz5uxgEw@mail.gmail.com>
References: <CA+P0tC_jvOyEsbmZoF5oJZ9k6DA3FRaHCbq+xP3axw+jgLaQ8w@mail.gmail.com>
	<s5h4nw1fbxj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8290224808
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 11:52:58 +0100 (CET)
Received: by obbuo13 with SMTP id uo13so562971obb.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 02:52:57 -0800 (PST)
In-Reply-To: <s5h4nw1fbxj.wl%tiwai@suse.de>
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

Thanks for your interest, Takashi.

The alsa disgnostic script output was already linked (but a bit hidden
in all the noise) in the downstream bug report...

http://www.alsa-project.org/db/?f=3D039be3036a03f707edc130bbc63b5063619e5755

Cefn
http://cefn.com

On 12 January 2012 10:32, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 11 Jan 2012 00:56:18 +0000,
> Cefn Hoile wrote:
>>
>> I'd like to report an issue experienced with the latest Oneiric, Dell
>> N5110, and IDT STAC92HD87 which has been explored through quite a few
>> steps already, and seems to have bottomed out to a set of
>> pins/controls/flags which are not being properly managed in order to
>> toggle speaker activation when a headphone is inserted.
>>
>> So far, I haven't heard sound from my speakers at all, although within
>> Alsamixer, the Speaker volume is visibly toggled from 100% to MM
>> (mute) on headphone insertion.
>>
>> I've tried every model against snd-hda-intel, many different other
>> options, and started to explore the HDA Analyzer, which includes
>> controls named like this...
>>
>> Node 0x13 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
>> =A0 Device: name=3D"STAC92xx Analog", type=3D"Audio", device=3D0
>> =A0 Control: name=3D"Speaker Playback Volume", index=3D0, device=3D0
>> =A0 =A0 ControlAmp: chs=3D3, dir=3D1, idx=3D0, ofs=3D63
>> =A0 Control: name=3D"Speaker Playback Switch", index=3D0, device=3D0
>> =A0 =A0 ControlAmp: chs=3D3, dir=3D1, idx=3D0, ofs=3D0
>> =A0 Amp-Out caps: ofs=3D0x7f, nsteps=3D0x7f, stepsize=3D0x02, mute=3D1
>> =A0 Amp-Out vals: [0x7f 0x7f]
>> =A0 Converter: stream=3D5, channel=3D0
>> =A0 Power: setting=3DD0, actual=3DD0
>> =A0 Delay: 13 samples
>>
>> ...but toggling these checkboxes within the HDA Analyzer gui doesn't
>> trigger any sound from the speakers either. It could be a rich
>> combination of the very many checkboxes and sliders which are revealed
>> by the Analyzer, but I don't really know where to start. The bug
>> information downstream is here...
>>
>> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/914290
>>
>> I'd really welcome suggestions for what else to try and happy to
>> invest time exploring options to try and make ALSA better still.
>
> Could you give alsa-info.sh output for checking the mixer and register
> states?
>
>
> Takashi
