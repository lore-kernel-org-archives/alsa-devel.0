From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] sound/soc/fsl/p1022_ds.c: Add
 of_node_put to avoid memory leak
Date: Thu, 2 Sep 2010 16:30:56 +0100
Message-ID: <20100902153056.GE5809@rakim.wolfsonmicro.main>
References: <1283269738-14612-1-git-send-email-julia@diku.dk>
	<1283269738-14612-3-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B3D424382
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 17:30:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1283269738-14612-3-git-send-email-julia@diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 31, 2010 at 05:48:56PM +0200, Julia Lawall wrote:
> Add a call to of_node_put in the error handling code following a call to
> of_parse_phandle.

Applied, thanks.
