From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 5/5] ASoC: Intel: add BYTCR machine
 driver with RT5640
Date: Tue, 4 Nov 2014 15:02:44 +0530
Message-ID: <20141104093244.GE1870@intel.com>
References: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
 <1415079068-4979-6-git-send-email-vinod.koul@intel.com>
 <54589A0E.5040301@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D8B66260A56
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 10:32:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <54589A0E.5040301@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.jf.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 04, 2014 at 11:19:10AM +0200, Jarkko Nikula wrote:
> On 11/04/2014 07:31 AM, Vinod Koul wrote:
> >From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> >
> >Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> >Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> >---
> >  sound/soc/intel/Kconfig             |   12 ++
> >  sound/soc/intel/Makefile            |    2 +
> >  sound/soc/intel/bytcr_dpcm_rt5640.c |  258 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 272 insertions(+), 0 deletions(-)
> >  create mode 100644 sound/soc/intel/bytcr_dpcm_rt5640.c
> >
> ...
> >+static const struct snd_kcontrol_new byt_mc_controls[] = {
> >+	SOC_DAPM_PIN_SWITCH("Headphone"),
> >+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
> >+	SOC_DAPM_PIN_SWITCH("Int Mic"),
> >+	SOC_DAPM_PIN_SWITCH("Ext Spk"),
> >+};
> ...
> >+static struct snd_soc_dai_link byt_dailink[] = {
> >+	[MERR_DPCM_AUDIO] = {
> >+		.name = "Baytrail Audio Port",
> >+		.stream_name = "Baytrail Audio",
> >
> ...
> >+/* SoC card */
> >+static struct snd_soc_card snd_soc_card_byt = {
> >+	.name = "baytrailcraudio",
> >
> I think it's worth to have same kcontrol and card names than
> byt-rt5640 in case this is going to replace byt-rt5640.c since then
> users can continue to use the same asound.state file. E.g. speakers
> won't mute because of "Speaker" changes to "Ext Spk".
It would have helped if the DSP controls were not there. The DSP controls
need to be routed too, so existing conf files would need to be updated.

So, do you still recommend changing :)

-- 
~Vinod
