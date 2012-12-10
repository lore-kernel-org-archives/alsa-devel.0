From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] sound/soc/soc-core.c: drop kfree of
 devm_kzalloc's data
Date: Mon, 10 Dec 2012 16:09:28 +0900
Message-ID: <20121210070927.GK10927@opensource.wolfsonmicro.com>
References: <1354989680-25794-1-git-send-email-Julia.Lawall@lip6.fr>
 <20121210052334.GI10927@opensource.wolfsonmicro.com>
 <alpine.DEB.2.02.1212100709450.2213@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 358D52602AE
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2012 08:09:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1212100709450.2213@localhost6.localdomain6>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, matthias@kaehlcke.net, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 10, 2012 at 07:10:16AM +0100, Julia Lawall wrote:

> Sorry, I just resent the patch as is.  1 and 2 were I guess applied,
> because I odn't findthe problem any more.

It looks like this is what happened the first time round as well - I
only got patch 3 but it was flagged as part of a three patch series.
Please don't do things like this, it makes the patch look like part of a
series which has already been applied but didn't get deleted when it's
sitting in an inbox.
