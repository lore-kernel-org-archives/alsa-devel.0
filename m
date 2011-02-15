From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/5] mfld machine and codec fixes
Date: Tue, 15 Feb 2011 21:50:43 +0000
Message-ID: <1297806643.3337.89.camel@odin>
References: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DA081037FC
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 22:50:57 +0100 (CET)
Received: by wwe15 with SMTP id 15so657298wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 13:50:56 -0800 (PST)
In-Reply-To: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-02-15 at 18:28 +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> Hi,
> 
> This 5 patch series introduces some minor fixes in the TI sn95031 codec driver
> and the mfld_machine driver and sst_platfrom driver.
> This also changes mfld_machine to use the soc_register_card() API.
> 
> Vinod Koul (5):
>   ASoC: sn95031: make playback rails depend on actual pins they control
>   ASoC: sn95031: fix the DMIC path routing
>   ASoC: sn95031: fix the amic tlv scale
>   ASoC: sst_platform: fix the pulseaudio error
>   ASoC: mfld_machine: make use of soc_register_card API
> 
>  sound/soc/codecs/sn95031.c       |   58 +++++++++++++++++++-------------------
>  sound/soc/mid-x86/mfld_machine.c |   20 ++++---------
>  sound/soc/mid-x86/sst_platform.c |    9 ++++++
>  3 files changed, 44 insertions(+), 43 deletions(-)
> 

All 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
