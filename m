From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 3/3] sound/soc/soc-core.c: drop kfree of
 devm_kzalloc's data
Date: Mon, 10 Dec 2012 07:10:16 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1212100709450.2213@localhost6.localdomain6>
References: <1354989680-25794-1-git-send-email-Julia.Lawall@lip6.fr>
 <20121210052334.GI10927@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1-relais-roc.national.inria.fr
 (mail1-relais-roc.national.inria.fr [192.134.164.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B91D265150
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2012 07:10:23 +0100 (CET)
In-Reply-To: <20121210052334.GI10927@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, matthias@kaehlcke.net, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Dec 2012, Mark Brown wrote:

> On Sat, Dec 08, 2012 at 07:01:20PM +0100, Julia Lawall wrote:
>
>> The kfrees were introduced in b761c0ca.
>> I sent this a few months ago, and I still think it should be applied...
>
> I'm missing patches 1 and 2?

Sorry, I just resent the patch as is.  1 and 2 were I guess applied, 
because I odn't findthe problem any more.

julia
