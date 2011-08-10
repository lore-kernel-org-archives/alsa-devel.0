From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH] sound/pci/azt3328.c: adjust error handling
 code to include debugging code
Date: Wed, 10 Aug 2011 13:15:42 +0200
Message-ID: <20110810111542.GA5881@rhlx01.hs-esslingen.de>
References: <1312969744-29659-1-git-send-email-julia@diku.dk>
	<s5hk4albni7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B12324646
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 13:15:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk4albni7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lucas De Marchi <lucas.demarchi@profusion.mobi>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Mohr <andi@lisas.de>, Julia Lawall <julia@diku.dk>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Aug 10, 2011 at 11:54:08AM +0200, Takashi Iwai wrote:
> At Wed, 10 Aug 2011 11:49:04 +0200,
> Julia Lawall wrote:
> > 
> > From: Julia Lawall <julia@diku.dk>
> > 
> > snd_azf3328_dbgcallenter is called at the very beginning of the function,
> > so it could be useful to call snd_azf3328_dbgcallleave at all exit points.
> > 
> > Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> Applied now to sound git tree.  Thanks.

5 minutes, 4 seconds. Your responsiveness appears to be degrading. I've
seen better ;)

JFTR:
Acked-by: Andreas Mohr <andi@lisas.de>

Andreas Mohr
