From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: PLL computation in TLV320AIC3x SoC driver
Date: Tue, 8 Dec 2009 14:56:06 +0000
Message-ID: <20091208145606.GB10846@rakim.wolfsonmicro.main>
References: <alpine.DEB.2.00.0912081127460.22770@hippogriff.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9274F10384E
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 15:56:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912081127460.22770@hippogriff.cosy.sbg.ac.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 08, 2009 at 12:28:30PM +0100, Peter Meerwald wrote:

> I'm trying to use the SoC TLV320AIC3x codec driver with sysclk 16384000 
> and ran into some problems with setting PLL; below is a patch against 
> linux-2.6-asoc

Please submit patches against the most recent for- branch of

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

You've also forgotten your Signed-off-by.

> further, the original code does not respect the constraints on j (>= 4, <= 
> 55 for d==0) according to the codec's datasheet, and similarly for d!=0

Might be helpful to point out what these constraints are and how the
code fails to respect them - given that your change is a total rewrite
of the relevant code it's not as easy as it might be to spot what's
changed.
