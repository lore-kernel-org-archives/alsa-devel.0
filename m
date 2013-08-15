From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/5] ASoC: pxa: pxa-ssp: add DT bindings
Date: Thu, 15 Aug 2013 15:43:14 +0200
Message-ID: <520CDAF2.7010101@gmail.com>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-3-git-send-email-zonque@gmail.com>
 <20130815103358.GY2401@sirena.org.uk> <520CB2B3.9050804@gmail.com>
 <20130815133925.GA30073@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f181.google.com (mail-ea0-f181.google.com
 [209.85.215.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C708261ABC
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 15:43:21 +0200 (CEST)
Received: by mail-ea0-f181.google.com with SMTP id d10so377746eaj.40
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 06:43:21 -0700 (PDT)
In-Reply-To: <20130815133925.GA30073@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, eric.y.miao@gmail.com, arnd@arndb.de, s.neumann@raumfeld.com, haojian.zhuang@linaro.org, rmk+kernel@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 15.08.2013 15:39, Mark Brown wrote:
> On Thu, Aug 15, 2013 at 12:51:31PM +0200, Daniel Mack wrote:
> 
>> Hmm, and you don't like the approach either of having upstream ports and
>> assign users to it via phandles?
> 
> I don't know what that means, sorry.

Well, we have the 'real' devices registered in DT like this:

        ssp0: ssp@41000000 {
                compatible = "mrvl,pxa3xx-ssp";
                reg = <0x41000000 0x40>;
                interrupts = <24>;
                clock-names = "pxa27x-ssp.0";
                dmas = <&dma 13
                        &dma 14>;
                dma-names = "rx", "tx";
        };

And users, in that case, a ssp DAI, just reference a port like so:

        ssp_dai0: ssp_dai@0 {
                compatible = "mrvl,pxa-ssp-dai";
                port = <&ssp0>;
        };

Is that something we can live with?


>> Also note that the last patch in that series ("ASoC: pxa: add DT
>> bindings for pxa2xx-pcm") can be omitted, as Lars pointed out. I'll have
>> to care for a proper solution at some point.
> 
> I applied it since we were already adding a dummy device for the DAI.  I
> can revert it if this work without that.

I'll send a cleanup patch once I have a better solution.



Daniel
