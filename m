From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 2/2] ASoC: cs35l36: Add device tree
 documentation for CS35L36
Date: Wed, 12 Dec 2018 16:55:34 +0000
Message-ID: <20181212165534.GR16508@imbe.wolfsonmicro.main>
References: <1544130287-7303-1-git-send-email-james.schulman@cirrus.com>
 <1544130287-7303-2-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 628C1267C35
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2018 17:55:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1544130287-7303-2-git-send-email-james.schulman@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Schulman <james.schulman@cirrus.com>
Cc: mark.rutland@arm.com, brian.austin@cirrus.com, alsa-devel@alsa-project.org, paul.handrigan@cirrus.com, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 06, 2018 at 03:04:47PM -0600, James Schulman wrote:
> Add device tree documentation for Cirrus Logic CS35L36
> speaker amplifier
> 
> Signed-off-by: James Schulman <james.schulman@cirrus.com>
> ---
> +Optional properties for the "cirrus,irq-config" Sub-node
> +
> +  - cirrus,irq-drive-select : Selects the driver type of the selected interrupt
> +  output.
> +
> +  0 = Open-drain
> +  1 = Push-pull (Default)
> +
> +  - cirrus,irq-polarity : Selects the polarity of the selected interrupt output
> +  when in push-pull mode. Note - when the selected interrupt output is in
> +  open-drain mode, INT_POL_SEL must be set to 0.
> +
> +  0 = Active-low (Default)
> +  1 = Active-high
> +

Does this device tree entry in your example:

  interrupts = <3 IRQ_TYPE_LEVEL_LOW>;

Not already convey what polarity you require? Adding a separate
entry seems unnecessary.


> +  - cirrus,irq-gpio-select : Selects the pin to serve as the programmable
> +  interrupt output.
> +
> +  0 = PDM_DATA / SWIRE_SD / INT (Default)
> +  1 = GPIO
> +
> +  - cirrus,irq-output-enable : Enables or disables the selected interrupt output
> +
> +  0 = Disabled (Default)
> +  1 = Enabled
> +

Likewise here doesn't the presence/absence of the interrupts
entry convey whether you want the IRQ enabled?

> +  - cirrus,irq-src-select : Selects the source of the selected interrupt output.
> +
> +  0 = PAC-based interrupt output
> +  1 = Interrupt handler (Default)
> +

Is there a use-case for this at the moment? This feels like it
might be worth dropping until it is necessary.

Thanks,
Charles
