From: Inha Song <ideal.song@samsung.com>
Subject: Re: ASoC: CPU DAI samsung-i2s.0 not registered
Date: Thu, 14 Aug 2014 11:28:19 +0900
Message-ID: <20140814112819.07545223@songinha-Samsung-DeskTop-System>
References: <53EC1CAE.7040906@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B101265611
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 04:28:23 +0200 (CEST)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NA900730YV8WU90@mailout1.samsung.com> for
 alsa-devel@alsa-project.org; Thu, 14 Aug 2014 11:28:20 +0900 (KST)
In-reply-to: <53EC1CAE.7040906@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Did you set to i2s0 status?

-> status = "okay";

Best regards,
Inha Song.

On Thu, 14 Aug 2014 12:19:26 +1000
Matt Flax <flatmax@flatmax.org> wrote:

> Hi there,
> 
> Any ideas why this problem is coming up when I try to load a driver ?
> 
> Here is the device tree :
> 
>      i2s0: i2s@03830000 {
>          compatible = "samsung,i2s-v5";
>          reg = <0x03830000 0x100>;
>          dmas = <&pdma0 10
>              &pdma0 9
>              &pdma0 8>;
>          dma-names = "tx", "rx", "tx-sec";
>          clocks = <&clock_audss EXYNOS_I2S_BUS>,
>              <&clock_audss EXYNOS_I2S_BUS>,
>              <&clock_audss EXYNOS_SCLK_I2S>;
>          clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
>          samsung,supports-6ch;
>          samsung,supports-rstclr;
>          samsung,supports-secdai;
>          samsung,idma-addr = <0x03000000>;
>          pinctrl-names = "default";
>          pinctrl-0 = <&i2s0_bus>;
>      };
> 
>      implant: implant@0 {
>              compatible = "bva,implant";
>      };
> 
>      sound {
>          compatible = "bva,implant-bva";
> 
>          samsung,i2s-controller = <&i2s0>;
>          samsung,audio-codec = <&implant>;
>      };
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
