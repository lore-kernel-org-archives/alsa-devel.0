From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Add capture
	source	selection and mic gain control
Date: Mon, 1 Dec 2008 23:26:52 +0000
Message-ID: <20081201232652.GA10702@sirena.org.uk>
References: <1228172848-5221-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C79E2414C
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 00:27:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1228172848-5221-1-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 02, 2008 at 01:07:28AM +0200, Grazvydas Ignotas wrote:

> This patch adds controls for capture source controls. When a microphone
> is selected, handlers automatically enable bias power (disable when
> deselected). The patch also adds microphone gain control. Microphone
> and line input recording tested on OMAP3 pandora board.

Hrm.  Disabling the gain like this is likely to cause trouble for jack
detect.  However, that's not implemented yet so not a problem currently.

> +static int twl4030_get_right_input(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = kcontrol->private_data;
> +	u8 reg = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICR);
> +
> +	reg &= TWL4030_SUBMIC_EN|TWL4030_AUXR_EN;
> +	if (reg == TWL4030_SUBMIC_EN)
> +		ucontrol->value.integer.value[0] = 0;
> +	else if (reg == TWL4030_AUXR_EN)
> +		ucontrol->value.integer.value[0] = 1;
> +
> +	return 0;

This will report something undefined as selected when neither option is
selected.  Why not include a "None" option in the mux (the same applies
to the other path)?  A switch statement might make for clearer code here.

> +
> +	SOC_DOUBLE_TLV("Microphone Boost", TWL4030_REG_ANAMIC_GAIN,
> +		0, 3, 5, 0, microphone_gain_tlv),

Should be "Microphone Boost Volume" or possibly just "Microphone Volume".
