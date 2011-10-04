From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: Add support for cs42l73 codec
Date: Tue, 4 Oct 2011 22:38:39 +0100
Message-ID: <20111004213839.GA7328@opensource.wolfsonmicro.com>
References: <1317400912-5789-1-git-send-email-brian.austin@cirrus.com>
	<20111002184033.GD2857@opensource.wolfsonmicro.com>
	<B2795634-3EDA-4EEC-9107-ED8B1D3AD374@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 408711038B7
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 23:38:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B2795634-3EDA-4EEC-9107-ED8B1D3AD374@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<vinod.koul@linux.intel.com>" <vinod.koul@linux.intel.com>, "<lrg@ti.com>" <lrg@ti.com>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2011 at 05:53:10PM +0000, Austin, Brian wrote:
> On Oct 2, 2011, at 1:40 PM, Mark Brown wrote:
> > On Fri, Sep 30, 2011 at 11:41:52AM -0500, Brian Austin wrote:

> >> +	SOC_DOUBLE("ADC Boost Switch", CS42L73_ADCIPC, 2, 6, 1, 0),

> > This should be a Volume control with TLV information assuming it does
> > what it sounds like and makes the signal louder.

> This is just 0dB or 25dB so now it's just an enum if that's OK.

No, you can still show the gain with TLV information so it renders
nicely in UIs.

> >> +	SOC_SINGLE("HL Limiter Release Rate Volume", CS42L73_LIMRRATEHL, 0,
> >> +			0x3F, 0),

> > Similarly here, you probably want an enumaration showing the rates.

> This is a range of values that are used to set the rate by setting the step period size.
> It's values are 0 - 3F.  I'm hoping to leave it as an SOC_SINGLE control if possible

Well, you should certainly drop the "Volume" from the name.
