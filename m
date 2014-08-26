From: Andreas Allacher <andreas.allacher@gmx.at>
Subject: Re: [PATCH] ALSA: virtuoso: add Xonar Essence STX II
 support
Date: Tue, 26 Aug 2014 08:49:22 +0200
Message-ID: <53FC2DF2.8020503@gmx.at>
References: <53FC2D80.7020509@allacher.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 800442615F7
 for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 08:49:43 +0200 (CEST)
Received: from [192.168.0.110] ([82.149.97.137]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0Lj4xG-1WkLRx01hW-00dDA2 for
 <alsa-devel@alsa-project.org>; Tue, 26 Aug 2014 08:49:43 +0200
In-Reply-To: <53FC2D80.7020509@allacher.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is there any reason why the daughterboard does not work yet or hasn't it 
only been tested yet?
Any idea how much work it would be to implement daughterboard support?

Regards,
    Andreas


At Mon, 04 Aug 2014 15:17:55 +0200,
Andreas Allacher wrote:

> At Mon, 04 Aug 2014 15:17:55 +0200,
> Clemens Ladisch wrote:
> >/  
> />/  Just add the PCI ID for the STX II.  It appears to work the same as the
> />/  STX, except for the addition of the not-yet-supported daughterboard.
> />/  
> />/  Tested-by: Mario <fugazzi99 at gmail.com  <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>>
> />/  Tested-by: corubba <corubba at gmx.de  <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>>
> />/  Cc: <stable at vger.kernel.org  <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>>
> />/  Signed-off-by: Clemens Ladisch <clemens at ladisch.de  <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>>
> /
> Applied, thanks.
>
>
> Takashi
>
> >/  ---
> />/   Documentation/sound/alsa/ALSA-Configuration.txt |    4 ++--
> />/   sound/pci/Kconfig                               |    4 ++--
> />/   sound/pci/oxygen/virtuoso.c                     |    1 +
> />/   sound/pci/oxygen/xonar_pcm179x.c                |   12 ++++++++++--
> />/   4 files changed, 15 insertions(+), 6 deletions(-)
> />/  
> />/  diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
> />/  index 7ccf933..48148d6 100644
> />/  --- a/Documentation/sound/alsa/ALSA-Configuration.txt
> />/  +++ b/Documentation/sound/alsa/ALSA-Configuration.txt
> />/  @@ -2026,8 +2026,8 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
> />/     -------------------
> />/  
> />/       Module for sound cards based on the Asus AV66/AV100/AV200 chips,
> />/  -    i.e., Xonar D1, DX, D2, D2X, DS, Essence ST (Deluxe), Essence STX,
> />/  -    HDAV1.3 (Deluxe), and HDAV1.3 Slim.
> />/  +    i.e., Xonar D1, DX, D2, D2X, DS, DSX, Essence ST (Deluxe),
> />/  +    Essence STX (II), HDAV1.3 (Deluxe), and HDAV1.3 Slim.
> />/  
> />/       This module supports autoprobe and multiple cards.
> />/  
> />/  diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
> />/  index 3a3a3a7..50dd008 100644
> />/  --- a/sound/pci/Kconfig
> />/  +++ b/sound/pci/Kconfig
> />/  @@ -858,8 +858,8 @@ config SND_VIRTUOSO
> />/   	select SND_JACK if INPUT=y || INPUT=SND
> />/   	help
> />/   	  Say Y here to include support for sound cards based on the
> />/  -	  Asus AV66/AV100/AV200 chips, i.e., Xonar D1, DX, D2, D2X, DS,
> />/  -	  Essence ST (Deluxe), and Essence STX.
> />/  +	  Asus AV66/AV100/AV200 chips, i.e., Xonar D1, DX, D2, D2X, DS, DSX,
> />/  +	  Essence ST (Deluxe), and Essence STX (II).
> />/   	  Support for the HDAV1.3 (Deluxe) and HDAV1.3 Slim is experimental;
> />/   	  for the Xense, missing.
> />/  
> />/  diff --git a/sound/pci/oxygen/virtuoso.c b/sound/pci/oxygen/virtuoso.c
> />/  index 64b9fda..dbbbacf 100644
> />/  --- a/sound/pci/oxygen/virtuoso.c
> />/  +++ b/sound/pci/oxygen/virtuoso.c
> />/  @@ -53,6 +53,7 @@ static DEFINE_PCI_DEVICE_TABLE(xonar_ids) = {
> />/   	{ OXYGEN_PCI_SUBID(0x1043, 0x835e) },
> />/   	{ OXYGEN_PCI_SUBID(0x1043, 0x838e) },
> />/   	{ OXYGEN_PCI_SUBID(0x1043, 0x8522) },
> />/  +	{ OXYGEN_PCI_SUBID(0x1043, 0x85f4) },
> />/   	{ OXYGEN_PCI_SUBID_BROKEN_EEPROM },
> />/   	{ }
> />/   };
> />/  diff --git a/sound/pci/oxygen/xonar_pcm179x.c b/sound/pci/oxygen/xonar_pcm179x.c
> />/  index c8c7f2c..e026059 100644
> />/  --- a/sound/pci/oxygen/xonar_pcm179x.c
> />/  +++ b/sound/pci/oxygen/xonar_pcm179x.c
> />/  @@ -100,8 +100,8 @@
> />/    */
> />/  
> />/   /*
> />/  - * Xonar Essence ST (Deluxe)/STX
> />/  - * -----------------------------
> />/  + * Xonar Essence ST (Deluxe)/STX (II)
> />/  + * ----------------------------------
> />/    *
> />/    * CMI8788:
> />/    *
> />/  @@ -1138,6 +1138,14 @@ int get_xonar_pcm179x_model(struct oxygen *chip,
> />/   		chip->model.resume = xonar_stx_resume;
> />/   		chip->model.set_dac_params = set_pcm1796_params;
> />/   		break;
> />/  +	case 0x85f4:
> />/  +		chip->model = model_xonar_st;
> />/  +		/* TODO: daughterboard support */
> />/  +		chip->model.shortname = "Xonar STX II";
> />/  +		chip->model.init = xonar_stx_init;
> />/  +		chip->model.resume = xonar_stx_resume;
> />/  +		chip->model.set_dac_params = set_pcm1796_params;
> />/  +		break;
> />/   	default:
> />/   		return -EINVAL;
> />/   	}
> />/  /
