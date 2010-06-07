From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH v3 0/3] ep93xx i2s audio
Date: Mon, 7 Jun 2010 14:26:37 +0100
Message-ID: <20100607132634.GE5993@sirena.org.uk>
References: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 106D410388F
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 15:26:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
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
Cc: john.cooper@third-harmonic.com, alsa-devel@alsa-project.org, chasedouglas@gmail.com, buytenh@wantstofly.org, r&d4@dave-tech.it, hartleys@visionengravers.com, dhuggins@cs.cmu.edu, marshall@coolbananas.co.nz, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 04, 2010 at 05:11:22PM +1200, Ryan Mallon wrote:
> The following patch series adds support for i2s audio on the ep93xx,
> with the Snapper CL15 used as an example implementation.

Please do remember to CC maintainers on patches.  I've had to remind you
about this before, it's really not helpful to drop the people you're
expecting to review the patches - it'll tend to delay things or lead to
the patches getting missed.  From a code point of view this looks fine
but we'll need an arch maintainer to sign off on that bit of the code.
I've applied 2/3 since that has no arch/arm elements.
