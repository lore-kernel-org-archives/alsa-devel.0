From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [asoc:topic/fsl-ssi 11/18]
 sound/soc/fsl/fsl_ssi.h:87:0: warning: "SSI_SCR_TCH_EN" redefined
Date: Tue, 19 Dec 2017 08:49:52 -0800
Message-ID: <20171219164951.GA9210@Asurada-CZ80>
References: <201712192144.4SnoQOF1%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f170.google.com (mail-pf0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 592DE266D09
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 17:49:59 +0100 (CET)
Received: by mail-pf0-f170.google.com with SMTP id a90so11367024pfk.1
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 08:49:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201712192144.4SnoQOF1%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 19, 2017 at 09:05:53PM +0800, kbuild test robot wrote:

>    In file included from sound/soc/fsl/eukrea-tlv320.c:32:0:
> >> sound/soc/fsl/fsl_ssi.h:87:0: warning: "SSI_SCR_TCH_EN" redefined
>     #define SSI_SCR_TCH_EN   0x00000100
>     
>    In file included from sound/soc/fsl/eukrea-tlv320.c:31:0:
>    sound/soc/fsl/imx-ssi.h:18:0: note: this is the location of the previous definition
>     #define SSI_SCR_TCH_EN  (1 << 8)

Double checked the eukrea driver in the for-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/sound/soc/fsl/eukrea-tlv320.c

The #include "fsl_ssi.h" has been removed from the driver so I
think this is a false alarm.

Thanks
Nicolin
