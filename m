From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH alsa-lib emu10k1.conf 1/1] Fix "front"
	device of SB Live! Platinum
Date: Sat, 23 Apr 2011 11:33:20 +0800
Message-ID: <BANLkTik_ZFVB+-t=xk=G7dh0O4-ThniQKQ@mail.gmail.com>
References: <BANLkTintENV=X7VGyratXNYLOGRGQrp84g@mail.gmail.com>
	<s5h7hapf6kh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 151401037EE
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Apr 2011 05:33:21 +0200 (CEST)
Received: by fxm5 with SMTP id 5so747324fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2011 20:33:20 -0700 (PDT)
In-Reply-To: <s5h7hapf6kh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/20 Takashi Iwai <tiwai@suse.de>

> At Tue, 12 Apr 2011 10:17:32 +0800,
> Raymond Yau wrote:
> >
> > Since commit 148c2b8e7c12b4ab8a039995fa9904e7e1300cc4. Front channels via
> > fxbus 8 and 9
> >
>
> But reverting the whole FX routing causes a regression, so can't be
> taken as is.  If the FX route 8/9 can't be used for the front output
> on some models, the driver should notify it somehow and we need to
> handle differently for them.  Typically, the driver sets a different
> driver-name so that alsa-lib can use the corresponding card config
> file.
>
> I'll fix the lock issue first.
>
>
>
After commit  b6a48404088d91514b9e78c3237976a5aa87cb14 to get back the
"Front Playback Volume"

It seem that CT4760P has the following behaviour

Playing audio using
1) hw:0,0
"Wave Playback Volume" , "Master Playback Volume" and "PCM Playback Volume"
control the volume of front jack

"Wave Surround Volume" pan the audio to "rear" jack

"Front Playback Volume"" and "Surround Playback Volume" have no effect on
front jack and rear jack

2) front:0
"Front" Playback Volume" , "Master Playback Volume" and "PCM Playback
Volume" control the volume of front jack

no sound from rear jack (i.e. Wave Surround Playback Volume" does not has
any effect on rear jack)

3) rear:0
"Surround Playback Volume" control the volume of the rear jack

"Master Playback Volume" and "Wave Surround Volume" have no effect on rear
jack

4) device 3
using alsa-jack plugin and jackd -d alsa -P hw:0,3 -o 16

"Wave Playback Volume" control the volume of playback_1 and playback_2
"Front Playback Volume"  control the volume of playback_9 and playback_10



with high_res_gpr_volume=0 (EMU10K1_GPR_TRANSLATION_TABLE100)

Those Playback Volume controls except Master and PCM have fixed step 0.4 dB


range '0 - 100'
dbmin -9999999   (TLV_DB_GAIN_MUTE )
dbmax 0

with high_res_gpr_volume=1 (EMU10K1_GPR_TRANSLATION_NONE)

Those Playback Volume controls except Master and PCM have linear scale

range '0 - 2147483647'
dbmin -9999999  (TLV_DB_GAIN_MUTE )
dbmax 0



Is it a bug for PA server to add TLV_DB_GAIN_MUTE - infinite dB range of
"Front" and "Surround" and those finite dB range of "Master" and "PCM" ?
