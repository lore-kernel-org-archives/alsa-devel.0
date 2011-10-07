From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add support for cs42l73 codec
Date: Fri, 7 Oct 2011 12:42:39 +0100
Message-ID: <20111007114239.GB24534@sirena.org.uk>
References: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
	<20111006185746.GA17685@opensource.wolfsonmicro.com>
	<10520301-F8F9-4096-91F8-141F22CEA68C@cirrus.com>
	<20111007103359.GG19080@opensource.wolfsonmicro.com>
	<1317985636.1573.2272.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 687B0103B0F
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 13:42:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317985636.1573.2272.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>, "<lrg@ti.com>" <lrg@ti.com>, "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 07, 2011 at 04:37:16PM +0530, Vinod Koul wrote:

> See below:

> +static const struct snd_kcontrol_new dac1_output_mixer[] = {
> +       SOC_DAPM_SINGLE("Headphone Switch", CS42L73_PWRCTL3, 0, 1, 1),
> +       SOC_DAPM_SINGLE("LineOut Switch", CS42L73_PWRCTL3, 1, 1, 1),
> +};

> +static const struct snd_kcontrol_new dac2_output_mixer[] = {
> +       SOC_DAPM_SINGLE("Speakerphone Switch", CS42L73_PWRCTL3, 2, 1,
> 1),
> +       SOC_DAPM_SINGLE("Speakerphone LineOut Switch", CS42L73_PWRCTL3,
> +                       4, 1, 1),
> +       SOC_DAPM_SINGLE("EarSpeaker Switch", CS42L73_PWRCTL3, 3, 1, 1),
> +};

> I think naming should be slightly better :)

I'm not sure, it might be more than the naming.  The fact that we're in
PWRCTL registers could be confusing hardware design, or the structure of
the hardware may not actually reflect what the driver is doing.
