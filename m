From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/3] ALSA: ARM: add Raumfeld audio support
Date: Fri, 27 Nov 2009 13:42:21 +0100
Message-ID: <20091127124221.GS14091@buzzloop.caiaq.de>
References: <1259258341-31114-1-git-send-email-daniel@caiaq.de>
	<1259258341-31114-2-git-send-email-daniel@caiaq.de>
	<1259258341-31114-3-git-send-email-daniel@caiaq.de>
	<20091127113449.GB29821@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A4836103952
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 13:42:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091127113449.GB29821@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 27, 2009 at 11:34:49AM +0000, Mark Brown wrote:
> On Thu, Nov 26, 2009 at 06:59:00PM +0100, Daniel Mack wrote:
> 
> > +static struct regulator_consumer_supply audio_va_consumer_supply =
> > +	REGULATOR_SUPPLY("va", "soc-audio.0");
> 
> I hadn't spotted this in your cs4270 patches but the device used should
> be the I2C device, not the soc-audio device.  I'd also expect to see
> this regulator setup done in arch/arm - the stuff I'd expect to see in
> here is the resource claiming stuff.  Having it here is also fine, it's
> just a little surprising.

Ok, all done. See the v3 spin I'll post now.

Thanks,
Daniel
