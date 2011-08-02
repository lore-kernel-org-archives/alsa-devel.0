From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND] ASoC: sgtl5000: fix cache handling
Date: Wed, 3 Aug 2011 08:52:37 +0900
Message-ID: <20110802235236.GB30717@opensource.wolfsonmicro.com>
References: <1312306939-5140-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1312306939-5140-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Dong Aisheng-B29396 <B29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 02, 2011 at 07:42:19PM +0200, Wolfram Sang wrote:
> Cache handling in this driver is broken. The chip has 16-bit registers, yet the
> register numbers also increase by 2 per register, i.e.  there are only
> even-numbered registers. The cache in this driver, though, simply increments
> register numbers, so it does need some mapping as seen in
> sgtl5000_restore_regs(), note the '>> 1':

Applied, thanks.
