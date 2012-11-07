From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Subject: Re: [Resend PATCH v3 2/4] ARM: at91: atmel-ssc: add device tree
 support
Date: Wed, 7 Nov 2012 16:16:07 +0100
Message-ID: <20121107151607.GC4576@game.jcrosoft.org>
References: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
 <20121107084932.GE20063@game.jcrosoft.org>
 <20121107092124.GE12323@opensource.wolfsonmicro.com>
 <20121107104121.GG20063@game.jcrosoft.org>
 <20121107140535.GA28954@opensource.wolfsonmicro.com>
 <20121107143046.GA4576@game.jcrosoft.org>
 <20121107144450.GF20844@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121107144450.GF20844-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-sound-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 15:44 Wed 07 Nov     , Mark Brown wrote:
> On Wed, Nov 07, 2012 at 03:30:46PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > the one via ASoC for the driver with the pinctrl for now but MUST add it later
> 
> > the arch/arm related via AT91 tree where the pinctrl is mandatory in the dtsi
> 
> > I'm no going to spend hours to do the pinctrl to test Bo patch that he is
> > supposed to have deon to test this code
> 
> > As basically today on DT none of the board will work if BO does no provide the
> > pinctrl so for me he MUST put in the dtsi
> 
> > is it ok with you?
> 
> Or add the pinmux bindings for other IPs over in the pinmux branch and
> the pinmux binding for SSC here (which will help with bisection as the
> DT bindings for the audio will then always exist in conjunction with the
> .dtsi changes for them).  Either way is fine with me; I'll leave things
> as they are until I see some new patches.
for where it's merge honestly I do not care much but the pinctrl must be
handled correctly

Best Regards,
J.
