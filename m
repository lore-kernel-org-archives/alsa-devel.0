From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [patch 4/5] orion/kirkwood: Add i2s support
Date: Tue, 25 May 2010 20:31:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005252025210.24526@xanadu.home>
References: <20100525122236.841941526@mandriva.com>
	<20100525122341.443140710@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20100525122341.443140710@mandriva.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnaud Patard <apatard@mandriva.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, 25 May 2010, apatard@mandriva.com wrote:

> This patch enables support for the i2s controller available on orion/kirkwood platforms
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

The actual Orion processor family has no I2S/audio support.  It would be 
better if all the audio related stuff was renamed to "kirkwood" and 
"KIRKWOOD_*" instead.

> Index: sound-2.6/sound/soc/orion/Kconfig
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ sound-2.6/sound/soc/orion/Kconfig	2010-05-25 10:31:24.601080937 +0200
> @@ -0,0 +1,11 @@
> +config SND_ORION_SOC
> +	tristate "SoC Audio for the Marvell Orion/Kirkwood chip"
> +	depends on ARCH_KIRKWOOD || ARCH_ARCH_ORION5X

ARCH_ARCH_ORION5X should probably be ARCH_ORION5X.  But again, this is 
wrong to add ARCH_ORION5X anyway.


Nicolas
