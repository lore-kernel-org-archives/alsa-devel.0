From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: Add support for cs42l73 codec
Date: Wed, 5 Oct 2011 11:40:53 +0100
Message-ID: <20111005104053.GD9783@opensource.wolfsonmicro.com>
References: <1317400912-5789-1-git-send-email-brian.austin@cirrus.com>
	<20111002184033.GD2857@opensource.wolfsonmicro.com>
	<B2795634-3EDA-4EEC-9107-ED8B1D3AD374@cirrus.com>
	<555001A4-0B4D-48A9-B7B6-D8DF9E5F72E6@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA87E2468F
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 12:40:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <555001A4-0B4D-48A9-B7B6-D8DF9E5F72E6@cirrus.com>
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
Cc: "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<joe@nucleusys.com>" <joe@nucleusys.com>, "<vinod.koul@linux.intel.com>" <vinod.koul@linux.intel.com>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>, "<lrg@ti.com>" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2011 at 07:17:16PM +0000, Austin, Brian wrote:

>         if (spc & xSPDIF_PCM) {
>                 spc &= (31 << 3);       /* Clear PCM mode, set MSB->LSB */
>                 switch(format){
>                         case SND_SOC_DAIFMT_DSP_B:
>                                 if (inv == SND_SOC_DAIFMT_IB_IF)
>                                         spc |= (xPCM_MODE0 << 4);
>                                 
>                                 if (inv == SND_SOC_DAIFMT_IB_NF)
>                                         spc |= (xPCM_MODE1 << 4);
>                                 break;
>                         case SND_SOC_DAIFMT_DSP_A:
>                                 if (inv == SND_SOC_DAIFMT_IB_IF)
>                                         spc |= (xPCM_MODE1 << 4);
>                                 break;
>                         default:
>                                 return -EINVAL;
>                 }
>         }


This looks a lot better modulo the coding style issue (switch is not a
function).  Using snd_soc_update_bits() would be even better.
