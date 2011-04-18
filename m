From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM8903 DMIC, and stereo mux vs. 2 mono muxes
Date: Mon, 18 Apr 2011 14:37:57 +0100
Message-ID: <20110418133756.GA2466@opensource.wolfsonmicro.com>
References: <1303014585-32331-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 88ED21037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Apr 2011 15:38:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1303014585-32331-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 16, 2011 at 10:29:45PM -0600, Stephen Warren wrote:

> So, is there a way to correctly represent this while only exposing a
> single control for it?

No, not at present.  DAPM only deals in mono controls.  Your current
patch looks good though...

> +static const struct snd_kcontrol_new dsp_mux =
> +	SOC_DAPM_ENUM("DSP Mux", dsp_enum);
> +

...this should be more descriptively named - Decimator input or
something.
