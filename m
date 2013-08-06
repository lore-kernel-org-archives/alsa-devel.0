From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt5640: change widgetsequencefordepop
Date: Tue, 06 Aug 2013 11:35:37 +0200
Message-ID: <5200C369.6050607@metafoo.de>
References: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
 <20130805144808.GG9858@sirena.org.uk> <51FFDF11.5020106@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E0E@rtitmbs7.realtek.com.tw>
 <5200B7B5.7050506@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E40@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id D23722616E1
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 11:35:21 +0200 (CEST)
In-Reply-To: <1121E117AD4ECE49880A389A396215BB935C692E40@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 08/06/2013 11:13 AM, Bard Liao wrote:
>>> I think I need to use SND_SOC_DAPM_SWITCH with
>> SOC_DAPM_SINGLE_AUTODISABLE for this control.
>>> Am I right?
>>> I am trying to do that, but meet a problem.
>>> If I set speaker switch unmute before playing music, dapm will mute it
>> automatically in power on sequence.
>>> The only way I can unmute speaker is set speaker switch unmute while
>> playing music.
>>
>> DAPM should unmute the switch on power up and mute it on power down. The
>> Speaker Channel Switch control has the invert flag set did you also set the
>> invert flag for the new autodisable control?
>
> Yes, the related code is as below.
> static const struct snd_kcontrol_new spk_l_enable_control =
> 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5640_SPK_VOL,
> 		RT5640_L_MUTE_SFT, 1, 1);
>
> static const struct snd_kcontrol_new spk_r_enable_control =
> 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", RT5640_SPK_VOL,
> 		RT5640_R_MUTE_SFT, 1, 1);
>
> 	SND_SOC_DAPM_SWITCH("Speaker L Playback", SND_SOC_NOPM, 0, 0,
> 			&spk_l_enable_control),
> 	SND_SOC_DAPM_SWITCH("Speaker R Playback", SND_SOC_NOPM, 0, 0,
> 			&spk_r_enable_control),

Looks good. Maybe I got the invert = 1 case wrong somewhere. Can you add a 
couple of printks and send me the result?

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2da258b..18c62ae 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -229,6 +229,9 @@
  			template.id = snd_soc_dapm_kcontrol;
  			template.name = kcontrol->id.name;

+			printk("new control: %s %d\n", template->name,
+				template->off_val);
+
  			data->widget = snd_soc_dapm_new_control(widget->dapm,
  				&template);
  			if (!data->widget) {
@@ -337,8 +340,10 @@
  	if (data->value == value)
  		return false;

-	if (data->widget)
+	if (data->widget) {
  		data->widget->on_val = value;
+		printk("%s->on_val = %d\n", data->widget->name, value);
+	}

  	data->value = value;
