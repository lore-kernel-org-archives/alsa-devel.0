From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Template Based Coefficients Setting for Filters
Date: Tue, 9 Aug 2011 16:16:30 +0100
Message-ID: <20110809151630.GB3429@sirena.org.uk>
References: <1312893236.8316.51.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 53605245DB
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 17:16:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1312893236.8316.51.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 09, 2011 at 06:03:56PM +0530, Ashish Chavan wrote:

>    I am working on updating ASoC codec driver for Dialog's DA7210 codec
> (sound/soc/codec/da7210.c). This update would be a major functionality
> update in nature. Currently, I am implementing support for GP (general
> purpose) filters of this codec and need some opinions/comments.

Use _BYTES controls for this.  There are no existing users in ASoC,
though there should be shortly and there are generic ALSA examples.
