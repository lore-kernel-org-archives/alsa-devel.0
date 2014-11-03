From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH] audio: sai: Add Power Management support
Date: Mon, 3 Nov 2014 02:35:44 +0000
Message-ID: <7faebd6fe4b44e67b7b0c4e0289b0334@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1414552896-20797-1-git-send-email-b18965@freescale.com>
 <20141029113634.GF18557@sirena.org.uk>
 <718ee124537a4f4091bdf5242d256705@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <20141030112243.GV18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0118.outbound.protection.outlook.com [157.56.111.118])
 by alsa0.perex.cz (Postfix) with ESMTP id C784A260448
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 03:35:47 +0100 (CET)
In-Reply-To: <20141030112243.GV18557@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Huan Wang <alison.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,



> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, October 30, 2014 7:23 PM
> To: Xiubo Li-B47053
> Cc: Wang Huan-B18965; alsa-devel@alsa-project.org; tiwai@suse.de; linux-
> kernel@vger.kernel.org; lgirdwood@gmail.com; perex@perex.cz; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH] audio: sai: Add Power Management support
> 
> On Thu, Oct 30, 2014 at 03:30:40AM +0000, Li.Xiubo@freescale.com wrote:
> 
> > One more thing, if the device is not performance critical, then shouldn't we
> > Take care of the cache memory consumption to determine using flat or rbtree
> > Type ?
> 
> Yes, it's always fine to use a rbtree if it makes sense - it was just an
> unusual choice for a device like this that didn't seem to be discussed.
> 
> Depending on the register map a flat cache can actually be more memory
> efficient sometimes since there's some overhead for the rbtree data
> structures, if you've just got one block of registers with no gaps a
> flat cache is going to be a win there.

Yes, so my comprehension of it was right.

Thanks very much,

BRs
Xiubo
