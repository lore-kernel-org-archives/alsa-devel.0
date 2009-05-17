From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: AC97 reset fail after suspend
Date: Sun, 17 May 2009 22:14:01 +0000 (UTC)
Message-ID: <guq279$iv5$1@ger.gmane.org>
References: <200905080148.20137.sleep_walker@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tomas 'Sleep_Walker' Cech wrote:

> Hi,
> 
> I've got following error on Palm LifeDrive and PalmTX after suspend &
> resume:
> 
> pxa2xx_ac97_try_warm_reset: warm reset timeout (GSR=0x0)
> pxa2xx_ac97_read: read error (ac97_reg=0 GSR=0x0)
> pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)
> pxa2xx_ac97_read: read error (ac97_reg=0 GSR=0x44) WM9712 AC97 reset
> failed
> could not reset AC97 codec

Could you please check if changing reset_gpio to 113 inside
palmXX_ac97_pdata declarations in palmld and palmtx board files helps.

-- 
With best wishes
Dmitry



-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
