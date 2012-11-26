From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 0/2] ARM/ASoC: Davinci: Device Tree Update
Date: Mon, 26 Nov 2012 11:41:43 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EAD78D4@DBDE01.ent.ti.com>
References: <1353557099-21599-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1353557099-21599-1-git-send-email-gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Rajashekhara,
 Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "Girdwood, Liam" <lrg-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Mark,

On Thu, Nov 22, 2012 at 09:34:57, Hebbar, Gururaja wrote:
> From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
> 
> 1. Add pinctrl for McASP Module
> 2. Add DT support for Davinci machine platform (resend)
> 
> Second commit is a resend after re-basing on latest broonie-asoc/for-next
> (v3.7-rc6)
> 
> Hebbar, Gururaja (2):
>   ASoC: davinci-mcasp: Add pinctrl support
>   ASoC: Davinci: machine: Add device tree binding

With these 2 patches, DT support for Davinci ASoC will be complete 
(well almost because edma dt binding is yet to be added). 
However it will at least be complete on Davinci platform.

Can you please review them and if it's OK, Could you please accept this series?

> 
>  .../bindings/sound/davinci-evm-audio.txt           |   66 +++++++
>  sound/soc/davinci/davinci-evm.c                    |  185 +++++++++++++++++---
>  sound/soc/davinci/davinci-mcasp.c                  |    7 +
>  3 files changed, 238 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt
> 
> -- 
> 1.7.9.5
> 
> 


Regards, 
Gururaja
