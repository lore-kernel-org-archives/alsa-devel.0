From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/4] sound/soc/fsl/p1022_ds.c: Add
 of_node_put to avoid memory leak
Date: Wed, 01 Sep 2010 19:49:36 +0100
Message-ID: <1283366976.3081.248.camel@odin>
References: <1283269738-14612-1-git-send-email-julia@diku.dk>
	<1283269738-14612-3-git-send-email-julia@diku.dk>
	<AANLkTinpRVStYfHHaGTyLusMCjMQDH=MvcGVVKaxvHtN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 56FF124445
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Sep 2010 20:49:39 +0200 (CEST)
Received: by wyb32 with SMTP id 32so9323462wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 01 Sep 2010 11:49:39 -0700 (PDT)
In-Reply-To: <AANLkTinpRVStYfHHaGTyLusMCjMQDH=MvcGVVKaxvHtN@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Julia Lawall <julia@diku.dk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-09-01 at 13:39 -0500, Timur Tabi wrote:
> On Tue, Aug 31, 2010 at 10:48 AM, Julia Lawall <julia@diku.dk> wrote:
> > Add a call to of_node_put in the error handling code following a call to
> > of_parse_phandle.
> >
> > This patch also moves the existing call to of_node_put tothe end of the
> > error handling code, to make it possible to jump to of_node_put without
> > doing the other cleanup operations.  These appear to be disjoint
> > operations, so the ordering doesn't matter.
> 
> Acked-by: Timur Tabi <timur@freescale.com>

Acked-by: Liam Girdwood <lrg@slimlogic.uo.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
