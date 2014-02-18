From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 000/105] Rename soc_enum.max field
Date: Tue, 18 Feb 2014 10:46:26 -0600
Message-ID: <alpine.DEB.2.02.1402181045360.22940@heelrod>
References: <1392722967-12472-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 64006265282
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 17:46:38 +0100 (CET)
In-Reply-To: <1392722967-12472-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Feb 2014, Takashi Iwai wrote:

> Hi,
>
> this is the first chunk of the whole patch serires, preliminary works
> for renaming the confusing field name and minor clean ups in the
> relevant places.
>
> After this chunk, SOC_ENUM_*_DECL() macro cleanup and the actual fixes
> for the wrong number of enum items will follow.
>
> Then introduce SOC_ENUM_SINGLE_CONST() & co for omitting the explicit
> ARRAY_SIZE() call, and apply it in the later patches.
>
>
> Takashi
>
All Cirrus related patches
Acked-by: Brian Austin <brian.austin@cirrus.com>
