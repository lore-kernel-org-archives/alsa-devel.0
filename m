From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH] ASoC: factor out intel_scu_ipc related
 read/write
Date: Sat, 7 May 2011 21:48:30 +0800
Message-ID: <20110507134830.GB13216@qtel.sh.intel.com>
References: <20110507134318.4225.54478.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 844E6243CB
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 15:49:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110507134318.4225.54478.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

How do you think of this approach?

Hi Vinod,

I don't have the mfld hardware, so it's a not tested patch. I want your
ack or dis-ack on this. :)

> +	case SND_SOC_INTEL_SCU:
> +		if (io_types[i].addr_bits != 16 || io_types[i].data_bits != 8)
> +			return -EINVAL;
> +
> +		codec->hw_read = snd_soc_16_8_intel_scu_read;
> +		codec->hw_write = snd_soc_16_8_intel_scu_write;
> +		codec->control_data = codec;

Another way to do this to simply override codec->read and codec->write
with the intel_scu_read/write stuff.  But then I realize we may later
take advantage of soc cache, therefore it's not appropriate to simply
override these two operations.

-- 
guanqun
