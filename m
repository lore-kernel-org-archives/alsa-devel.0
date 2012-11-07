From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [Resend PATCH v3 2/4] ARM: at91: atmel-ssc: add device tree
 support
Date: Wed, 7 Nov 2012 09:49:32 +0100
Message-ID: <20121107084932.GE20063@game.jcrosoft.org>
References: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, fengguang.wu@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 11:41 Wed 07 Nov     , Bo Shen wrote:
> Add atmel-ssc for device tree support
> 
> Match "atmel,at91rm9200-ssc" for using pdc for data transfer
> Match "atmel,at91sam9g45-ssc" for using dma for data transfer
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Resend
>   Fix a error find by Fengguang Yu
> 
>   Although there is a NACK from Jean-Christophe PLAGNIOL-VILLARD,
>   however the pinctrl for at91 is not in mainline. So, plan to add
>   pinctrl support after the pinctrl driver for at91 is merged.
yes the pinctrl is mainline in -next via pinctrl tree

s code does not work on the DT kernel untill it's done

NACK stand I refuse this touch the at91 dtsi untiol it's done correctly

Best Regards,
J.
