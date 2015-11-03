From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] mfd: arizona: Add DT binding for
	irq-gpios property
Date: Tue, 3 Nov 2015 16:52:47 +0000
Message-ID: <20151103165247.GC2549@ck-lbox>
References: <1446559806-3315-1-git-send-email-sjan@baylibre.com>
 <20151103150450.GP20228@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C8FD326044E
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 18:08:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151103150450.GP20228@sirena.org.uk>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Sebastien Jan <sjan@baylibre.com>, patches@opensource.wolfsonmicro.com, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 03, 2015 at 03:04:50PM +0000, Mark Brown wrote:
> On Tue, Nov 03, 2015 at 03:10:06PM +0100, Sebastien Jan wrote:
> 
> > +  - irq-gpios : GPIO specifier for the GPIO connected to /IRQ
> 
> The platform data this is providing is essentially a workaround for the
> lack of an irq_to_gpio() function and the use of it is a workaround for
> the lack of level triggered IRQ emulation in genirq...  do we really
> want this in the ABI (especially as a generic thing)?

Personally I would rather not add this to the DT unless we really
had to.

Also are you sure this is necessary on your system? Specifically
you only need this entry if the CODEC is connected to an IRQ line
that only supports edge triggered IRQs.

Thanks,
Charles
