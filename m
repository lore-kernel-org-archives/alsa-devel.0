From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd-hda-intel acl269 toshiba r700 speakers work,
	headphones do not
Date: Wed, 21 Jul 2010 08:13:05 +0800
Message-ID: <AANLkTikE8PWQV8C505hWcL9HKAM51ZQVaRrvuqNBNswm@mail.gmail.com>
References: <4C41F914.5040508@gmail.com> <1279527456.3803.1.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7E66424419
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 02:13:08 +0200 (CEST)
Received: by vws9 with SMTP id 9so6695194vws.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Jul 2010 17:13:05 -0700 (PDT)
In-Reply-To: <1279527456.3803.1.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/19 Paul Menzel <paulepanter@users.sourceforge.net>

> Dear Thomas,
>
>
> Am Samstag, den 17.07.2010, 11:40 -0700 schrieb Thomas Hoffmann:
>
> > Sound works from the built in laptop speakers. When headphones are
> > plugged in, the speakers properly mute, but there is no sound coming
> > from the headphones. I've tried some of the options to the
> > alsa-base.conf file to no avail; generally they made it so sound came
> > out of the speakers always, even when headphones were plugged in.
> >
> > I previously sent an e-mail to this list server:
> >      https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5064
> > where they suggested I e-mail you. My system info is available from
> >
> >
> http://www.alsa-project.org/db/?f=f9aaf6e43b669cf2c4b2215781a414b12843e2a3
>
> did you already try different values for the `model` parameter [1]?
>
>
> Thanks,
>
> Paul
>

using hda_emu



SKU: Nid=0x1d sku_cfg=0x40179a2d
SKU: port_connectivity=0x1
SKU: enable_pcbeep=0x1
SKU: check_sum=0x00000007
SKU: customization=0x0000009a
SKU: external_amp=0x5
SKU: platform_type=0x1
SKU: swap=0x0
SKU: override=0x1
send: NID=0x20, VERB=0x500(set_coef_index), PARM=0x0
send: NID=0x20, VERB=0xc00(get_proc_coef), PARM=0x0
receive: 0x0
send: NID=0x20, VERB=0x500(set_coef_index), PARM=0x4
send: NID=0x20, VERB=0xc00(get_proc_coef), PARM=0x0
receive: 0x0
send: NID=0x20, VERB=0x500(set_coef_index), PARM=0x4
send: NID=0x20, VERB=0x400(set_proc_coef), PARM=0x0
hda_codec: ALC269: BIOS auto-probing.
autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
   speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
   hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
   mono: mono_out=0x0
   inputs: mic=0x18, fmic=0x12, line=0x0, fline=0x0, cd=0x0, aux=0x0
send: NID=0x18, VERB=0xf00(get_parameters), PARM=0xc(pin_cap)
receive: 0x1734
get connection index
send: NID=0x23, VERB=0xf00(get_parameters), PARM=0xe(connect_len)
receive: 0x6
send: NID=0x23, VERB=0xf02(get_connect_list), PARM=0x0
receive: 0x1b1a1918
send: NID=0x23, VERB=0xf02(get_connect_list), PARM=0x4
receive: 0xb1d
send: NID=0x12, VERB=0xf00(get_parameters), PARM=0xc(pin_cap)
receive: 0x20
get connection index
send: NID=0x23, VERB=0xf00(get_parameters), PARM=0xe(connect_len)
receive: 0x6
send: NID=0x23, VERB=0xf02(get_connect_list), PARM=0x0
receive: 0x1b1a1918
send: NID=0x23, VERB=0xf02(get_connect_list), PARM=0x4
receive: 0xb1d

get connection index
hda_codec: connection list not available for 0x24

send: NID=0x0, VERB=0xf00(get_parameters), PARM=0xc(pin_cap)
receive: 0x0
send: NID=0x20, VERB=0x500(set_coef_index), PARM=0x0
send: NID=0x20, VERB=0xc00(get_proc_coef), PARM=0x0
receive: 0x0
realtek: No valid SSID, checking pincfg 0x40179a2d for NID 0x1d
realtek: Enabling init ASM_ID=0x9a2d CODEC_ID=10ec0269
realtek: Enable HP auto-muting on NID 0x21
send: NID=0x21, VERB=0x708(set_unsol_enable), PARM=0x84
realtek: Enable auto-mic switch on NID 0x18/0x12
send: NID=0x18, VERB=0x708(set_unsol_enable), PARM=0x88
