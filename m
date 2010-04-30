From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_1/4=5D_ASoC=3A_tlv320dac33?=
 =?iso-8859-1?q?=3A_Optimize_power_up=2C_=09and_restore?=
Date: Fri, 30 Apr 2010 10:37:37 +0300
Message-ID: <201004301037.37144.peter.ujfalusi@nokia.com>
References: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
	<1272612715-13387-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CFD12452B
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 09:38:11 +0200 (CEST)
In-Reply-To: <1272612715-13387-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 30 April 2010 10:31:52 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> On power up we only need to initialize the codec, and
> restore only registers, which are not in either in DAPM
> nor in the playback start sequence.
> These are mostly gain related registers.
> =

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

...

> +
> +	/* Restore only selected registers (gains mostly) */
> +	dac33_write(codec, DAC33_LDAC_DIG_VOL_CTRL,
> +		    dac33_read_reg_cache(codec, DAC33_LDAC_DIG_VOL_CTRL));
> +	dac33_write(codec, DAC33_RDAC_DIG_VOL_CTRL,
> +		    dac33_read_reg_cache(codec, DAC33_RDAC_DIG_VOL_CTRL));
> +
> +	dac33_write(codec, DAC33_LDAC_DIG_VOL_CTRL,
> +		    dac33_read_reg_cache(codec, DAC33_LDAC_DIG_VOL_CTRL));
> +	dac33_write(codec, DAC33_RDAC_DIG_VOL_CTRL,
> +		    dac33_read_reg_cache(codec, DAC33_RDAC_DIG_VOL_CTRL));

Hmm, restoring the same registers twice...
I'll remove the duplication in the v2 series (which I'm sure will come)

> +
> +	dac33_write(codec, DAC33_LINEL_TO_LLO_VOL,
> +		    dac33_read_reg_cache(codec, DAC33_LINEL_TO_LLO_VOL));
> +	dac33_write(codec, DAC33_LINER_TO_RLO_VOL,
> +		    dac33_read_reg_cache(codec, DAC33_LINER_TO_RLO_VOL));
>  }
> =


-- =

P=E9ter
