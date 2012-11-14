From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/3] ARM: at91: atmel-ssc: add pinctrl support
Date: Wed, 14 Nov 2012 14:30:08 +0800
Message-ID: <50A33A70.1030705@atmel.com>
References: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
 <1352706028-750-2-git-send-email-voice.shen@atmel.com>
 <20121113085052.GR18224@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121113085052.GR18224-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
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
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-sound-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 11/13/2012 16:50, Mark Brown wrote:
> On Mon, Nov 12, 2012 at 03:40:25PM +0800, Bo Shen wrote:
>
>> +				ssc0 {
>> +					pinctrl_ssc0_tx: ssc0_tx-0 {
>> +						atmel,pins =
>> +							<1 16 0x1 0x1	/* PB16 periph A with pull up */
>> +							 1 17 0x1 0x1	/* PB17 periph A with pull up */
>> +							 1 18 0x1 0x1>;	/* PB18 periph A with pull up */
>> +					};
>
> Do we really want the pull ups here?  Normally CMOS devices don't have
> pulls, or the pulls are disabled during normal operation, as otherwise
> when the logic level is different to whatever the pull is doing power is
> wasted driving against the resistor.

After checking with internal, it does not need pull up. I will correct 
this in next version.

Thanks.

Best Regards,
Bo Shen
