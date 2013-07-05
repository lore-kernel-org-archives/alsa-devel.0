From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: Allow imx-pcm-{dma,fiq}.c to be modules
Date: Fri, 5 Jul 2013 22:55:10 +0200
Message-ID: <201307052255.10765.arnd@arndb.de>
References: <201307051745.16140.arnd@arndb.de>
 <20130705173321.GE27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130705173321.GE27646@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Friday 05 July 2013, Mark Brown wrote:
> On Fri, Jul 05, 2013 at 05:45:15PM +0200, Arnd Bergmann wrote:
> > This is required so we can build the imx sound support
> > when ALSA itself is a loadable module.
> 
> Is this actually OK with the FIQ APIs?
> 

I don't know. Why wouldn't it?

Other users of the same interfaces (mx1_camera, spi-s3c24xx) can also be
modules, so I wouldn't expect a fundamental issue.

	Arnd
