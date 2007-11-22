From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: S3C2412 IIS driver
Date: Thu, 22 Nov 2007 13:06:19 +0000
Message-ID: <20071122130619.GA5494@sirena.org.uk>
References: <20071120114218.GA19373@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 387262454D
	for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2007 11:17:59 +0100 (CET)
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.63)
	(envelope-from <broonie@sirena.org.uk>) id 1IvVbi-0006QD-PB
	for alsa-devel@alsa-project.org; Fri, 23 Nov 2007 10:17:58 +0000
Resent-Message-ID: <20071123101758.GA22760@sirena.org.uk>
Resent-To: alsa-devel@alsa-project.org
Content-Disposition: inline
In-Reply-To: <20071120114218.GA19373@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: Liam Girwood <liam.girdwood@opensource.wolfsonmicro.com>, ALSA Devel List <alsa-devel@alsa-project.org>, Vincent Sanders <vince@simtec.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2007 at 11:42:18AM +0000, Ben Dooks wrote:

> S3C2412 SoC IIS support for ALSA/ASoC
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Looks good, thanks - I've applied this to the linux-2.6-asoc tree with
some minor checkpatch.pl cleanups (everything except the line lengths).

I did notice these:

> +#define bit_set(v,b) (((v) & (b)) ? 1 : 0)

> +#define ABS(x) (((x) < 0) ? (-(x)) : (x))

which look like they ought to be hoisted out into generic code.
