From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [Resend PATCH v3 2/4] ARM: at91: atmel-ssc: add device tree
 support
Date: Wed, 7 Nov 2012 09:47:33 +0100
Message-ID: <20121107084733.GD20063@game.jcrosoft.org>
References: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
 <20121107082419.GB12323@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20121107082419.GB12323@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, fengguang.wu@intel.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 09:24 Wed 07 Nov     , Mark Brown wrote:
> On Wed, Nov 07, 2012 at 11:41:41AM +0800, Bo Shen wrote:
> > Add atmel-ssc for device tree support
> > 
> > Match "atmel,at91rm9200-ssc" for using pdc for data transfer
> > Match "atmel,at91sam9g45-ssc" for using dma for data transfer
> 
> Applied, thanks.

Mark I nack the patch series this patch series does not run on any DT kernel

as no picntrl is done

do not apply until this patfh handle the pinctrl

Best Regards,
J.
