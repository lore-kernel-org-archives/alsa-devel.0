From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/4] Implement control sharing
Date: Fri, 29 Apr 2011 16:28:42 +0100
Message-ID: <1304090922.3521.42.camel@odin>
References: <1304033881-1160-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A55410382A
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 17:28:46 +0200 (CEST)
Received: by wyg36 with SMTP id 36so3284448wyg.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2011 08:28:45 -0700 (PDT)
In-Reply-To: <1304033881-1160-1-git-send-email-swarren@nvidia.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-04-28 at 17:37 -0600, Stephen Warren wrote:
> Control sharing is enabled when two widgets include pointers to the
> same kcontrol_new in their definition. Specifically:
> 
> static const struct snd_kcontrol_new adcinput_mux =
>         SOC_DAPM_ENUM("ADC Input", adcinput_enum);
> 
> static const struct snd_soc_dapm_widget wm8903_dapm_widgets[] = {
>   SND_SOC_DAPM_MUX("Left ADC Input", SND_SOC_NOPM, 0, 0, &adcinput_mux),
>   SND_SOC_DAPM_MUX("Right ADC Input", SND_SOC_NOPM, 0, 0, &adcinput_mux),
> };
> 
> This is useful when a single register bit or field affects multiple
> muxes at once. The common case is to have separate control bits or
> fields for each mux (channel). An alternative way of looking at this
> is that the mux is a stereo (or even n-channel) mux, rather than
> independant mono muxes.
> 
> I have tested this on NVIDIA Tegra Seaboard, specifically with the WM8903
> "ADC Input" control, and a locally-enabled digital mic setup.
> 
> I have not compiled nor tested any other platforms.
> 
> This patchset does not implement control sharing for dapm_new_mixer() yet.
> I can do so after discussion/review of this patch series, although note that
> I don't have anything to test the actual sharing on for such controls.
> 
> Stephen Warren (4):
>   ASoC: s/w->kcontrols/w->kcontrol_news/g
>   ASoC: Add w->kcontrols, and populate it
>   ASoC: Store a list of widgets in a DAPM mux/mixer kcontrol
>   ASoC: Implement mux control sharing
> 
>  include/sound/soc-dapm.h          |   75 +++++----
>  sound/soc/codecs/88pm860x-codec.c |    2 +-
>  sound/soc/soc-dapm.c              |  315 ++++++++++++++++++++++++++-----------
>  3 files changed, 266 insertions(+), 126 deletions(-)
> 

All

Acked-by: Liam Girdwood <lrg@ti.com>
