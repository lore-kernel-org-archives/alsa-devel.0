From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
	Left_J support
Date: Thu, 4 Jun 2009 13:36:32 +0100
Message-ID: <20090604123632.GC11496@sirena.org.uk>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 149DE103919
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 14:36:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 08:33:42PM +0800, Eric Miao wrote:
> Make the pxa I2S configuration generic, add support for Left_J, add
> support for variable frame width like 32fs, 48fs, 64fs and 96fs

I'm OK with this from a code review point of view providing Daniel is
happy from a testing point of view.  I'll need to fire up my Zylonite
and test on that as well - I'll update the machine driver as required
assuming everything works OK.
