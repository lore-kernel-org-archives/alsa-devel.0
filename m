From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] ARM: davinci: enable SRAM ping ping buffering on DA850
Date: Thu, 8 Nov 2012 15:02:04 +0000
Message-ID: <201211081502.04980.arnd@arndb.de>
References: <1349345745-10584-1-git-send-email-mporter@ti.com> <1349345745-10584-3-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349345745-10584-3-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, gururaja.hebbar@ti.com, Sekhar Nori <nsekhar@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alsa Devel List <alsa-devel@alsa-project.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Ben Gardiner <bengardiner@nanometrics.ca>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 04 October 2012, Matt Porter wrote:
> Passes the DA850 shared SRAM gen_pool to the McASP driver
> and enables the ping-pong buffer DMA support.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---

It seems this is in linux-next now, but the patch it depends on
(ARM: davinci: add platform hook to fetch the SRAM pool) is not.

	Arnd
