From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: codec registers with more than 16 bits.
Date: Thu, 17 Jul 2008 10:33:02 +0100
Message-ID: <20080717093301.GA15333@sirena.org.uk>
References: <487E9AD1.8070301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 61B63103801
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 11:33:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <487E9AD1.8070301@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, openezx-devel <openezx-devel@lists.openezx.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 16, 2008 at 10:05:21PM -0300, Daniel Ribeiro wrote:

> 	Is there any reason to this limit? I am currently faking
> the registers to always fit 16 bits, but this looks ugly.

No reason other than nobody needed it before.

> 	Would a patch to soc-core/dapm to extend this limit to
> 32 bits registers be accepted?

Of course - that'd be great, but note that all the codec drivers will
need updating to match the API change.
