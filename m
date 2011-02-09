From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] add support for jack detection in
	mid-x86
Date: Wed, 09 Feb 2011 21:51:48 +0000
Message-ID: <1297288308.3297.186.camel@odin>
References: <1297268074-30362-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4492310399F
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 22:51:53 +0100 (CET)
Received: by wwe15 with SMTP id 15so674604wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2011 13:51:53 -0800 (PST)
In-Reply-To: <1297268074-30362-1-git-send-email-vinod.koul@intel.com>
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

On Wed, 2011-02-09 at 21:44 +0530, Koul, Vinod wrote:
> From: Vinod Koul <vinod.koul@intel.com>
> 
> This patch set adds support for jack detection in mid-x6 machine and TI sn95031
> codec drivers. This also adds support to read mic bias values thru ADC 
> 
> This version fixes namespace issue in patch1, and removes gpio bits in machine
> driver pending gpiolib support, which will be added separately
> 
> Vinod Koul (3):
>   ASoC: sn95031: Add jack support in the codec
>   ASoC: mfld_machine: Add support for jack detection
>   ASoC: sn95031: Add support for reading mic bias
> 
>  sound/soc/codecs/sn95031.c       |  183 +++++++++++++++++++++++++++++++++-
>  sound/soc/codecs/sn95031.h       |   33 ++++++
>  sound/soc/mid-x86/mfld_machine.c |  203 +++++++++++++++++++++++++++++++++-----
>  3 files changed, 388 insertions(+), 31 deletions(-)
> 

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
