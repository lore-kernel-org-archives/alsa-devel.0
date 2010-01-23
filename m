From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] add simplified versions of widget macros
Date: Sat, 23 Jan 2010 18:51:33 +0000
Message-ID: <20100123185133.GB4174@sirena.org.uk>
References: <Pine.LNX.4.64.1001212046320.9137@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 526BE2443F
	for <alsa-devel@alsa-project.org>; Sat, 23 Jan 2010 19:51:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1001212046320.9137@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 21, 2010 at 09:10:47PM +0100, Guennadi Liakhovetski wrote:
> Many macros from include/sound/soc-dapm.h take an array and a number of 
> elements in it as arguments, whereas most users use static arrays and use 
> "x, ARRAY_SIZE(x)" as arguments. This patch adds simplified versions of 
> those macros, calling ARRAY_SIZE() internally.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

I'll apply both of these, however I think I'll shortly cook up a patch
to switch things around so that the new variant of _PGA becomes the
default since with modern CODECs it's very rare to need the ramping
support for the volumes so the overwhelming majority of PGAs are better
off using the new version.
