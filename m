From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 6/9] ASoC: da7210: bugfix for head phone
 volume control
Date: Wed, 12 Oct 2011 16:01:02 +0100
Message-ID: <20111012150101.GS3647@opensource.wolfsonmicro.com>
References: <1318431934.12107.421.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F18424517
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 17:01:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318431934.12107.421.camel@matrix>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg@ti.com, kuninori.morimoto.gx@renesas.com, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 12, 2011 at 08:35:34PM +0530, Ashish Chavan wrote:
> This patch takes care of reserved bits of headphone volume
> register by using correct volume range.

This doesn't apply, which is pretty surprising given that there's no
obvious overlap at all with the rest of the code.

> Tested on Samsung SMDK6410 board with DA7210 evaluation board.

This really isn't useful information in a changelog, apart from anything
else this isn't going to be a system that it's easy for other people to
reproduce.
