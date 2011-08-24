From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH v2 1/1] ASoC: soc-core: check rate for
	symmetry only when pcm is active
Date: Wed, 24 Aug 2011 18:27:04 +0100
Message-ID: <20110824172703.GF16653@opensource.wolfsonmicro.com>
References: <1314183728-23627-1-git-send-email-b29396@freescale.com>
	<4E5520CE.60204@ti.com> <4E552F5F.9070801@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4E552F5F.9070801@metafoo.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Dong Aisheng <b29396@freescale.com>, Liam Girdwood <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 24, 2011 at 07:05:35PM +0200, Lars-Peter Clausen wrote:

> A more sensible solution would in my opinion be to save the current rate in the
> dai struct itself and not in the pcm struct. Upon opening a stream check for
> cpu and codec DAI whether they require symmetry. If they do and are active
> constraint the rate to DAIs rate. This also ensures that if boths DAIs are
> already active and are running at different rates there will be no valid rate
> for the new stream.

We need to store in all three places I think - the symmetry requirement
can also come from the link itself.  But generally this is what we're
actually looking for, yes.
