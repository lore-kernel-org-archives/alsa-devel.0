From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4] ASoC: samsung updates from arm testing
Date: Sat, 12 Jul 2014 14:35:14 +0200
Message-ID: <201407121435.14947.arnd@arndb.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-2-git-send-email-arnd@arndb.de>
 <20140711135400.GY30458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 68758265086
 for <alsa-devel@alsa-project.org>; Sat, 12 Jul 2014 14:35:19 +0200 (CEST)
In-Reply-To: <20140711135400.GY30458@sirena.org.uk>
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
Cc: t.figa@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Friday 11 July 2014, Mark Brown wrote:
>   On Fri, Jul 11, 2014 at 03:45:03PM +0200, Arnd Bergmann wrote:
> 
> > Here are a few patches from my randconfig and multiplatform series.
> > The smartq patch is a re-send of the one I screwed up the other day.
> > the dependencies and dma data removal should be trivial, the
> > dmaengine one probably needs some closer inspection.
> 
> Hrm, can you check what's going on with the series - I've got two copies
> of patch 2 and an extra patch [PATCH] ASoC: s3c64xx/smartq: use dynamic
> registration which is threaded before this cover letter and looks like a
> resend of the prior copy with the platform_data header missing that got
> included by mistake?  The patches look OK but I just want to make sure
> I'm applying the right things.

It seems I accidentally left the old version of the patch in the directory
I used for sending the patches, so git-send-email was sending both the
old and the new version. Please just disregard the patch named "[PATCH]
ASoC: s3c64xx/smartq: use dynamic registration", the other ones are
those I wanted to send.

	Arnd
