From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH][trivial] ASoC: isabelle: Remove unneeded
 include of version.h
Date: Fri, 10 Aug 2012 20:21:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208102019510.17673@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1208102010480.17673@swampdragon.chaosbits.net>
 <20120810181631.GN24328@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swampdragon.chaosbits.net (1010ds2-suoe.0.fullrate.dk
 [90.184.90.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CA8D2665B3
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 19:52:06 +0200 (CEST)
In-Reply-To: <20120810181631.GN24328@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, trivial@kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Aug 2012, Mark Brown wrote:

> On Fri, Aug 10, 2012 at 08:12:57PM +0200, Jesper Juhl wrote:
> > There is no need to include version.h in sound/soc/codecs/isabelle.c -
> > this patch removes the pointless include.
> 
> Not sure what this patch is against, there appears to be no include of
> version.h in current code...

It's against Linus's tree. I created a branch off of master at 
f4ba394c1b02e7fc2179fda8d3941a5b3b65efb6 and did the patch.

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
