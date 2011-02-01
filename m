From: Stephen Warren <swarren@nvidia.com>
Subject: snd_soc_jack_add_gpios vs. SOC_DAPM_PIN_SWITCH
Date: Mon, 31 Jan 2011 16:03:58 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E333@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 9826D243A7
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 01:04:04 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I've set up headphone hack detection in my machine driver, using
snd_soc_jack_new, snd_soc_jack_add_pins, and snd_soc_jack_add_gpios.

I've also created a control to allow the user to enable/disable the headphone
jack:

static const struct snd_kcontrol_new harmony_controls[] = {
	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
};

On their own, both of these work fine.

However, if I use the control to disable the headphones, then unplug/replug
the headphones, the jack detect seems to override the control, and I hear
audio from the headphones.

Is this something that's known not yet implemented or was never intended to
be used this way, or should I look further to find the issue?

FYI, sound/soc/samsung/smartq_wm8987.c has this same code structure, and I 
imagine will have the same issue.

Thanks.

-- 
nvpublic
