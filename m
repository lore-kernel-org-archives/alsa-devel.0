From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] beyond ARRAY_SIZE of s3c64xx_i2s
Date: Wed, 20 May 2009 16:14:46 +0100
Message-ID: <20090520151445.GC29689@sirena.org.uk>
References: <4A141D3E.7030609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 92E22245BD
	for <alsa-devel@alsa-project.org>;
	Wed, 20 May 2009 17:14:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A141D3E.7030609@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 20, 2009 at 05:09:50PM +0200, Roel Kluin wrote:
> Do not go beyond ARRAY_SIZE of s3c64xx_i2s
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Looks good, I'll apply this.

> ---
> In this case you are Maintainer, correct?

Yes, for anything in sound/soc.
