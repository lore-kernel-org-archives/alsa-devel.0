From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: Add CS4271 codec support
Date: Thu, 7 Oct 2010 16:46:20 -0500
Message-ID: <4CAE3FAC.6010508@freescale.com>
References: <4CAD16A5.1090501@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4CAD16A5.1090501@bluewatersys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Ryan Mallon wrote:
> + * For setups with variable MCLKs, pass 0 as 'freq' argument. This will cause
> + * theoretically possible sample rates to be enabled. Call it again with a
> + * proper value set one the external clock is set (most probably you would do
> + * that from a machine's driver 'hw_param' hook.

If you're going to copy/paste parts of my driver verbatim into yours, you should
put something like this in the comments:

	Based on the CS4270 driver by Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
