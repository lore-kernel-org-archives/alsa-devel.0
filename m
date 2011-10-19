From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v5] ASoC:Add support for cs42l73 codec
Date: Wed, 19 Oct 2011 14:12:50 +0530
Message-ID: <1319013770.23438.184.camel@vkoul-udesk3>
References: <1318952816-16983-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E5B8024400
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 10:51:39 +0200 (CEST)
In-Reply-To: <1318952816-16983-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: heelrod@heelrod.ad.cirrus.com
Cc: brian.austin@cirrus.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, ramesh.babu@intel.com, lrg@ti.com, "jeeja.kp" <jeeja.kp@intel.com>, joe@nucleusys.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-10-18 at 10:46 -0500, Brian Austin wrote:
> +static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
> +
> +       {"HPOUT", NULL, "HP Amp"},
> +       {"LINEOUT", NULL, "LO Amp"},
> +       {"SPKOUT", NULL, "SPK Amp"},
> +       {"EAROUT", NULL, "EAR Amp"},
> +       {"SPKLINEOUT", NULL, "SPKLO Amp"},
> +
> +       {"HP Amp", "Switch", "DAC1"},
> +       {"LO Amp", "Switch", "DAC1"},
> +       {"SPK Amp", "Switch", "DAC2"},
> +       {"SPKLO Amp", "Switch", "DAC2"},
> +       {"EAR Amp", "Switch", "DAC2"},
> + 
Since you have a mixer in codec before each of the amp, who is going to
configure those? And how are they represented here?

-- 
~Vinod
