From: Daniel Mack <daniel@caiaq.de>
Subject: Re: IMX31 Audio Driver issue
Date: Mon, 29 Jun 2009 17:47:06 +0200
Message-ID: <20090629154706.GH29236@buzzloop.caiaq.de>
References: <7df11cd50906250152u500a6a06ud7093d996c3e2b67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D6A9B24834
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Jun 2009 17:47:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7df11cd50906250152u500a6a06ud7093d996c3e2b67@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harish Kumar <harishkumarb7@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 25, 2009 at 02:22:14PM +0530, Harish Kumar wrote:
> I am using a imx31 based board from Garz & fricke. I need to configure the
> audio driver from the linux 2.6.23 BSP available. I configured the audio
> driver by selecting the SSI, ALSA & PMIC Audio options in the kernel
> configuration. The PMIC Audio card is listing /proc/asound/cards and all the
> necessary devices are created using the udev available on the rootfs.

The PMIC stuff for MX3 was not yet merged upstream, so what you got is
probably some hackish pieces taken from any of Freescale's BSPs. Very
hard to give any valuable hint, though.

Is anyone working on some clean and sane patches for this hardware?

Daniel
