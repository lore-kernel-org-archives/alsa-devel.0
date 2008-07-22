From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/3] ALSA SoC: MPC5200 audio driver
Date: Tue, 22 Jul 2008 12:52:06 +0100
Message-ID: <20080722115205.GA12555@sirena.org.uk>
References: <fa686aa40807212358p17c824ia1d6516a87a7aac1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A9862243A7
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 13:52:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fa686aa40807212358p17c824ia1d6516a87a7aac1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2008 at 12:58:09AM -0600, Grant Likely wrote:

> Here is the latest series for adding MPC5200 I2S and TI AIC26 codec
> support to ALSA SoC.  I believe all the comments are addressed and I
> hope that this series is now ready to be merged.  I would really like
> to see these ones land in 2.6.27.

I added the changes in the following fairly trivial patch series to
these to allow tlv320aic26 build cleanly on my ARM platforms.
