From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: cs42l73: Unify the way to define
 bits of register
Date: Tue, 22 Nov 2011 13:02:26 +0000
Message-ID: <20111122130226.GA21029@opensource.wolfsonmicro.com>
References: <1321603513.7338.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B084A24362
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 14:02:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321603513.7338.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Vinod Koul <vinod.koul@linux.intel.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 18, 2011 at 04:05:13PM +0800, Axel Lin wrote:
> Current code defines some bits with left shift to the proper bit defined in
> datasheet, but some don't.
> Unify the definition with proper left shift and adjust the code accordingly.

applied, thanks.
