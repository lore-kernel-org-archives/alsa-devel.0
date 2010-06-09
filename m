From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] EP93xx: Add i2s audio support
Date: Wed, 9 Jun 2010 11:17:43 +0100
Message-ID: <20100609101742.GA5618@opensource.wolfsonmicro.com>
References: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55C092457D
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 12:17:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: john.cooper@third-harmonic.com, chasedouglas@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, r&d4@dave-tech.it, hartleys@visionengravers.com, dhuggins@cs.cmu.edu, marshall@coolbananas.co.nz, buytenh@wantstofly.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 08, 2010 at 10:01:09PM +1200, Ryan Mallon wrote:
> Repost of the i2s audio series for ep93xx. Patch 2/3 is unchanged. The
> core support has been modified to move setting of the SPOL and ORIDE
> bits of the i2sclkdiv register, as well as the i2s pin strapping
> configuration, to a new function called ep93xx_i2s_acquire which is
> called from the audio board drivers.

I've now applied both patches.  There was a trivial fixup required for
the clocks due to an add/add overlap with the SPI clock - I think it's
OK but please check.
