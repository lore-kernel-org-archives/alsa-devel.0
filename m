From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: change widget sequence for
	depop
Date: Tue, 20 Aug 2013 10:36:01 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB935C7406C9@rtitmbs7.realtek.com.tw>
References: <1376914682-3606-1-git-send-email-bardliao@realtek.com>
 <521255FC.4000003@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 22BFA265175
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2013 04:36:06 +0200 (CEST)
In-Reply-To: <521255FC.4000003@wwwdotorg.org>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Stephen Warren [mailto:swarren@wwwdotorg.org]
> Sent: Tuesday, August 20, 2013 1:30 AM
> To: Bard Liao
> Cc: broonie@kernel.org; lgirdwood@gmail.com; alsa-devel@alsa-project.org;
> Flove; Oder Chiou; swarren@nvidia.com
> Subject: Re: [PATCH] ASoC: rt5640: change widget sequence for depop
> 
> On 08/19/2013 06:18 AM, bardliao@realtek.com wrote:
> > From: Bard Liao <bardliao@realtek.com>
> >
> > Add mute/unmute control in widget event and modify the power on/off
> sequence to avoid pop noise.
> 
> This version breaks both headphone and speaker output. I see the following
> issues:
> 
> 1)
> 
> After a reboot, if all of "{HP,Speaker} [LR] Playback Switch" are on/unmuted,
> and I start playback, then something sets all those controls to off/muted. I
> suspect this is related to function rt5640_hp_event() twiddling the same
> RT5640_[LR]_MUTE bits that the hp_[lr]_enable_control controls twiddle.
> 
> 2)
> 
> If playback is running, and (1) has caused all output to be muted, and I then
> run alsamixer and enable/unmute "HP L Playback Switch", I hear sound on
> both the L and R headphone channels for a very brief time, then output
> switches to the L channel only. Similar happens if I unmute "HP R Playback
> Switch" first. Unmuting both switches does produce stereo sound as expected.
> 
> I don't know if this also happens for the speaker output, since the board is too
> far away from me to easily tell which speakers are playing.

I think you didn't apply Lars-Peter's patch as below.
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -229,6 +229,8 @@ static int dapm_kcontrol_data_alloc(struct
  			template.id = snd_soc_dapm_kcontrol;
  			template.name = kcontrol->id.name;

+			data->value = template.on_val;
+
  			data->widget = snd_soc_dapm_new_control(widget->dapm,
  				&template);
  			if (!data->widget) {

It should be able to solve this issue.
If I remove this patch I can reproduce the issue.
Sorry for not informing you about that.

> 
> ------Please consider the environment before printing this e-mail.
