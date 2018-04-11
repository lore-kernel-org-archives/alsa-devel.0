From: Naveen M <naveen.m@intel.com>
Subject: Re: [PATCH v2 3/5] ASoC: Intel: Add Geminilake Dialog
 Maxim machine driver support
Date: Wed, 11 Apr 2018 23:03:36 +0530
Message-ID: <20180411173311.GA24343@intel.com>
References: <1523442303-12710-1-git-send-email-naveen.m@intel.com>
 <1523442303-12710-4-git-send-email-naveen.m@intel.com>
 <8fefaa36-2682-a604-4af9-6d4a2575c4f9@linux.intel.com>
 <20180411163414.GC12166@sirena.org.uk>
 <d038fed3-932e-2fd9-33e5-19503d1a3c6a@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 90912266E30
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 19:34:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d038fed3-932e-2fd9-33e5-19503d1a3c6a@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 11, 2018 at 12:06:52PM -0500, Pierre-Louis Bossart wrote:
> On 4/11/18 11:34 AM, Mark Brown wrote:
> >On Wed, Apr 11, 2018 at 11:20:10AM -0500, Pierre-Louis Bossart wrote:
> >
> >>>+static char glk_spk_dai_name[10];
> >>>+static char glk_hs_dai_name[10];
> >
> >>Off-by-one? "SSPx-Codec" would be 11 chars if you include null termination.
> >
> >Or avoid needing global statics entirely...
> >
> >>>   static int broxton_audio_probe(struct platform_device *pdev)
> >>>   {
> >>>   	struct bxt_card_private *ctx;
> >>>+	int dai_index = 8;
> >
> >>maybe better to do an explicit search that hard-code values?
> >>This will actually not work if you have an additional FE for headset on GLK,
> >>or you are assuming a dependency on a patch added later in the series - not
> >>good.
> >
> >Definitely, this is just a recipe for fragility.
> 
> Which reminds me btw that we talked about adding a helper to dynamically
> change fields in a dailink (codec/cpu/dai names) instead of doing this in
> multiple machine drivers, e.g.
> 
> snd_soc_fixup_dailink(bxt_dailink, device_name, CPU_DAI_NAME, "Pin1");
> snd_soc_fixup_dailink(bxt_dailink, device_name, DAI_NAME, "SSP5-Codec");
> snd_soc_fixup_dailink(bxt_dailink, device_name, CODEC_NAME, hid-name);
Thanks I Got it, will modify the patch and update.
-- 
