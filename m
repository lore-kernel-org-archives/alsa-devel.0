From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc register read/write calls
Date: Wed, 24 Nov 2010 12:54:21 +0000
Message-ID: <20101124125421.GB13507@sirena.org.uk>
References: <438BB0150E931F4B9CE701519A44630104BECC82EB@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 13AF010394D
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 13:54:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104BECC82EB@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 24, 2010 at 06:11:51PM +0530, Koul, Vinod wrote:
> Mark,

Please remember to always CC maintainers on posts to the mailing lists.
I've reminded you of this on quite a few previous occasions.

> In the asoc framework, do the codec register read-write calls need to be atomic?
> Will it work in non-atomic context?

There is no requirement for atomic context, in fact vanishingly few
CODECs can be accessed in atomic context as pretty much all of them
are controlled using I2C or SPI.
