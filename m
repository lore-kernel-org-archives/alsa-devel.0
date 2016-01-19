From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 4/6] drm: sti: Add ASoC generic hdmi codec
	support.
Date: Tue, 19 Jan 2016 17:06:45 +0000
Message-ID: <20160119170644.GP19062@n2100.arm.linux.org.uk>
References: <1453210836-16218-1-git-send-email-arnaud.pouliquen@st.com>
 <1453210836-16218-5-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 988F2260588
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 18:06:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1453210836-16218-5-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 19, 2016 at 02:40:34PM +0100, Arnaud Pouliquen wrote:
> +	/* update N parameter */
> +	ret = hdmi_audio_compute_n_cts(params->sample_rate,
> +				       hdmi->mode.clock, &n_cts);
> +	if (ret < 0)
> +		return ret;
> +
> +	DRM_DEBUG_DRIVER("sample_frequency= %d, pix clock = %d\n",
> +			 params->sample_rate, hdmi->mode.clock);
> +	DRM_DEBUG_DRIVER("n= %d, cts = %d\n", n_cts.n, n_cts.cts);
> +
> +	hdmi_write(hdmi, n_cts.n, HDMI_AUDN);

This looks like you only make use of the N parameter, which suggests
that your hardware measures the CTS parameter itself - which means
you have the non-coherent clock case.  You'll want to refer to the
HDMI specs and use different N values from the coherent case.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
